package subscribe

import (
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
)

type Remove struct {
	Datastore datastore.Datastore
}

func (f Remove) RequireSignIn() bool { return true }

func (f Remove) RequestProto() *proto.RemoveListenMessage_Request {
	return &proto.RemoveListenMessage_Request{}
}
func (f Remove) ResponseProto() *proto.RemoveListenMessage_Response {
	return &proto.RemoveListenMessage_Response{}
}

func (f *Remove) Execute(
	loggedInUser *models.LoggedInUser,
	request *proto.RemoveListenMessage_Request,
	response *proto.RemoveListenMessage_Response) (err error) {

	Listen := models.Listen{}
	// Should I check it's deleted?
	// Do I even need this path, if it's all soft deletes?
	models.Merge(&Listen.UserListenMessage, request.Listen)

	// Try the database, should I try requesting
	err = f.Datastore.Put(&Listen)
	if err != nil {
		return
	}
	response.Listen = &Listen.UserListenMessage
	return
}
