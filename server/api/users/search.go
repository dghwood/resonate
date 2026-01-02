package users

import (
	"context"
	"strings"

	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
)

type Search struct {
	Datastore datastore.Datastore
}

func (f Search) RequireSignIn() bool { return true }

func (f Search) RequestProto() *proto.SearchContactsMessage_Request {
	return &proto.SearchContactsMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f Search) ResponseProto() *proto.SearchContactsMessage_Response {
	return &proto.SearchContactsMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}

func (f *Search) Execute(
	ctx context.Context,
	loggedInUser *models.LoggedInUser,
	request *proto.SearchContactsMessage_Request,
	response *proto.SearchContactsMessage_Response) (err error) {

	it := f.Datastore.List(ctx, &models.User{})
	// TODO(duncan): Random limit to stop this going crazy
	for range 1000 {
		entity := &models.User{}
		err := it.Next(entity)
		if err == datastore.IteratorDone {
			break
		}
		if err != nil {
			return err
		}

		if request.Query == "" ||
			strings.Contains(strings.ToLower(entity.Name), request.Query) {
			response.Users = append(response.Users, entity.ToPublicUser())
		}
	}

	return
}
