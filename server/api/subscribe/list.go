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
	model := models.Subscription{}
	subscriptions := f.Datastore.ListForIds(
		[]string{loggedInUser.Id},
		model.GetUserIdFieldNum(),
		-1, // Sort by something?
		&models.Subscription{})

	for {
		model := models.Subscription{}
		err := subscriptions.Next(&model)
		if err == datastore.IteratorDone {
			break
		}
		if err != nil {
			return err
		}
		response.Subscriptions = append(
			response.Subscriptions, &model.UserSubscriptionMessage)
	}
	return
}
