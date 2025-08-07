package api

import (
	"encoding/json"
	"io"
	"log"
	"net/http"

	// pb "github.com/dghwood/resonate/proto"
	"google.golang.org/protobuf/proto"
)

type ApiInterface[request proto.Message, response proto.Message] interface {
	Execute(request request, response response) error
	RequestProto() request
	ResponseProto() response
	RequireSignIn() bool
}

// func Attach[request proto.Message, response proto.Message](
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

func Attach[request proto.Message, response proto.Message](
	f ApiInterface[request, response], path string) {
	http.HandleFunc(path, func(w http.ResponseWriter, r *http.Request) {
		request := f.RequestProto()
		parseProto(r, request)
		response := f.ResponseProto()
		err := f.Execute(request, response)
		if err != nil {
			log.Println(err)
		}
		writeProto(r, w, response)
	})
}

func writeProto(
	r *http.Request,
	w http.ResponseWriter,
	response proto.Message) {
	if r.URL.Query().Has("json") {
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(response)
		return
	}
	responseBytes, err := proto.Marshal(response)
	if err != nil {
		log.Printf("failed to marshal response")
	}
	w.Header().Set("Content-Type", "application/x-protobuf")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Write(responseBytes)
}

func parseProto(r *http.Request, request proto.Message) {
	reqBytes, err := io.ReadAll(r.Body)
	if err != nil {
		log.Print(err)
	}
	log.Println(request)
	err = proto.Unmarshal(reqBytes, request)
	if err != nil {
		log.Print("PARSE ERR", err)
	}
}
