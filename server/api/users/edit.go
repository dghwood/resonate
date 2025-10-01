package users

import (
	"github.com/dghwood/resonate/errors"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
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

	if loggedInUser.Id != request.User.Id {
		return errors.ERROR_PERMISSION_DENIED
	}

	user := models.User{}
	user.Id = loggedInUser.Id
	err = f.Datastore.Get(&user)
	if err != nil {
		return
	}

	// This only overrides populated fields I think
	models.Merge(&user.UserMessage, request.User)

	err = f.Datastore.Put(&user)
	if err != nil {
		return
	}
	response.User = &user.UserMessage
	return
}
