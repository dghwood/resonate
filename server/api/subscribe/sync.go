package subscribe

import (
	"github.com/dghwood/resonate/log"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
)

type Sync struct {
	Datastore datastore.Datastore
}

func (f Sync) RequireSignIn() bool { return true }

func (f Sync) RequestProto() *proto.SyncSubscriptionMessage_Request {
	return &proto.SyncSubscriptionMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f Sync) ResponseProto() *proto.SyncSubscriptionMessage_Response {
	return &proto.SyncSubscriptionMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}

func (f *Sync) Execute(
	loggedInUser *models.LoggedInUser,
	request *proto.SyncSubscriptionMessage_Request,
	response *proto.SyncSubscriptionMessage_Response) (err error) {

	log.Infof("Sync Subscriptions for userId %s", loggedInUser.Id)

	// I need to reconcile the subscriptions provided with the db
	// reconcilation should be done at last updated timestamp.

	authorativeSubscriptions := make(map[string]*proto.UserSubscriptionMessage)
	model := &models.Subscription{}
	it := f.Datastore.ListForIds(
		datastore.ListForIdsParams{
			Ids:            []string{loggedInUser.Id},
			IdFieldNum:     model.GetUserIdFieldNum(),
			Entity:         model,
			IncludeDeleted: true,
		})

	for {
		model := models.Subscription{}
		err := it.Next(&model)
		if err == datastore.IteratorDone {
			break
		}
		if err != nil {
			log.Errorf("error in subscription it %s", err)
			return err
		}
		authorativeSubscriptions[model.PodcastId] = &model.UserSubscriptionMessage
	}

	subcriptionClientMap := make(map[string]bool)
	for _, subscription := range request.GetSubscriptions() {
		subcriptionClientMap[subscription.GetId()] = true
		// If the subscription does exist ()
		dbSubscription, ok := authorativeSubscriptions[subscription.PodcastId]
		if !ok {
			// Not in DB
			if !subscription.GetMetadata().GetIsDeleted() {
				// Add if not deleted
				authorativeSubscriptions[subscription.PodcastId] = subscription
			}
			continue
		}
		// Reconcile the two versions
		if subscription.GetMetadata().GetUpdatedTimestamp() >
			dbSubscription.GetMetadata().GetUpdatedTimestamp() {
			// client is the authority
			authorativeSubscriptions[subscription.PodcastId] = subscription
		}
	}

	// For any subscriptions from the server not on the client
	// load the podcast message
	podcastModels := make([]*models.Podcast, 0)
	for _, subscription := range authorativeSubscriptions {
		if _, ok := subcriptionClientMap[subscription.GetId()]; !ok {
			podcast := &models.Podcast{}
			podcast.SetId(subscription.GetPodcastId())
			podcastModels = append(podcastModels, podcast)
		}
	}

	if len(podcastModels) > 0 {
		err := f.Datastore.GetMulti(podcastModels)
		if err != nil {
			log.Errorf("error getting podcasts %s", err)
			return err
		}
		for _, podcast := range podcastModels {
			authorativeSubscriptions[podcast.Id].Podcast = &podcast.PodcastMessage
		}
		log.Infof("loaded %d podcasts", len(podcastModels))
	}

	// Return subscriptions
	// TODO(duncan): Should I delete the deleted ones?
	for _, subscription := range authorativeSubscriptions {
		response.Subscriptions = append(response.Subscriptions, subscription)
	}
	log.Infof("returning %d subscriptions", len(response.Subscriptions))
	return
}
