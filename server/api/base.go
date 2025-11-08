package api

import (
	"encoding/json"
	"io"
	"net/http"

	"github.com/dghwood/resonate/server/auth"
	"github.com/dghwood/resonate/server/errors"
	"github.com/dghwood/resonate/server/log"
	"github.com/dghwood/resonate/server/models"
	"github.com/dghwood/resonate/server/proto"
	pb "google.golang.org/protobuf/proto"
)

type ApiRequestInterface interface {
	pb.Message
	GetRequestInfo() *proto.RequestInfo
}

type ApiResponseInterface interface {
	pb.Message
	GetResponseInfo() *proto.ResponseInfo
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
func handle[
	request ApiRequestInterface,
	response ApiResponseInterface](
	f ApiInterface[request, response]) func(w http.ResponseWriter, r *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		// CORs headers
		w.Header().Set("Access-Control-Allow-Origin", "*")
		w.Header().Set("Access-Control-Allow-Methods", "POST, GET, OPTIONS")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type")
		if r.Method == "OPTIONS" {
			return
		}
		log.Info(r.URL.Path)

		// TODO(duncan): Remove
		// Add some delay, in dev the server is responding too
		// quickly
		// time.Sleep(2 * time.Second)

		request := f.RequestProto()
		err := parseProto(r, request)
		if err != nil {
			log.Error(err)
			return
		}

		response := f.ResponseProto()

		requestInfo := request.GetRequestInfo()
		token := requestInfo.GetAccessToken()
		userId, err := auth.ValidUserIdFromToken(token)

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
			Token:      token,
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
			response.GetResponseInfo().Success = true
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
