package search

import (
	"os"

	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/services/fetch"
	"github.com/dghwood/resonate/services/search/taddy"
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
