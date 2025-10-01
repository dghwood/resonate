package search

import (
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"

	"github.com/dghwood/resonate/services/datastore"
	"github.com/dghwood/resonate/services/search"
)

type Top struct {
	Datastore datastore.Datastore
	SearchApi search.Search
}

func (f Top) RequireSignIn() bool { return false }

func (f Top) RequestProto() *proto.SearchTopMessage_Request {
	return &proto.SearchTopMessage_Request{}
}
func (f Top) ResponseProto() *proto.SearchTopMessage_Response {
	return &proto.SearchTopMessage_Response{}
}

/*
TopSearch
*/
func (f *Top) Execute(
	loggedInUser *models.LoggedInUser,
	request *proto.SearchTopMessage_Request,
	response *proto.SearchTopMessage_Response) (err error) {

	podcasts, err := f.SearchApi.TopPodcasts()
	if err != nil {
		return
	}

	response.SearchResults = &proto.SearchResultsMessage{}
	for _, podcast := range podcasts {
		response.SearchResults.Results = append(
			response.SearchResults.Results,
			&proto.SearchResultMessage{
				Podcast: &podcast.PodcastMessage,
			})
	}
	return
}
