package feed

import (
	"context"
	"testing"

	"github.com/dghwood/resonate/constants"
	"github.com/dghwood/resonate/services/datastore/firestore"
)

func TestFeed(t *testing.T) {
	// Slate money is not turning up in my feed
	// I want to check what is going on
	//
	// Somehow slate money was showing as not subscribed
	// But in the app it showed it was
	// Why didnt the sync fix this..
	var projectID = constants.CLOUD_PROJECT_ID
	var databaseId = constants.CLOUD_DATABASE_ID

	ds := firestore.NewFirestoreDatastore(projectID, databaseId)

	results, err := getUserSubscriptionEpisodeIds(
		context.Background(),
		"f21b72b5ae2479dd11271c01473b4674",
		ds,
	)
	if err != nil {
		t.Error(err)
	}
	if len(results) == 0 {
		t.Error("no results")
	}
	slateMoneyPodcastId := "aHR0cHM6Ly9mZWVkcy5hY2FzdC5jb20vcHVibGljL3Nob3dzLzY5NWVhZDY4YTMyZTg2ZDc3NTg1ODE5NA=="

	for _, podcastId := range results {
		if podcastId == slateMoneyPodcastId {
			return
		}
	}
	t.Error("slate money podcast not found")
}
