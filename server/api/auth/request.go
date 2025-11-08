package auth

import (
	"log"
	"time"

	"github.com/dghwood/resonate/server/errors"
	"github.com/dghwood/resonate/server/models"
	"github.com/dghwood/resonate/server/proto"
	"github.com/dghwood/resonate/server/services/datastore"
	"github.com/dghwood/resonate/server/utils"
)

type Request struct {
	Datastore datastore.Datastore
}

func (f Request) RequireSignIn() bool { return false }

func (f Request) RequestProto() *proto.LoginRequestMessage_Request {
	return &proto.LoginRequestMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f Request) ResponseProto() *proto.LoginRequestMessage_Response {
	return &proto.LoginRequestMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}

// Execute
//
// This texts the user with a code to login
// Note this is both for new users and existing
func (f Request) Execute(
	_ *models.LoggedInUser,
	request *proto.LoginRequestMessage_Request,
	response *proto.LoginRequestMessage_Response) (err error) {

	// Send a text with the password
	phoneNumber := request.PhoneNumber
	email := request.Email
	log.Printf("Requesting login for number: %s or email: %s", phoneNumber, email)

	if !utils.IsValidPhoneNumber(phoneNumber) {
		// The front end should deal with this
		log.Println("Invalid phone number")
		return errors.ERROR_INTERNAL
	}

	// TODO(duncan): Make this 5 configurable?
	password := utils.GenerateRandomNumberString(5)

	loginAttempt := models.LoginAttempt{}
	loginAttempt.PhoneNumber = phoneNumber
	loginAttempt.Password = password
	loginAttempt.ExpiryUtcTimestamp = time.Now().Add(15 * time.Minute).UTC().Unix()

	err = f.Datastore.Put(&loginAttempt)
	if err != nil {
		return
	}
	// TODO(duncan): Remove this in production
	log.Printf("Sending login request to %s with password: %s", phoneNumber, password)
	return
}
