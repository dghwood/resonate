package podcast

import (
	"github.com/dghwood/resonate/server/log"
	"github.com/dghwood/resonate/server/models"
	"github.com/dghwood/resonate/server/proto"
	"github.com/dghwood/resonate/server/services/datastore"
	"github.com/dghwood/resonate/server/services/fetch"
	"github.com/dghwood/resonate/server/services/rss"
)

type Get struct {
	Datastore   datastore.Datastore
	FetchClient *fetch.Client
}

func (f Get) RequireSignIn() bool { return false }

func (f Get) RequestProto() *proto.GetPodcastMessage_Request {
	return &proto.GetPodcastMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f Get) ResponseProto() *proto.GetPodcastMessage_Response {
	return &proto.GetPodcastMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}

func (f *Get) Execute(
	loggedInUser *models.LoggedInUser,
	request *proto.GetPodcastMessage_Request,
	response *proto.GetPodcastMessage_Response) (err error) {

	id := request.PodcastId
	model := models.Podcast{}
	model.Id = id
	log.Info("fetching podcast with id: ", id)
	// Try the database, should I try requesting
	podcastErr := f.Datastore.Get(&model)
	if podcastErr == nil {
		response.Podcast = &model.PodcastMessage
		return
	}
	url, err := model.GetUrlFromId()
	if err != nil {
		log.Error(err)
		return
	}
	log.Info("fetching podcast from: ", url)
	// This should cache the request for the next request?
	podcast, _, err := rss.Get(url, f.FetchClient)
	if err != nil {
		log.Error(err)
		return
	}
	response.Podcast = &podcast.PodcastMessage

	// Not sure if I should add to DB here.
	// f.Datastore.Put(&podcast)
	return
}
