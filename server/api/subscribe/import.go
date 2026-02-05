package subscribe

import (
	"context"
	"encoding/xml"
	"fmt"

	"github.com/dghwood/resonate/log"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/cachestore"
	"github.com/dghwood/resonate/services/datastore"
	"github.com/dghwood/resonate/services/fetch"
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

type opml struct {
	XMLName xml.Name `xml:"opml"`
	Body    opmlBody `xml:"body"`
}

type opmlBody struct {
	Outlines []opmlOutline `xml:"outline"`
}

type opmlOutline struct {
	Type     string        `xml:"type,attr"`
	Text     string        `xml:"text,attr"`
	XmlUrl   string        `xml:"xmlUrl,attr"`
	Outlines []opmlOutline `xml:"outline"`
}

func (f *Import) Execute(
	ctx context.Context,
	loggedInUser *models.LoggedInUser,
	request *proto.ImportOpmlMessage_Request,
	response *proto.ImportOpmlMessage_Response) (err error) {

	log.Infof("Import OPML for userId %s", loggedInUser.Id)

	// Save to cache store
	if f.Cachestore != nil {
		key := fmt.Sprintf("opml/%s/%d.opml", loggedInUser.Id, utils.Now())
		err := f.Cachestore.Put(ctx, key, request.OpmlBytes)
		if err != nil {
			log.Errorf("failed to save OPML to cache store: %s", err)
		}
	}

	// Parse OPML
	var opmlData opml
	err = xml.Unmarshal(request.OpmlBytes, &opmlData)
	if err != nil {
		log.Errorf("failed to parse OPML: %s", err)
		return err
	}

	// Extract RSS URLs
	var rssUrls []string
	var extract func([]opmlOutline)
	extract = func(outlines []opmlOutline) {
		for _, outline := range outlines {
			if outline.Type == "rss" && outline.XmlUrl != "" {
				rssUrls = append(rssUrls, outline.XmlUrl)
			}
			if len(outline.Outlines) > 0 {
				extract(outline.Outlines)
			}
		}
	}
	extract(opmlData.Body.Outlines)

	log.Infof("found %d RSS URLs in OPML", len(rssUrls))

	for _, url := range rssUrls {
		podcast := &models.Podcast{}
		podcastId := podcast.SetIdFromUrl(url)

		// Check if podcast exists
		err = f.Datastore.Get(ctx, podcast)
		if err != nil {
			log.Infof("podcast %s not found, crawling...", podcastId)
			fetchedPodcast, episodes, err := rss.Get(ctx, url, f.FetchClient)
			if err != nil {
				log.Errorf("failed to fetch podcast %s: %s", url, err)
				continue
			}
			models.Merge(podcast, &fetchedPodcast)

			// Save podcast and episodes
			err = f.Datastore.Put(ctx, podcast)
			if err != nil {
				log.Errorf("failed to save podcast %s: %s", podcastId, err)
				continue
			}
			if len(episodes) > 0 {
				err = f.Datastore.PutMulti(ctx, episodes)
				if err != nil {
					log.Errorf("failed to save episodes for podcast %s: %s", podcastId, err)
				}
			}
		}

		// Check and create subscription
		subscriptionId := fmt.Sprintf("%s-%s", loggedInUser.Id, podcastId)
		subscription := &models.Subscription{}
		subscription.Id = subscriptionId

		err = f.Datastore.Get(ctx, subscription)
		if err != nil {
			// Subscription doesn't exist
			subscription.UserId = loggedInUser.Id
			subscription.PodcastId = podcastId
			subscription.SetMetadata(&proto.StorageMetadataMessage{
				CreatedTimestamp: utils.Now(),
				UpdatedTimestamp: utils.Now(),
			})

			err = f.Datastore.Put(ctx, subscription)
			if err != nil {
				log.Errorf("failed to save subscription %s: %s", subscriptionId, err)
				continue
			}

			// Increment NumSubscriptions
			podcast.NumSubscriptions += 1
			err = f.Datastore.Put(ctx, podcast)
			if err != nil {
				log.Errorf("failed to update podcast NumSubscriptions for %s: %s", podcastId, err)
			}

			response.Subscriptions = append(response.Subscriptions, &subscription.UserSubscriptionMessage)
		}
	}

	log.Infof("imported %d subscriptions", len(response.Subscriptions))
	return nil
}
