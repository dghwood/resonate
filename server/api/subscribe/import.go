package subscribe

import (
	"context"
	"encoding/xml"
	"fmt"
	"sync"

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

	// Extract unique RSS URLs
	urlMap := make(map[string]bool)
	var rssUrls []string
	var extract func([]opmlOutline)
	extract = func(outlines []opmlOutline) {
		for _, outline := range outlines {
			if outline.Type == "rss" && outline.XmlUrl != "" {
				if !urlMap[outline.XmlUrl] {
					urlMap[outline.XmlUrl] = true
					rssUrls = append(rssUrls, outline.XmlUrl)
				}
			}
			if len(outline.Outlines) > 0 {
				extract(outline.Outlines)
			}
		}
	}
	extract(opmlData.Body.Outlines)

	log.Infof("found %d unique RSS URLs in OPML", len(rssUrls))

	// 1. Batch fetch existing podcasts
	podcastIds := make([]string, len(rssUrls))
	for i, url := range rssUrls {
		p := &models.Podcast{}
		podcastIds[i] = p.SetIdFromUrl(url)
	}

	existingPodcasts := make(map[string]*models.Podcast)
	pIt := f.Datastore.ListForIds(ctx, datastore.ListForIdsParams{
		Ids:        podcastIds,
		IdFieldNum: 1, // Id
		Entity:     &models.Podcast{},
	})
	for {
		p := &models.Podcast{}
		if err := pIt.Next(p); err != nil {
			break
		}
		existingPodcasts[p.Id] = p
	}

	// 2. Batch fetch user's existing subscriptions
	existingSubscriptions := make(map[string]bool)
	sIt := f.Datastore.ListForIds(ctx, datastore.ListForIdsParams{
		Ids:        []string{loggedInUser.Id},
		IdFieldNum: 2, // UserId
		Entity:     &models.Subscription{},
	})
	for {
		s := &models.Subscription{}
		if err := sIt.Next(s); err != nil {
			break
		}
		existingSubscriptions[s.PodcastId] = true
	}

	// 3. Process each URL
	var newSubscriptions []*models.Subscription
	var podcastsToIncrement []*models.Podcast

	// Use a WaitGroup to fetch missing podcast details in parallel (foreground)
	// but only for the basic metadata needed for the response.
	// Saving episodes and full podcast details to DB will be async.
	var wg sync.WaitGroup
	var mu sync.Mutex

	for _, url := range rssUrls {
		podcast := &models.Podcast{}
		podcastId := podcast.SetIdFromUrl(url)

		if existingSubscriptions[podcastId] {
			continue
		}

		sub := &models.Subscription{}
		sub.Id = fmt.Sprintf("%s-%s", loggedInUser.Id, podcastId)
		sub.UserId = loggedInUser.Id
		sub.PodcastId = podcastId

		p, found := existingPodcasts[podcastId]
		if found {
			sub.Podcast = &p.PodcastMessage
			newSubscriptions = append(newSubscriptions, sub)
			podcastsToIncrement = append(podcastsToIncrement, p)
		} else {
			// Podcast missing from DB, crawl it
			wg.Add(1)
			go func(url string, sub *models.Subscription) {
				defer wg.Done()
				// Foreground fetch of podcast metadata
				fetchedP, episodes, err := rss.Get(ctx, url, f.FetchClient)
				if err != nil {
					log.Errorf("failed to crawl %s: %s", url, err)
					return
				}

				mu.Lock()
				sub.Podcast = &fetchedP.PodcastMessage
				newSubscriptions = append(newSubscriptions, sub)
				podcastsToIncrement = append(podcastsToIncrement, &fetchedP)
				mu.Unlock()

				// Background save of podcast and episodes
				go f.asyncSavePodcastAndEpisodes(&fetchedP, episodes)
			}(url, sub)
		}
	}
	wg.Wait()

	// 4. Batch save new subscriptions
	if len(newSubscriptions) > 0 {
		err = f.Datastore.PutMulti(ctx, newSubscriptions)
		if err != nil {
			log.Errorf("failed to save new subscriptions: %s", err)
			return err
		}

		// 5. Update NumSubscriptions on podcasts
		for _, p := range podcastsToIncrement {
			p.NumSubscriptions += 1
		}
		err = f.Datastore.PutMulti(ctx, podcastsToIncrement)
		if err != nil {
			log.Errorf("failed to update podcast subscription counts: %s", err)
		}

		// Populate response
		for _, s := range newSubscriptions {
			response.Subscriptions = append(response.Subscriptions, &s.UserSubscriptionMessage)
		}
	}

	log.Infof("imported %d new subscriptions", len(response.Subscriptions))
	return nil
}

func (f *Import) asyncSavePodcastAndEpisodes(podcast *models.Podcast, episodes []*models.Episode) {
	// Use a new context for background operations
	ctx := context.Background()
	err := f.Datastore.Put(ctx, podcast)
	if err != nil {
		log.Errorf("failed to save podcast %s in background: %s", podcast.Id, err)
	}
	if len(episodes) > 0 {
		err = f.Datastore.PutMulti(ctx, episodes)
		if err != nil {
			log.Errorf("failed to save episodes for %s in background: %s", podcast.Id, err)
		}
	}
}
