package auth

import (
	"log"
	"time"

	"github.com/dghwood/resonate/errors"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
	"github.com/dghwood/resonate/utils"
)

type Request struct {
	Datastore datastore.Datastore
}

func (f Request) RequireSignIn() bool { return false }

func (f Request) RequestProto() *proto.LoginRequestMessage_Request {
	return &proto.LoginRequestMessage_Request{}
}
func (f Request) ResponseProto() *proto.LoginRequestMessage_Response {
	return &proto.LoginRequestMessage_Response{}
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
	log.Printf("Requesting login for %s", phoneNumber)

	if !utils.IsValidPhoneNumber(phoneNumber) {
		// The front end should deal with this
		log.Println("Invalid phone number")
		return errors.ERROR_INTERNAL
	}

	password := utils.GenerateUniqueID()

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
