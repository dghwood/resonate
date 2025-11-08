package rss

import (
	"testing"

	"github.com/dghwood/resonate/server/services/fetch"
)

func TestGet(t *testing.T) {
	url := "https://feeds.megaphone.fm/how-long-gone"
	podcast, episodes, err := Get(url, fetch.New())
	if err != nil {
		t.Error(err)
	}
	if podcast.Title != "How Long Gone" {
		t.Errorf("podcast title, expected How Long Gone, got %s", podcast.Title)
	}
	if len(episodes) == 0 {
		t.Error("got zero episodes")
	}
	if len(episodes) != 0 && episodes[0].Title == "" {
		t.Error("title not parsed")
	}
	for _, episode := range episodes {
		if episode.PublishTimestamp == 0 {
			t.Errorf("pub timestamp not parsed")
		}
	}
}
