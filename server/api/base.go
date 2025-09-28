package api

import (
	"encoding/json"
	"io"
	"log"
	"net/http"

	"github.com/dghwood/resonate/auth"
	"github.com/dghwood/resonate/errors"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
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

func Attach[request ApiRequestInterface, response ApiResponseInterface](
	f ApiInterface[request, response], path string) {
	http.HandleFunc(path,
		func(w http.ResponseWriter, r *http.Request) {
			request := f.RequestProto()
			parseProto(r, request)
			response := f.ResponseProto()

			token := request.GetRequestInfo().AccessToken
			userId, err := auth.ValidUserIdFromToken(token)

			if f.RequireSignIn() && err != nil {
				log.Println(err)
				if errors.Is(err, errors.ERROR_TIME_EXPIRED) {
					response.GetResponseInfo().Error = errors.ERROR_TIME_EXPIRED.Enum
					writeProto(r, w, response)
					return
				}
				response.GetResponseInfo().Error = errors.ERROR_INTERNAL.Enum
				writeProto(r, w, response)
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
				log.Println(err)
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
		})
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
		log.Printf("failed to marshal response")
	}
	w.Header().Set("Content-Type", "application/x-protobuf")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Write(responseBytes)
}

func parseProto(r *http.Request, request pb.Message) {
	reqBytes, err := io.ReadAll(r.Body)
	if err != nil {
		log.Print(err)
	}
	log.Println(request)
	err = pb.Unmarshal(reqBytes, request)
	if err != nil {
		log.Print("PARSE ERR", err)
	}
}
