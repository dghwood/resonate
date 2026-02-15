package subscribe

import (
	"context"
	"fmt"

	"github.com/dghwood/resonate/api/apiutils"
	"github.com/dghwood/resonate/log"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/cachestore"
	"github.com/dghwood/resonate/services/datastore"
	"github.com/dghwood/resonate/services/fetch"
	"github.com/dghwood/resonate/services/opml"
	"github.com/dghwood/resonate/services/rss"
	"github.com/dghwood/resonate/utils"
)

type Import struct {
	Datastore   datastore.Datastore
	FetchClient *fetch.Client
	Cachestore  cachestore.Cachestore
}

func (f Import) RequireSignIn() bool { return true }

func (f Import) RequestProto() *proto.ImportOpmlMessage_Request {
	return &proto.ImportOpmlMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f Import) ResponseProto() *proto.ImportOpmlMessage_Response {
	return &proto.ImportOpmlMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}

func (f *Import) Execute(
	ctx context.Context,
	loggedInUser *models.LoggedInUser,
	request *proto.ImportOpmlMessage_Request,
	response *proto.ImportOpmlMessage_Response) (err error) {

	log.Infof("Import OPML for userId %s", loggedInUser.Id)

	// Save to cache store
	// Lets store these to review them later.
	if f.Cachestore != nil {
		key := fmt.Sprintf("opml/%s/%d.opml", loggedInUser.Id, utils.Now())
		err := f.Cachestore.Put(ctx, key, request.OpmlBytes)
		if err != nil {
			log.Errorf("failed to save OPML to cache store: %s", err)
		}
	}
	// Parse out the URLs from the OPML file
	rssUrls, err := opml.ExtractRssUrls(request.OpmlBytes)
	if err != nil {
		log.Errorf("failed to extract RSS URLs from OPML: %s", err)
		return err
	}
	log.Infof("found %d unique RSS URLs in OPML", len(rssUrls))

	// 1. Check if those podcasts already exist
	// 2. Add missing podcasts
	// 3. Add subscriptions for those podcasts..
	//    Note: They may already be subscribed..
	podcasts := make([]*models.Podcast, len(rssUrls))
	for i, rssUrl := range rssUrls {
		podcast := &models.Podcast{}
		// Does this set the Url field as well ?
		podcast.SetIdFromUrl(rssUrl)
		podcast.SetUrl(rssUrl)
		podcasts[i] = podcast
	}

	missingPodcastIndexes := make([]int, 0)
	multiErr := f.Datastore.GetMulti(ctx, podcasts)
	if merr, ok := multiErr.(datastore.MultiError); ok {
		for i, err := range merr {
			if err == nil {
				continue
			}
			if err == datastore.ErrorEntityNotFound {
				missingPodcastIndexes = append(missingPodcastIndexes, i)
				continue
			}
			// A real error to return
			return err
		}
	}

	// Add missing podcasts
	for _, pIndex := range missingPodcastIndexes {
		url := podcasts[pIndex].GetUrl()
		log.Info("fetching podcast from: ", url)
		podcast, episodes, err := rss.Get(ctx, url, f.FetchClient)

		if err != nil {
			// If 1 of these fail the whole thing fails..
			log.Error(err)
			return err
		}
		podcasts[pIndex] = &podcast
		// Background add these to DB
		// TODO(duncan): Don't like how these aren't batched better
		go apiutils.AsyncSyncToDatabase(f.Datastore, &podcast, episodes)
	}

	// Add subscriptions
	// This will overwrite any previous subscriptions
	subscriptions := make([]*models.Subscription, len(podcasts))
	for i, podcast := range podcasts {
		subscription := &models.Subscription{}
		// From app/lib/api/subscription.dart
		subscription.SetId(fmt.Sprintf("%s-%s", loggedInUser.Id, podcast.Id))
		subscription.UserId = loggedInUser.Id
		subscription.PodcastId = podcast.Id
		subscriptions[i] = subscription
	}
	err = f.Datastore.PutMulti(ctx, subscriptions)
	if err != nil {
		log.Error(err)
		return err
	}

	// Construct response
	for i, subscription := range subscriptions {
		subscription.Podcast = &podcasts[i].PodcastMessage
		response.Subscriptions = append(
			response.Subscriptions, &subscription.UserSubscriptionMessage)
	}
	return
}
