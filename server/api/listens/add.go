package subscribe

import (
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
)

type Add struct {
	Datastore datastore.Datastore
}

func (f Add) RequireSignIn() bool { return true }

func (f Add) RequestProto() *proto.AddListenMessage_Request {
	return &proto.AddListenMessage_Request{}
}
func (f Add) ResponseProto() *proto.AddListenMessage_Response {
	return &proto.AddListenMessage_Response{}
}

func (f *Add) Execute(
	loggedInUser *models.LoggedInUser,
	request *proto.AddListenMessage_Request,
	response *proto.AddListenMessage_Response) (err error) {

	Listen := models.Listen{}
	models.Merge(&Listen.UserListenMessage, request.Listen)

	// Try the database, should I try requesting
	err = f.Datastore.Put(&Listen)
	if err != nil {
		return
	}
	response.Listen = &Listen.UserListenMessage
	return
}
