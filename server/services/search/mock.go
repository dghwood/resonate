package search

import (
	"fmt"

	"github.com/dghwood/resonate/models"
)

type MockSearch struct {
}

func mockPodcast(id, title string) *models.Podcast {
	model := models.Podcast{}
	model.Id = id
	model.Title = title
	model.ImageUrl = ""
	model.Url = ""
	return &model
}
func (m *MockSearch) Podcasts(query string) (
	podcasts []*models.Podcast,
	err error) {

	for i := range 10 {
		podcasts = append(podcasts,
			mockPodcast(
				fmt.Sprintf("%d", i),
				fmt.Sprintf("Test Podcast %d", i)))
	}
	return
}
