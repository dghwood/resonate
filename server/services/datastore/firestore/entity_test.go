package firestore

import (
	"testing"

	"github.com/dghwood/resonate/server/models"
)

func TestSave(t *testing.T) {
	podcast := models.Podcast{}
	podcast.Id = "123"
	podcast.Title = "Test Podcast"
	podcast.Description = "This is a test podcast"
	podcast.ImageUrl = "https://example.com/image.png"
	podcast.Url = "https://example.com/podcast.rss"

	model := DatabaseModel{Model: &podcast}
	props, err := model.Save()
	if err != nil {
		t.Errorf("Save() error = %v", err)
	}

	if len(props) != 5 {
		t.Errorf("Save() = %d; want 5", len(props))
	}
	if props[0].Name != "1" {
		t.Errorf("Save() = %s; want 1", props[0].Name)
	}
	if props[0].Value.(string) != "123" {
		t.Errorf("Save() = %s; want 123", props[0].Value.(string))
	}
}

func TestLoad(t *testing.T) {
	podcast := models.Podcast{}
	podcast.Id = "123"
	podcast.Title = "Test Podcast"
	podcast.Description = "This is a test podcast"
	podcast.ImageUrl = "https://example.com/image.png"
	podcast.Url = "https://example.com/podcast.rss"

	model := DatabaseModel{Model: &podcast}
	props, err := model.Save()
	if err != nil {
		t.Errorf("Save() error = %v", err)
	}
	retrievedPodcast := models.Podcast{}
	model = DatabaseModel{Model: &retrievedPodcast}
	err = model.Load(props)
	if err != nil {
		t.Errorf("Load() error = %v", err)
	}

	if retrievedPodcast.Title != "Test Podcast" {
		t.Errorf("Title = %s; want Test Podcast", retrievedPodcast.Title)
	}
}
