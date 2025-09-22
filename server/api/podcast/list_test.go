package podcast

import (
	"testing"

	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
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

	err := api.Execute(&request, &response)
	if err != nil {
		t.Error(err)
	}

	if len(response.Episodes) == 0 {
		t.Error("no episodes returned")
	}

	t.Error(ds.Data)
}
