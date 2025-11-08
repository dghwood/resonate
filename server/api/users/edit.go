package users

import (
	"github.com/dghwood/resonate/server/errors"
	"github.com/dghwood/resonate/server/log"
	"github.com/dghwood/resonate/server/models"
	"github.com/dghwood/resonate/server/proto"
	"github.com/dghwood/resonate/server/services/datastore"
)

type Edit struct {
	Datastore datastore.Datastore
}

func (f Edit) RequireSignIn() bool { return true }

func (f Edit) RequestProto() *proto.EditUserMessage_Request {
	return &proto.EditUserMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f Edit) ResponseProto() *proto.EditUserMessage_Response {
	return &proto.EditUserMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}

func (f *Edit) Execute(
	loggedInUser *models.LoggedInUser,
	request *proto.EditUserMessage_Request,
	response *proto.EditUserMessage_Response) (err error) {

	if loggedInUser.Id != request.RequestInfo.UserId {
		return errors.ERROR_PERMISSION_DENIED
	}

	user := models.User{}
	user.Id = loggedInUser.Id
	log.Infof("fetching user %s", user.Id)
	err = f.Datastore.Get(&user)
	if err != nil {
		return
	}

	// I should only update whitelisted fields
	updatedUser := models.User{}
	if request.User.Name != "" {
		updatedUser.Name = request.User.Name
	}
	if request.User.ImageUrl != "" {
		updatedUser.ImageUrl = request.User.ImageUrl
	}
	// This only overrides populated fields I hope
	models.Merge(&user.UserMessage, &updatedUser)
	log.Infof("updating user %s", &user)
	err = f.Datastore.Put(&user)
	if err != nil {
		return
	}
	response.User = &user.UserMessage
	return
}
