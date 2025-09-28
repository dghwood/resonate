package search

import (
	"github.com/dghwood/resonate/models"
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

func NewTaddySearch(userId, authToken string) *taddy.TaddySearchApi {
	return &taddy.TaddySearchApi{
		UserId:    userId,
		AuthToken: authToken,
	}
}
