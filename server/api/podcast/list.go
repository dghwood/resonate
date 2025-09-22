package podcast

import (
	"log"

	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
	"github.com/dghwood/resonate/services/rss"
)

type List struct {
	Datastore datastore.Datastore
}

func (f List) RequireSignIn() bool { return false }

func (f List) RequestProto() *proto.ListPodcastEpisodesMessage_Request {
	return &proto.ListPodcastEpisodesMessage_Request{}
}
func (f List) ResponseProto() *proto.ListPodcastEpisodesMessage_Response {
	return &proto.ListPodcastEpisodesMessage_Response{}
}

func (f *List) Execute(
	request *proto.ListPodcastEpisodesMessage_Request,
	response *proto.ListPodcastEpisodesMessage_Response) (err error) {

	log.Println("List::Execute")

	id := request.PodcastId
	model := models.Podcast{}
	// TODO(duncan): You can't hardcode the URL here.
	model.Url = "https://feeds.megaphone.fm/how-long-gone"
	model.Id = id

	// Try the database,
	pErr := f.Datastore.Get(&model)
	if pErr == nil {
		log.Printf("error getting model %s", pErr)
		// Check the updated timestamp, and request the episodes from DB
	}

	podcast, episodes, err := rss.Get(model.Url)
	if err != nil {
		log.Println(err)
		return
	}

	response.Podcast = &podcast.PodcastMessage
	for _, episode := range episodes {
		// Limit to top N
		response.Episodes = append(response.Episodes, &episode.EpisodeMessage)
	}

	f.Datastore.Put(&podcast)
	f.Datastore.PutMulti(episodes)
	return
}
