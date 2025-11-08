package listens

import (
	"github.com/dghwood/resonate/errors"
	"github.com/dghwood/resonate/log"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
)

type Add struct {
	Datastore datastore.Datastore
}

func (f Add) RequireSignIn() bool { return true }

func (f Add) RequestProto() *proto.AddListenMessage_Request {
	return &proto.AddListenMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f Add) ResponseProto() *proto.AddListenMessage_Response {
	return &proto.AddListenMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}

func (f *Add) Execute(
	loggedInUser *models.LoggedInUser,
	request *proto.AddListenMessage_Request,
	response *proto.AddListenMessage_Response) (err error) {

	if loggedInUser.Id != request.Listen.UserId {
		log.Error(errors.ERROR_PERMISSION_DENIED)
		return errors.ERROR_PERMISSION_DENIED
	}

	listen := models.Listen{}
	models.Merge(&listen.UserListenMessage, request.Listen)
	log.Info(&listen)
	// Try the database, should I try requesting
	err = f.Datastore.Put(&listen)
	if err != nil {
		log.Error(err)
		return
	}
	response.Listen = &listen.UserListenMessage
	return
}
