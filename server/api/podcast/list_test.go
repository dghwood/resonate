package podcast

import (
	"testing"

	"github.com/dghwood/resonate/server/models"
	"github.com/dghwood/resonate/server/proto"
	"github.com/dghwood/resonate/server/services/datastore"
)

func TestList(t *testing.T) {
	ds := datastore.NewMemoryDatastore()
	api := List{
		Datastore: ds,
	}

	var request = proto.ListPodcastEpisodesMessage_Request{
		PodcastId: "123",
	}
	var response = proto.ListPodcastEpisodesMessage_Response{}

	err := api.Execute(nil, &request, &response)
	if err != nil {
		t.Error(err)
	}

	if len(response.Episodes) == 0 {
		t.Error("no episodes returned")
	}

	t.Error(ds.Data)
}

func TestListDb(t *testing.T) {
	ds := datastore.NewMemoryDatastore()
	// Add this to the datastore and given there aren't any episodes
	// then this should return 0
	podcast := models.Podcast{}
	podcast.Id = "124"
	ds.Put(&podcast)

	api := List{
		Datastore: ds,
	}

	var request = proto.ListPodcastEpisodesMessage_Request{
		PodcastId: "124",
	}
	var response = proto.ListPodcastEpisodesMessage_Response{}

	err := api.Execute(nil, &request, &response)
	if err != nil {
		t.Error(err)
	}

	if len(response.Episodes) != 0 {
		t.Error("no episodes returned")
	}

	// t.Error(ds.Data)
}
