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

func (f Remove) RequestProto() *proto.RemoveSubscriptionMessage_Request {
	return &proto.RemoveSubscriptionMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f Remove) ResponseProto() *proto.RemoveSubscriptionMessage_Response {
	return &proto.RemoveSubscriptionMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}

func (f *Remove) Execute(
	loggedInUser *models.LoggedInUser,
	request *proto.RemoveSubscriptionMessage_Request,
	response *proto.RemoveSubscriptionMessage_Response) (err error) {

	subscription := models.Subscription{}
	// Should I check it's deleted?
	// Do I even need this path, if it's all soft deletes?
	models.Merge(&subscription.UserSubscriptionMessage, request.Subscription)

	// Try the database, should I try requesting
	err = f.Datastore.Put(&subscription)
	if err != nil {
		return
	}
	response.Subscription = &subscription.UserSubscriptionMessage
	return
}
