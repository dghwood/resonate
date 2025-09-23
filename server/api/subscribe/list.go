package subscribe

import (
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
)

type List struct {
	Datastore datastore.Datastore
}

func (f List) RequireSignIn() bool { return true }

func (f List) RequestProto() *proto.ListSubscriptionMessage_Request {
	return &proto.ListSubscriptionMessage_Request{}
}
func (f List) ResponseProto() *proto.ListSubscriptionMessage_Response {
	return &proto.ListSubscriptionMessage_Response{}
}

func (f *List) Execute(
	loggedInUser *models.LoggedInUser,
	request *proto.ListSubscriptionMessage_Request,
	response *proto.ListSubscriptionMessage_Response) (err error) {

	// Need to query db for all subscriptions (paging?)
	// a user
	return
}
