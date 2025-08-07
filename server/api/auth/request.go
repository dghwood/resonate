package auth

import (
	"log"

	pb "github.com/dghwood/resonate/proto"
)

type Request struct {
}

func (f Request) RequireSignIn() bool { return false }
func (f Request) RequestProto() *pb.LoginRequestMessage_Request {
	return &pb.LoginRequestMessage_Request{}
}
func (f Request) ResponseProto() *pb.LoginRequestMessage_Response {
	return &pb.LoginRequestMessage_Response{}
}

// Execute
//
// This emails the user with a code to login
func (f Request) Execute(
	request *pb.LoginRequestMessage_Request,
	response *pb.LoginRequestMessage_Response) (err error) {

	// email the user with a code
	email := request.Email
	if email == "" {
		response.ResponseInfo = &pb.ResponseInfo{
			Success:      false,
			ErrorMessage: "Email is required",
		}
		return
	}

	password := generateUniqueID()
	// Remove this
	log.Printf("Sending login email to %s with password: %s", email, password)

	response.ResponseInfo = &pb.ResponseInfo{
		Success: true,
	}
	return
}
