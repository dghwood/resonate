package subscribe

import (
	"context"
	"testing"

	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
)

func TestAddWithPodcast(t *testing.T) {
	ds := datastore.NewMemoryDatastore()
	ctx := context.Background()

	add := &Add{Datastore: ds}

	request := add.RequestProto()
	request.Subscription = &proto.UserSubscriptionMessage{
		Id:        "user1-podcast1",
		UserId:    "user1",
		PodcastId: "podcast1",
		Metadata: &proto.StorageMetadataMessage{
			UpdatedTimestamp: 1,
		},
		Podcast: &proto.PodcastMessage{
			Id:    "podcast1",
			Title: "New Podcast",
		},
	}

	response := add.ResponseProto()
	user := &models.LoggedInUser{}
	user.Id = "user1"
	user.IsLoggedIn = true

	err := add.Execute(ctx, user, request, response)
	if err != nil {
		t.Fatalf("Execute() error = %v", err)
	}

	// Verify podcast was saved
	podcast := &models.Podcast{}
	podcast.Id = "podcast1"
	err = ds.Get(ctx, podcast)
	if err != nil {
		t.Errorf("Failed to get podcast from DS: %v", err)
	} else if podcast.Title != "New Podcast" {
		t.Errorf("podcast title = %s; want New Podcast", podcast.Title)
	}

	// Verify subscription was saved
	sub := &models.Subscription{}
	sub.Id = "user1-podcast1"
	err = ds.Get(ctx, sub)
	if err != nil {
		t.Errorf("Failed to get sub from DS: %v", err)
	}
}
