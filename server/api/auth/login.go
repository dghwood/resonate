package auth

import (
	"log"
	"time"

	pb "github.com/dghwood/resonate/proto"

	"crypto/rand"
	"crypto/sha256"
	"encoding/hex"

	token "github.com/dghwood/resonate/auth"
)

type Login struct {
}

func (f Login) RequireSignIn() bool { return false }

func (f Login) RequestProto() *pb.LoginUserMessage_Request {
	return &pb.LoginUserMessage_Request{}
}
func (f Login) ResponseProto() *pb.LoginUserMessage_Response {
	return &pb.LoginUserMessage_Response{}
}

// Execute
//
// This function logs the user in, requires the 'password' (in memcache)
// This also needs to only allow N attempts
// and returns the user and access token, as well as a refresh token.
// This also creates a new user if the user does not exist.
func (f Login) Execute(request *pb.LoginUserMessage_Request, response *pb.LoginUserMessage_Response) (err error) {

	user := &pb.UserMessage{
		// Should this be a hash of the email?
		Id:    "123456789",
		Email: request.Email,
		Name:  "Duncan Wood",
	}

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
	// This needs to be stored in the database
	response.RefreshToken = &pb.TokenMessage{
		Token: generateUniqueID(),
		// Should this have an expiry?
	}
	response.User = user
	return
}

// GenerateUniqueID generates a random 32-character hexadecimal string.
func generateUniqueID() string {
	bytes := make([]byte, 16)
	_, err := rand.Read(bytes)
	if err != nil {
		log.Println("Error generating unique ID:", err)
		return ""
	}
	return hex.EncodeToString(bytes)
}

func hashEmail(email string) string {
	bytes := []byte(email)
	hasher := sha256.New()
	hasher.Write(bytes)
	return hex.EncodeToString(hasher.Sum(nil))
}
