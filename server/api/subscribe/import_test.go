package subscribe

import (
	"context"
	"testing"

	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
)

func TestImportExecute(t *testing.T) {
	ds := datastore.NewMemoryDatastore()
	// No podcasts in DB initially

	imp := &Import{
		Datastore: ds,
		// FetchClient and Cachestore can be nil for this simple test if we don't trigger crawl
		// But crawl will be triggered if podcast not found.
		// For testing without actual crawling, we might need a mock FetchClient or just Put the podcast beforehand.
	}

	// Pre-put a podcast so crawl isn't triggered for it
	podcast := &models.Podcast{}
	podcast.SetIdFromUrl("https://example.com/rss")
	podcast.Title = "Example Podcast"
	ds.Put(context.Background(), podcast)

	opml := `<?xml version="1.0" encoding="UTF-8"?>
<opml version="1.0">
  <body>
    <outline type="rss" xmlUrl="https://example.com/rss" />
  </body>
</opml>`

	request := &proto.ImportOpmlMessage_Request{
		OpmlBytes: []byte(opml),
	}
	response := &proto.ImportOpmlMessage_Response{}

	user := &models.LoggedInUser{}
	user.Id = "user1"
	user.IsLoggedIn = true

	err := imp.Execute(context.Background(), user, request, response)
	if err != nil {
		t.Fatalf("Execute failed: %v", err)
	}

	if len(response.Subscriptions) != 1 {
		t.Errorf("expected 1 subscription, got %d", len(response.Subscriptions))
	}

	sub := response.Subscriptions[0]
	if sub.PodcastId != podcast.Id {
		t.Errorf("expected podcastId %s, got %s", podcast.Id, sub.PodcastId)
	}
	if sub.UserId != "user1" {
		t.Errorf("expected userId user1, got %s", sub.UserId)
	}

	// Verify subscription in DB
	dbSub := &models.Subscription{}
	dbSub.Id = "user1-" + podcast.Id
	err = ds.Get(context.Background(), dbSub)
	if err != nil {
		t.Errorf("subscription not found in DB: %v", err)
	}

	// Run again, should return 0 new subscriptions
	response2 := &proto.ImportOpmlMessage_Response{}
	err = imp.Execute(context.Background(), user, request, response2)
	if err != nil {
		t.Fatalf("Second execute failed: %v", err)
	}
	if len(response2.Subscriptions) != 0 {
		t.Errorf("expected 0 new subscriptions on second run, got %d", len(response2.Subscriptions))
	}
}
