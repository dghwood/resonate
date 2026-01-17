package subscribe

import (
	"context"

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
	ctx context.Context,
	loggedInUser *models.LoggedInUser,
	request *proto.SyncSubscriptionMessage_Request,
	response *proto.SyncSubscriptionMessage_Response) (err error) {

	log.Infof("Sync Subscriptions for userId %s", loggedInUser.Id)

	// I need to reconcile the subscriptions provided with the db
	// reconcilation should be done at last updated timestamp.

	authorativeSubscriptions := make(map[string]*proto.UserSubscriptionMessage)
	model := &models.Subscription{}
	it := f.Datastore.ListForIds(
		ctx,
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
	updatedSubscriptions := make([]*models.Subscription, 0)
	podcastsToSave := make(map[string]*models.Podcast)

	for _, subscription := range request.GetSubscriptions() {
		subcriptionClientMap[subscription.GetId()] = true
		// If the subscription does exist ()
		dbSubscription, ok := authorativeSubscriptions[subscription.PodcastId]

		clientIsAuthority := false
		if !ok {
			// Not in DB
			if !subscription.GetMetadata().GetIsDeleted() {
				// Add if not deleted
				clientIsAuthority = true
			}
		} else if subscription.GetMetadata().GetUpdatedTimestamp() >
			dbSubscription.GetMetadata().GetUpdatedTimestamp() {
			// client is the authority
			clientIsAuthority = true
		}

		if clientIsAuthority {
			authorativeSubscriptions[subscription.PodcastId] = subscription

			// Deep copy for saving to datastore so we don't overwrite
			// the timestamps in the response pointers if the datastore
			// layer updates them.
			subCopy := models.Subscription{}
			models.Merge(&subCopy.UserSubscriptionMessage, subscription)

			updatedSubscriptions = append(updatedSubscriptions, &subCopy)
			if subscription.Podcast != nil {
				podcastsToSave[subscription.PodcastId] = &models.Podcast{
					PodcastMessage: *subscription.Podcast,
				}
			}
		}
	}

	if len(podcastsToSave) > 0 {
		toPut := make([]*models.Podcast, 0)
		for _, p := range podcastsToSave {
			toPut = append(toPut, p)
		}
		if len(toPut) > 0 {
			err = f.Datastore.PutMulti(ctx, toPut)
			if err != nil {
				log.Errorf("failed to put podcasts: %s", err)
			}
		}
	}

	if len(updatedSubscriptions) > 0 {
		err = f.Datastore.PutMulti(ctx, updatedSubscriptions)
		if err != nil {
			log.Errorf("failed to put subscriptions: %s", err)
			return err
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
		err := f.Datastore.GetMulti(ctx, podcastModels)
		if err != nil {
			log.Errorf("error getting podcasts %s", err)
			// Ignore error if podcasts are missing, as it is just enrichment
		}
		for i := range podcastModels {
			podcast := podcastModels[i]
			// Only attach if it was successfully loaded (has a title)
			if podcast.Title != "" {
				authorativeSubscriptions[podcast.Id].Podcast = &podcast.PodcastMessage
			}
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
