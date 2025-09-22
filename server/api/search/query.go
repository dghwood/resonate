package search

import (
	"github.com/dghwood/resonate/proto"
	// "github.com/dghwood/resonate/services/datastore"
	"github.com/dghwood/resonate/services/search"
)

type Query struct {
	// Datastore datastore.Datastore
	SearchApi search.Search
}

func (f Query) RequireSignIn() bool { return false }

func (f Query) RequestProto() *proto.SearchMessage_Request {
	return &proto.SearchMessage_Request{}
}
func (f Query) ResponseProto() *proto.SearchMessage_Response {
	return &proto.SearchMessage_Response{}
}

func (f *Query) Execute(
	request *proto.SearchMessage_Request,
	response *proto.SearchMessage_Response) (err error) {

	query := request.Query
	podcasts, err := f.SearchApi.Podcasts(query)
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
