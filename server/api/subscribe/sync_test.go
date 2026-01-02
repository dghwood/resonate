package subscribe

import (
	"context"
	"testing"

	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
)

func TestSyncExecute(t *testing.T) {
	ds := datastore.NewMemoryDatastore()
	ds.Put(context.Background(), &models.Subscription{
		UserSubscriptionMessage: proto.UserSubscriptionMessage{
			Id:        "1",
			UserId:    "123",
			PodcastId: "123",
			Metadata: &proto.StorageMetadataMessage{
				UpdatedTimestamp: 1,
			},
		},
	})
	ds.Put(context.Background(), &models.Subscription{
		UserSubscriptionMessage: proto.UserSubscriptionMessage{
			Id:        "2",
			UserId:    "123",
			PodcastId: "456",
			Metadata: &proto.StorageMetadataMessage{
				UpdatedTimestamp: 100,
			},
		},
	})
	ds.Put(context.Background(), &models.Subscription{
		UserSubscriptionMessage: proto.UserSubscriptionMessage{
			Id:        "3",
			UserId:    "123",
			PodcastId: "789",
			Metadata: &proto.StorageMetadataMessage{
				UpdatedTimestamp: 100,
				IsDeleted:        true,
			},
		},
	})

	sync := &Sync{Datastore: ds}
	request := sync.RequestProto()
	request.Subscriptions = []*proto.UserSubscriptionMessage{
		{
			Id:        "1",
			UserId:    "123",
			PodcastId: "123",
			Metadata: &proto.StorageMetadataMessage{
				UpdatedTimestamp: 2,
			},
		},
		{
			Id:        "2",
			UserId:    "123",
			PodcastId: "456",
			Metadata: &proto.StorageMetadataMessage{
				UpdatedTimestamp: 100,
				IsDeleted:        true,
			},
		},
		{
			Id:        "4",
			UserId:    "123",
			PodcastId: "101112",
			Metadata: &proto.StorageMetadataMessage{
				UpdatedTimestamp: 101,
			},
		},
	}

	response := sync.ResponseProto()

	user := &models.LoggedInUser{}
	user.Id = "123"
	user.IsLoggedIn = true
	ctx := context.Background()
	err := sync.Execute(ctx, user, request, response)
	if err != nil {
		t.Errorf("Execute() error = %v", err)
	}

	if len(response.Subscriptions) != 4 {
		t.Errorf("len(response.Subscriptions) = %d; want 2", len(response.Subscriptions))
	}
	for _, subscription := range response.Subscriptions {
		if subscription.GetId() == "1" {
			if subscription.GetMetadata().GetUpdatedTimestamp() != 2 {
				t.Errorf("UpdatedTimestamp = %d; want 2", subscription.GetMetadata().GetUpdatedTimestamp())
			}
		}
		if subscription.GetId() == "2" {
			if subscription.GetMetadata().GetUpdatedTimestamp() != 100 {
				t.Errorf("UpdatedTimestamp = %d; want 100", subscription.GetMetadata().GetUpdatedTimestamp())
			}
		}
	}

}
