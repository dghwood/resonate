package follows

import (
	"github.com/dghwood/resonate/server/models"
	"github.com/dghwood/resonate/server/proto"
	"github.com/dghwood/resonate/server/services/datastore"
)

type Remove struct {
	Datastore datastore.Datastore
}

func (f Remove) RequireSignIn() bool { return true }

func (f Remove) RequestProto() *proto.RemoveFollowMessage_Request {
	return &proto.RemoveFollowMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f Remove) ResponseProto() *proto.RemoveFollowMessage_Response {
	return &proto.RemoveFollowMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}

func (f *Remove) Execute(
	loggedInUser *models.LoggedInUser,
	request *proto.RemoveFollowMessage_Request,
	response *proto.RemoveFollowMessage_Response) (err error) {

	follow := models.Follow{}
	// Should I check it's deleted?
	// Do I even need this path, if it's all soft deletes?
	models.Merge(&follow.UserFollowMessage, request.Follow)

	// Try the database, should I try requesting
	err = f.Datastore.Put(&follow)
	if err != nil {
		return
	}
	response.Follow = &follow.UserFollowMessage
	return
}
