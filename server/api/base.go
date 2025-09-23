package api

import (
	"encoding/json"
	"io"
	"log"
	"net/http"

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

type ApiInterface[request ApiRequestInterface, response ApiResponseInterface] interface {
	Execute(request request, response response) error
	RequestProto() request
	ResponseProto() response
	RequireSignIn() bool
}

// func Attach[request pb.Message, response pb.Message](
// 	auth auth.Auth, f ApiInterface[request, response], path string) {
// 	http.HandleFunc(path, func(w http.ResponseWriter, r *http.Request) {
// 		token := r.Header.Get("Authorization")
// 		user, err := auth.GetUser(token)
// 		if err != nil {
// 			// TODO(duncan): Better error handling..
// 			http.Error(w, err.Error(), http.StatusUnauthorized)
// 			return
// 		}
// 		request := f.RequestProto()
// 		parseProto(r, request)
// 		response := f.ResponseProto()
// 		err = f.Execute(&user, request, response)
// 		if err != nil {
// 			log.Println(err)
// 		}
// 		writeProto(r, w, response)
// 	})
// }

func Attach[request ApiRequestInterface, response ApiResponseInterface](
	f ApiInterface[request, response], path string) {
	http.HandleFunc(path,
		func(w http.ResponseWriter, r *http.Request) {
			request := f.RequestProto()
			parseProto(r, request)
			response := f.ResponseProto()
			err := f.Execute(request, response)
			if err != nil {
				log.Println(err)
				response.GetResponseInfo().Success = false
				response.GetResponseInfo().ErrorMessage = err.Error()
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
