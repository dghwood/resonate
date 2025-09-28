package subscribe

import (
	"github.com/dghwood/resonate/errors"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
)

type Add struct {
	Datastore datastore.Datastore
}

func (f Add) RequireSignIn() bool { return true }

func (f Add) RequestProto() *proto.AddFollowMessage_Request {
	return &proto.AddFollowMessage_Request{}
}
func (f Add) ResponseProto() *proto.AddFollowMessage_Response {
	return &proto.AddFollowMessage_Response{}
}

func (f *Add) Execute(
	loggedInUser *models.LoggedInUser,
	request *proto.AddFollowMessage_Request,
	response *proto.AddFollowMessage_Response) (err error) {

	if loggedInUser.Id != request.Follow.UserId {
		return errors.ERROR_PERMISSION_DENIED
	}

	follow := models.Follow{}
	models.Merge(&follow.UserFollowMessage, request.Follow)

	// Try the database, should I try requesting
	err = f.Datastore.Put(&follow)
	if err != nil {
		return
	}
	response.Follow = &follow.UserFollowMessage
	return
}
