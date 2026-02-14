package api

import (
	"context"
	"fmt"

	// "encoding/json"
	"io"
	"net/http"
	"regexp"
	"strconv"

	json "google.golang.org/protobuf/encoding/protojson"

	"github.com/dghwood/resonate/auth"
	"github.com/dghwood/resonate/errors"
	"github.com/dghwood/resonate/flags"
	"github.com/dghwood/resonate/log"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/utils"
	pb "google.golang.org/protobuf/proto"
)

type ApiRequestInterface interface {
	pb.Message
	GetRequestInfo() *proto.RequestInfo
	SetRequestInfo(requestInfo *proto.RequestInfo)
}

type ApiResponseInterface interface {
	pb.Message
	GetResponseInfo() *proto.ResponseInfo
	SetResponseInfo(responseInfo *proto.ResponseInfo)
}

type ApiExecuteData struct {
	Request  ApiRequestInterface
	Response ApiResponseInterface
	User     *models.LoggedInUser
}

type ApiInterface[request ApiRequestInterface, response ApiResponseInterface] interface {
	// Execute(data ApiExecuteData) error
	Execute(ctx context.Context, user *models.LoggedInUser, request request, response response) error
	RequestProto() request
	ResponseProto() response
	RequireSignIn() bool
}

func writeEventMessage(apiEventMessage *proto.ApiEventMessage) {
	apiEventMessage.SetResponseTimestampUsec(utils.NowUsec())
	// Clear internal info before logging, since it's mainly auth tokens
	apiEventMessage.GetRequestInfo().ClearInternalInfo()
	options := json.MarshalOptions{
		UseProtoNames:  true,
		UseEnumNumbers: true,
	}
	// TODO(duncan): This is really annoying, but for int64 this emits
	//               strings rather than ints.
	eventMessage, jsonErr := options.Marshal(apiEventMessage)
	if jsonErr != nil {
		log.Error(jsonErr)
		return
	}
	fmt.Println(string(eventMessage))
}
func returnError[R ApiResponseInterface](
	r *http.Request,
	w http.ResponseWriter,
	err errors.Error,
	apiEventMessage *proto.ApiEventMessage,
	response R) {

	response.GetResponseInfo().SetError(err.Enum)
	response.GetResponseInfo().SetErrorMessage(err.Message)

	writeProto(r, w, response)
	writeEventMessage(apiEventMessage)
}

func populateInternalInfo(r *http.Request, requestInfo *proto.RequestInfo) {
	log.Info("Cookies: ", r.Cookies())
	internalInfo := &proto.InternalInfo{}
	requestInfo.SetInternalInfo(internalInfo)
	// What about refresh cookie
	if tokenCookie, tokenErr := r.Cookie("Access-Token"); tokenErr == nil {
		token := models.NewToken()
		token.FromHttpCookie(tokenCookie)
		internalInfo.SetAccessToken(token.TokenMessage)
	}
	if tokenCookie, tokenErr := r.Cookie("Refresh-Token"); tokenErr == nil {
		token := models.NewToken()
		token.FromHttpCookie(tokenCookie)
		internalInfo.SetRefreshToken(token.TokenMessage)
	}
}

func writeInternalInfo(internalInfo *proto.InternalInfo, w http.ResponseWriter) {
	if internalInfo == nil {
		return
	}
	log.Info("internalInfo", internalInfo)
	accessToken := internalInfo.GetAccessToken()
	if accessToken != nil {
		token := &models.Token{}
		token.FromTokenMessage(accessToken)
		http.SetCookie(w, &http.Cookie{
			Name:     "Access-Token",
			Value:    token.ToTokenString(),
			HttpOnly: true,
			Path:     "/api",
			Secure:   true,
			// Have this last ~forever
			MaxAge: 3600 * 24 * 365 * 100,
		})

		// Set another non-http cookie just to check if this exists in the
		// front end on web.
		http.SetCookie(w, &http.Cookie{
			Name:  "Access-Token-Available",
			Value: "true",
			// Secure: true,
			MaxAge: 3600 * 24 * 365 * 100,
			Path:   "/", // Keep this generic so I can read it
		})
	}
	refreshToken := internalInfo.GetRefreshToken()
	if refreshToken != nil {
		token := &models.Token{}
		token.FromTokenMessage(refreshToken)
		http.SetCookie(w, &http.Cookie{
			Name:     "Refresh-Token",
			Value:    token.ToTokenString(),
			HttpOnly: true,
			Secure:   true,
			Path:     "/api/login",
			// Have this last ~forever
			MaxAge: 3600 * 24 * 365 * 100,
		})

		// Set another non-http cookie just to check if this exists in the
		// front end on web.
		http.SetCookie(w, &http.Cookie{
			Name:  "Refresh-Token-Available",
			Value: "true",
			// Secure: true,
			MaxAge: 3600 * 24 * 365 * 100,
			Path:   "/",
		})
	}
}

