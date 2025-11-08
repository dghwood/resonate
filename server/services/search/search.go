package search

import (
	"os"

	"github.com/dghwood/resonate/server/models"
	"github.com/dghwood/resonate/server/services/fetch"
	"github.com/dghwood/resonate/server/services/search/taddy"
)

type Search interface {
	Podcasts(query string) (
		podcasts []*models.Podcast,
		err error)
	TopPodcasts() (
		podcasts []*models.Podcast,
		err error)
}

func NewMockSearch() *MockSearch {
	return &MockSearch{}
}

func NewTaddySearch(client *fetch.Client) *taddy.TaddySearchApi {
	return &taddy.TaddySearchApi{
		UserId:    os.Getenv("TADDY_USER_ID"),
		AuthToken: os.Getenv("TADDY_API_KEY"),
		Client:    client,
	}
}
