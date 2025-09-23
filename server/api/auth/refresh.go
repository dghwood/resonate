package auth

import (
	"log"
	"time"

	token "github.com/dghwood/resonate/auth"
	"github.com/dghwood/resonate/models"
	pb "github.com/dghwood/resonate/proto"
)

type Refresh struct {
}

func (f Refresh) RequireSignIn() bool { return false }

func (f Refresh) RequestProto() *pb.RefreshAuthMessage_Request {
	return &pb.RefreshAuthMessage_Request{}
}
func (f Refresh) ResponseProto() *pb.RefreshAuthMessage_Response {
	return &pb.RefreshAuthMessage_Response{}
}

// Execute
//
// This function refreshes the access token by using the provided refresh token.
func (f Refresh) Execute(
	loggedInUser *models.LoggedInUserMessage,
	request *pb.RefreshAuthMessage_Request,
	response *pb.RefreshAuthMessage_Response) (err error) {

	userId := request.RequestInfo.UserId
	// refreshToken := request.RefreshToken
	// Look this up in the database & check refresh token
	user := &pb.UserMessage{
		Id: userId,
	}

	// generate a new access token
	accessToken, err := token.GetAccessToken(user, 24*time.Hour)
	if err != nil {
		log.Println("Error generating access token:", err)
		response.ResponseInfo = &pb.ResponseInfo{
			Success:      false,
			ErrorMessage: "Failed to generate access token",
		}
		return
	}

	// Build the response with the user and access token
	response.ResponseInfo = &pb.ResponseInfo{
		Success: true,
	}
	response.AccessToken = accessToken
	return
}
