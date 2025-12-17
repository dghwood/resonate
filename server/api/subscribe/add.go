package subscribe

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

func (f Add) RequestProto() *proto.AddSubscriptionMessage_Request {
	return &proto.AddSubscriptionMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f Add) ResponseProto() *proto.AddSubscriptionMessage_Response {
	return &proto.AddSubscriptionMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}

func (f *Add) Execute(
	loggedInUser *models.LoggedInUser,
	request *proto.AddSubscriptionMessage_Request,
	response *proto.AddSubscriptionMessage_Response) (err error) {

	if loggedInUser.Id != request.Subscription.UserId {
		log.Error("permission denied", "error", errors.ERROR_PERMISSION_DENIED)
		return errors.ERROR_PERMISSION_DENIED
	}

	subscription := models.Subscription{}
	models.Merge(&subscription.UserSubscriptionMessage, request.Subscription)
	log.Info("subscription", "subscription", &subscription)
	// Check the podcast exists
	podcast := models.Podcast{}
	podcast.Id = subscription.PodcastId
	err = f.Datastore.Get(&podcast)
	if err != nil {
		log.Error("error getting podcast", "error", err)
		return
	}
	// Try the database, should I try requesting
	err = f.Datastore.Put(&subscription)
	if err != nil {
		log.Error("error putting subscription", "error", err)
		return
	}
	response.Subscription = &subscription.UserSubscriptionMessage

	podcast.NumSubscriptions += 1
	err = f.Datastore.Put(&podcast)
	if err != nil {
		log.Error("error putting podcast", "error", err)
		return
	}
	return
}
