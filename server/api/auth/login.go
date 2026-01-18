package auth

import (
	"context"
	"time"

	"github.com/dghwood/resonate/errors"
	"github.com/dghwood/resonate/log"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
	"github.com/dghwood/resonate/services/sms"
	"github.com/dghwood/resonate/utils"

	token "github.com/dghwood/resonate/auth"
)

type Login struct {
	Datastore       datastore.Datastore
	SmsVerification sms.Verification
}

func (f Login) RequireSignIn() bool { return false }

func (f Login) RequestProto() *proto.LoginUserMessage_Request {
	return &proto.LoginUserMessage_Request{
		RequestInfo: &proto.RequestInfo{
			InternalInfo: &proto.InternalInfo{},
		},
	}
}
func (f Login) ResponseProto() *proto.LoginUserMessage_Response {
	return &proto.LoginUserMessage_Response{
		ResponseInfo: &proto.ResponseInfo{
			InternalInfo: &proto.InternalInfo{},
		},
	}
}

// Execute
//
// This function logs the user in, requires the 'password' (in memcache)
// This also needs to only allow N attempts
// and returns the user and access token, as well as a refresh token.
// This also creates a new user if the user does not exist.
func (f Login) Execute(
	ctx context.Context,
	_ *models.LoggedInUser,
	request *proto.LoginUserMessage_Request,
	response *proto.LoginUserMessage_Response) (err error) {
	password := request.Password
	phoneNumber := request.PhoneNumber

	log.Infof("Login number:%s password:%s", phoneNumber, password)

	if !utils.IsValidPhoneNumber(phoneNumber) {
		// The front end should deal with this
		log.Error("Invalid phone number")
		return errors.ERROR_INTERNAL
	}

	err = f.SmsVerification.Validate(phoneNumber, password)
	if err != nil {
		log.Error(err)
		return
	}

	// loginAttempt := models.LoginAttempt{}
	// loginAttempt.PhoneNumber = phoneNumber

	// err = f.Datastore.Get(ctx, &loginAttempt)
	// if err != nil {
	// 	log.Infof("Login attempt error %s", err)
	// 	return
	// }

	// // TODO(duncan): 3 attemps hardcoded?
	// if loginAttempt.NumAttempts >= 3 {
	// 	return errors.ERROR_TOO_MANY_ATTEMPTS
	// }
	// // Check the expiry
	// if loginAttempt.ExpiryUtcTimestamp < time.Now().UTC().Unix() {
	// 	return errors.ERROR_TIME_EXPIRED
	// }
	// // Check the password
	// if loginAttempt.Password != password {
	// 	loginAttempt.NumAttempts += 1
	// 	err = f.Datastore.Put(ctx, &loginAttempt)
	// 	if err != nil {
	// 		return
	// 	}
	// 	return errors.ERROR_INVALID_CREDENTIALS
	// }
	// Now the user is authenticated
	user := &models.User{}
	user.SetIdFromPhoneNumber(phoneNumber)

	// Get the user if they already exist
	it := f.Datastore.ListForIds(ctx, datastore.ListForIdsParams{
		Ids:        []string{utils.HashPhoneNumber(phoneNumber)},
		IdFieldNum: user.GetEncryptedPhoneNumberFieldNum(),
		Entity:     user,
		Limit:      1,
	})
	userErr := it.Next(user)
	if userErr != nil && userErr != datastore.IteratorDone {
		log.Infof("Error getting user: %s", userErr)
		return userErr
	}
	userExists := userErr == nil

	// Add the new user since they don't exist
	if !userExists {
		err = f.Datastore.Put(ctx, user)
		if err != nil {
			return
		}
	}

	refreshTokens := models.RefreshTokens{}
	refreshTokens.UserId = user.Id

	// This is the user's refresh token
	refreshToken := &proto.TokenMessage{
		Token: utils.GenerateUniqueID(),
		// TODO(duncan): Should this have an expiry?
		ExpiryUtcTimestamp: time.Now().Add(365 * 24 * time.Hour).UTC().Unix(),
	}

	if userExists {
		// User exists, so load their refreshTokens
		refreshErr := f.Datastore.Get(ctx, &refreshTokens)
		if refreshErr != nil &&
			refreshErr != datastore.ErrorEntityNotFound {
			return refreshErr
		}
	}

	refreshTokens.Tokens = append(refreshTokens.Tokens, refreshToken)

	err = f.Datastore.Put(ctx, &refreshTokens)
	if err != nil {
		return
	}

	// Generate the access token
	accessToken, err := token.GetAccessToken(&user.UserMessage, 15*time.Minute)
	if err != nil {
		return
	}

	internalInfo := response.GetResponseInfo().GetInternalInfo()
	internalInfo.SetAccessToken(accessToken)
	internalInfo.SetRefreshToken(refreshToken)

	// response.AccessToken = accessToken
	// // This needs to be stored in the database
	// response.RefreshToken = refreshToken
	response.User = &user.UserMessage
	return
}
