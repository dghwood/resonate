package podcast

import (
	"github.com/dghwood/resonate/log"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
	"github.com/dghwood/resonate/services/fetch"
	"github.com/dghwood/resonate/services/rss"
)

type List struct {
	Datastore   datastore.Datastore
	FetchClient *fetch.Client
}

func (f List) RequireSignIn() bool { return false }

func (f List) RequestProto() *proto.ListPodcastEpisodesMessage_Request {
	return &proto.ListPodcastEpisodesMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f List) ResponseProto() *proto.ListPodcastEpisodesMessage_Response {
	return &proto.ListPodcastEpisodesMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}

func (f *List) Execute(
	loggedInUser *models.LoggedInUser,
	request *proto.ListPodcastEpisodesMessage_Request,
	response *proto.ListPodcastEpisodesMessage_Response) (err error) {

	log.Info("List::Execute")

	id := request.PodcastId
	log.Info("fetching podcast for : ", id)

	podcast := models.Podcast{}
	podcast.Id = id
	url, err := podcast.GetUrlFromId()
	if err != nil {
		log.Error(err)
		return
	}

	// Try the database,
	if f.Datastore.Get(&podcast) == nil {
		// Check the updated timestamp, and request the episodes from DB
		episode := &models.Episode{}
		it := f.Datastore.ListForIds(
			[]string{podcast.Id},
			episode.GetPodcastIdFieldNum(),
			episode.GetPublishTimestampFieldNum(),
			episode)

		i := 0
		for {
			episode := models.Episode{}
			er := it.Next(&episode)
			if er == datastore.IteratorDone {
				break
			}
			if er != nil {
				log.Error(er)
				return er
			}
			if i > 20 {
				// TODO(duncan): Need to figure out the cursor options
				break
			}
			i++
			response.Episodes = append(
				response.Episodes, &episode.EpisodeMessage)
		}
		log.Infof("returning %d episodes", len(response.Episodes))
		return
	}

	podcast, episodes, err := rss.Get(url, f.FetchClient)
	if err != nil {
		log.Error(err)
		return
	}

	response.Podcast = &podcast.PodcastMessage
	for i, episode := range episodes {
		if i > 20 {
			break
		}
		// Need to figure out the cursor options for this?
		response.Episodes = append(response.Episodes, &episode.EpisodeMessage)
	}

	f.Datastore.Put(&podcast)
	f.Datastore.PutMulti(episodes)
	return
}
