package users

import (
	"context"

	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
)

type List struct {
	Datastore datastore.Datastore
}

func (f List) RequireSignIn() bool { return true }

func (f List) RequestProto() *proto.ListUserMessage_Request {
	return &proto.ListUserMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f List) ResponseProto() *proto.ListUserMessage_Response {
	return &proto.ListUserMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}

func (f *List) Execute(
	ctx context.Context,
	loggedInUser *models.LoggedInUser,
	request *proto.ListUserMessage_Request,
	response *proto.ListUserMessage_Response) (err error) {

	// TODO(duncan): Do I need to have permissions here?
	userIds := request.UserIds
	models := make([]*models.User, len(userIds))
	for i, model := range models {
		model.Id = userIds[i]
	}

	err = f.Datastore.GetMulti(ctx, models)
	if err != nil {
		return
	}

	for _, model := range models {
		response.Users = append(
			response.Users, model.ToPublicUser())
	}
	return
}
