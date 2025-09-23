package search

import (
	"testing"

	"github.com/dghwood/resonate/services/search"
)

func TestSearch(t *testing.T) {
	api := Query{
		SearchApi: search.NewMockSearch(),
	}
	request := api.RequestProto()
	request.Query = "test"

	response := api.ResponseProto()
	api.Execute(nil, request, response)
	if len(response.SearchResults.Results) != 10 {
		t.Errorf("wrong number of results %d", len(response.SearchResults.Results))
	}
}
