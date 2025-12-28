package search

import (
	"context"
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
	ctx := context.Background()
	api.Execute(ctx, nil, request, response)
	if len(response.SearchResults.Results) != 10 {
		t.Errorf("wrong number of results %d", len(response.SearchResults.Results))
	}
}
