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

func (f Add) RequestProto() *proto.AddSubscriptionMessage_Request {
	return &proto.AddSubscriptionMessage_Request{}
}
func (f Add) ResponseProto() *proto.AddSubscriptionMessage_Response {
	return &proto.AddSubscriptionMessage_Response{}
}

func (f *Add) Execute(
	loggedInUser *models.LoggedInUser,
	request *proto.AddSubscriptionMessage_Request,
	response *proto.AddSubscriptionMessage_Response) (err error) {

	if loggedInUser.Id != request.Subscription.UserId {
		return errors.ERROR_PERMISSION_DENIED
	}

	subscription := models.Subscription{}
	models.Merge(&subscription.UserSubscriptionMessage, request.Subscription)

	// Try the database, should I try requesting
	err = f.Datastore.Put(&subscription)
	if err != nil {
		return
	}
	response.Subscription = &subscription.UserSubscriptionMessage
	return
}
