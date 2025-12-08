package auth

import (
	"time"

	token "github.com/dghwood/resonate/auth"
	"github.com/dghwood/resonate/errors"
	"github.com/dghwood/resonate/log"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
)

type Refresh struct {
	Datastore datastore.Datastore
}

func (f Refresh) RequireSignIn() bool { return false }

func (f Refresh) RequestProto() *proto.RefreshAuthMessage_Request {
	return &proto.RefreshAuthMessage_Request{
		RequestInfo: &proto.RequestInfo{
			InternalInfo: &proto.InternalInfo{},
		},
	}
}
func (f Refresh) ResponseProto() *proto.RefreshAuthMessage_Response {
	return &proto.RefreshAuthMessage_Response{
		ResponseInfo: &proto.ResponseInfo{
			InternalInfo: &proto.InternalInfo{},
		},
	}
}

// Execute
//
// This function refreshes the access token by using the provided refresh token.
func (f Refresh) Execute(
	loggedInUser *models.LoggedInUser,
	request *proto.RefreshAuthMessage_Request,
	response *proto.RefreshAuthMessage_Response) (err error) {

	userId := request.GetRequestInfo().GetUserId()
	refreshToken := request.GetRequestInfo().GetInternalInfo().GetRefreshToken()

	if refreshToken == nil {
		log.Errorf("refresh called without refreshToken")
		return errors.ERROR_INVALID_CREDENTIALS
	}

	tokens := models.RefreshTokens{}
	tokens.UserId = userId
	err = f.Datastore.Get(&tokens)
	if err != nil {
		return
	}
	// Check the refresh token
	isTokenGood := false
	for _, token := range tokens.Tokens {
		if token.Token == refreshToken.Token &&
			token.ExpiryUtcTimestamp > time.Now().UTC().Unix() {
			isTokenGood = true
			break
		}
	}
	if !isTokenGood {
		log.Error("Refresh Token not found or expired")
		return errors.ERROR_INVALID_CREDENTIALS
	}

	// TODO(duncan): Does this need to be filled out futher?
	user := &proto.UserMessage{
		Id: userId,
	}

	// Generate a new access token
	accessToken, err := token.GetAccessToken(user, 24*time.Hour)
	if err != nil {
		return
	}

	// response.AccessToken = accessToken
	log.Infof("new access token %s", accessToken)
	response.GetResponseInfo().GetInternalInfo().SetAccessToken(accessToken)
	return
}
