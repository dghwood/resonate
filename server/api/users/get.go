package users

import (
	"github.com/dghwood/resonate/server/models"
	"github.com/dghwood/resonate/server/proto"
	"github.com/dghwood/resonate/server/services/datastore"
)

type Get struct {
	Datastore datastore.Datastore
}

func (f Get) RequireSignIn() bool { return true }

func (f Get) RequestProto() *proto.GetPublicUserMessage_Request {
	return &proto.GetPublicUserMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f Get) ResponseProto() *proto.GetPublicUserMessage_Response {
	return &proto.GetPublicUserMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}

func (f *Get) Execute(
	loggedInUser *models.LoggedInUser,
	request *proto.GetPublicUserMessage_Request,
	response *proto.GetPublicUserMessage_Response) (err error) {

	// TODO(duncan): This implies that users are public information
	userId := request.UserId
	user := models.User{}
	user.Id = userId

	err = f.Datastore.Get(&user)
	if err != nil {
		return
	}

	response.User = user.ToPublicUser()
	return
}
