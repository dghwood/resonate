package subscribe

import (
	"context"
	"testing"

	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
)

func TestSyncPersistsToDatastore(t *testing.T) {
	ds := datastore.NewMemoryDatastore()
	ctx := context.Background()

	// 1. Initial subscription in DB
	ds.Put(ctx, &models.Subscription{
		UserSubscriptionMessage: proto.UserSubscriptionMessage{
			Id:        "user1-podcast1",
			UserId:    "user1",
			PodcastId: "podcast1",
			Metadata: &proto.StorageMetadataMessage{
				UpdatedTimestamp: 1,
			},
		},
	})

	sync := &Sync{Datastore: ds}

	// 2. Request with updated sub1 and new sub2
	request := sync.RequestProto()
	request.Subscriptions = []*proto.UserSubscriptionMessage{
		{
			Id:        "user1-podcast1",
			UserId:    "user1",
			PodcastId: "podcast1",
			Metadata: &proto.StorageMetadataMessage{
				UpdatedTimestamp: 2, // Newer
			},
		},
		{
			Id:        "user1-podcast2",
			UserId:    "user1",
			PodcastId: "podcast2",
			Metadata: &proto.StorageMetadataMessage{
				UpdatedTimestamp: 1,
			},
		},
	}

	response := sync.ResponseProto()
	user := &models.LoggedInUser{}
	user.Id = "user1"
	user.IsLoggedIn = true

	err := sync.Execute(ctx, user, request, response)
	if err != nil {
		t.Fatalf("Execute() error = %v", err)
	}

	// 3. Verify datastore was updated
	sub1 := &models.Subscription{}
	sub1.Id = "user1-podcast1"
	err = ds.Get(ctx, sub1)
	if err != nil {
		t.Errorf("Failed to get sub1 from DS: %v", err)
	} else if sub1.GetMetadata().GetUpdatedTimestamp() != 2 {
		t.Errorf("sub1 in DS has timestamp %d; want 2", sub1.GetMetadata().GetUpdatedTimestamp())
	}

	sub2 := &models.Subscription{}
	sub2.Id = "user1-podcast2"
	err = ds.Get(ctx, sub2)
	if err != nil {
		t.Errorf("Failed to get sub2 from DS: %v", err)
	}
}

func TestSyncSavesPodcast(t *testing.T) {
	ds := datastore.NewMemoryDatastore()
	ctx := context.Background()

	sync := &Sync{Datastore: ds}

	request := sync.RequestProto()
	request.Subscriptions = []*proto.UserSubscriptionMessage{
		{
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
		},
	}

	response := sync.ResponseProto()
	user := &models.LoggedInUser{}
	user.Id = "user1"
	user.IsLoggedIn = true

	err := sync.Execute(ctx, user, request, response)
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
}
