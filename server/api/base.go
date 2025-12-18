package api

import (
	"encoding/json"
	"io"
	"net/http"

	"github.com/dghwood/resonate/auth"
	"github.com/dghwood/resonate/errors"
	"github.com/dghwood/resonate/log"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
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
	Execute(user *models.LoggedInUser, request request, response response) error
	RequestProto() request
	ResponseProto() response
	RequireSignIn() bool
}

func returnError[R ApiResponseInterface](
	r *http.Request,
	w http.ResponseWriter,
	err errors.Error,
	response R) {
	response.GetResponseInfo().Error = err.Enum
	writeProto(r, w, response)
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
			// Have this last ~forever
			MaxAge: 3600 * 24 * 365 * 100,
		})

		// Set another non-http cookie just to check if this exists in the
		// front end on web.
		http.SetCookie(w, &http.Cookie{
			Name:   "Access-Token-Available",
			Value:  "true",
			MaxAge: 3600 * 24 * 365 * 100,
			Path:   "/api",
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
			Path:     "/api/login",
			// Have this last ~forever
			MaxAge: 3600 * 24 * 365 * 100,
		})

		// Set another non-http cookie just to check if this exists in the
		// front end on web.
		http.SetCookie(w, &http.Cookie{
			Name:   "Refresh-Token-Available",
			Value:  "true",
			MaxAge: 3600 * 24 * 365 * 100,
			Path:   "/api",
		})
	}
}

func handle[
	request ApiRequestInterface,
	response ApiResponseInterface](
	f ApiInterface[request, response]) func(w http.ResponseWriter, r *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		// CORs headers
		w.Header().Set("Access-Control-Allow-Origin", "https://app.resonate.xyz")
		w.Header().Set("Access-Control-Allow-Credentials", "true")
		w.Header().Set("Access-Control-Allow-Methods", "POST, GET, OPTIONS")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type")

		if r.Method == "OPTIONS" {
			return
		}
		log.Info(r.URL.Path)

		request := f.RequestProto()
		err := parseProto(r, request)
		if err != nil {
			log.Error(err)
			return
		}

		response := f.ResponseProto()
		requestInfo := request.GetRequestInfo()
		populateInternalInfo(r, requestInfo)
		userId, err := auth.ValidUserIdFromToken(requestInfo.GetInternalInfo().GetAccessToken())

		if f.RequireSignIn() && err != nil {
			log.Error("error logging in: ", err)
			returnErr := errors.ERROR_INTERNAL
			if errors.Is(err, errors.ERROR_TIME_EXPIRED) {
				returnErr = errors.ERROR_TIME_EXPIRED
			}
			returnError(r, w, returnErr, response)
			return
		}

		// Only construct this for signed in?
		user := models.LoggedInUser{
			UserMessage: proto.UserMessage{
				Id: userId,
			},
			IsLoggedIn: err == nil,
		}

		err = f.Execute(&user, request, response)

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
		json.NewEncoder(w).Encode(response)
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