func isAppVersionValid(version string, lowestVersion int) (valid bool) {
	// Version info is of the form 1.0.1+2
	// Where +2 will be a number that increments
	if version == "" {
		return
	}
	// Extract regex
	pattern := regexp.MustCompile(`\d+\.\d+\.\d+\+(\d+)`)
	matches := pattern.FindStringSubmatch(version)
	if matches == nil {
		return
	}
	versionNum, err := strconv.Atoi(matches[1])
	if err != nil {
		return
	}
	if versionNum < lowestVersion {
		return
	}
	return true
}

func handle[
	request ApiRequestInterface,
	response ApiResponseInterface](
	f ApiInterface[request, response]) func(w http.ResponseWriter, r *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		// CORs headers
		w.Header().Set("Access-Control-Allow-Origin", "https://app.resonates.xyz")
		w.Header().Set("Access-Control-Allow-Credentials", "true")
		w.Header().Set("Access-Control-Allow-Methods", "POST, GET, OPTIONS")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type")

		if r.Method == "OPTIONS" {
			return
		}
		log.Info(r.URL.Path)

		request := f.RequestProto()
		response := f.ResponseProto()
		err := parseProto(r, request)
		if err != nil {
			log.Error(err)
			// Return an error?
			return
		}

		apiEventMessage := &proto.ApiEventMessage{
			ApiPath:       r.URL.Path,
			TimestampUsec: utils.NowUsec(),
			TraceId:       r.Header.Get("X-Cloud-Trace-Context"),
			Ips:           r.Header.Get("X-Forwarded-For"),
			RequestInfo:   request.GetRequestInfo(),
			ResponseInfo:  response.GetResponseInfo(),
			// BinaryVersion: flags.FLAGS.Version,
		}

		requestInfo := request.GetRequestInfo()
		// Check if app is an old version

		if !isAppVersionValid(
			requestInfo.GetClientVersion(),
			flags.FLAGS.LowestCompatibleClientVersion) {
			log.Error(errors.ERROR_UPDATE_CLIENT_REQUIRED)
			returnError(r, w, errors.ERROR_UPDATE_CLIENT_REQUIRED, apiEventMessage, response)
			return
		}
		populateInternalInfo(r, requestInfo)
		userId, err := auth.ValidUserIdFromToken(requestInfo.GetInternalInfo().GetAccessToken())

		if f.RequireSignIn() && err != nil {
			log.Error("error logging in: ", err)
			returnErr := errors.ERROR_INTERNAL
			if errors.Is(err, errors.ERROR_TIME_EXPIRED) {
				returnErr = errors.ERROR_TIME_EXPIRED
			}
			returnError(r, w, returnErr, apiEventMessage, response)
			return
		}

		// Only construct this for signed in?
		user := models.LoggedInUser{
			UserMessage: proto.UserMessage{
				Id: userId,
			},
			IsLoggedIn: err == nil,
		}

		err = f.Execute(r.Context(), &user, request, response)

		if err != nil {
			log.Error(err)
			if appErr, ok := err.(errors.Error); ok {
				response.GetResponseInfo().Error = appErr.Enum
			} else {
				response.GetResponseInfo().Error = errors.ERROR_INTERNAL.Enum
				// TODO(duncan): Remove this?
				response.GetResponseInfo().ErrorMessage = err.Error()
			}
		} else {
			// Deal with cookies
			responseInfo := response.GetResponseInfo()
			writeInternalInfo(responseInfo.GetInternalInfo(), w)
			// Clear this before responding
			responseInfo.ClearInternalInfo()
			response.GetResponseInfo().SetSuccess(true)
		}
		writeProto(r, w, response)

		// Logging for API Event Message
		writeEventMessage(apiEventMessage)
	}
}
func Attach[request ApiRequestInterface, response ApiResponseInterface](
	f ApiInterface[request, response], path string) {
	http.HandleFunc(path, handle(f))
}

func writeProto(
	r *http.Request,
	w http.ResponseWriter,
	response pb.Message) {
	if r.URL.Query().Has("json") {
		w.Header().Set("Content-Type", "application/json")
		jsonResponse, err := json.Marshal(response)
		if err != nil {
			log.Error("failed to marshal response", err)
		}
		w.Write(jsonResponse)
		// json.NewEncoder(w).Encode(response)
		return
	}
	responseBytes, err := pb.Marshal(response)
	if err != nil {
		log.Error("failed to marshal response", err)
	}
	w.Header().Set("Content-Type", "application/x-protobuf")
	w.Write(responseBytes)
}

func parseProto(r *http.Request, request pb.Message) (err error) {
	reqBytes, err := io.ReadAll(r.Body)
	if err != nil {
		return
	}
	err = pb.Unmarshal(reqBytes, request)
	if err != nil {
		return
	}
	return
}
