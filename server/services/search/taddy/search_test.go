package taddy

import (
	"os"
	"testing"

	"github.com/dghwood/resonate/services/fetch"
)

func TestSearch(t *testing.T) {
	client := fetch.New()
	api := TaddySearchApi{
		Client:    *client,
		UserId:    os.Getenv("TADDY_USER_ID"),
		AuthToken: os.Getenv("TADDY_API_KEY"),
	}
	podcasts, err := api.Podcasts("pod save america")
	if err != nil {
		t.Error(err)
	}
	if len(podcasts) == 0 {
		t.Error("no podcasts returned")
	}
}

func TestTopSearch(t *testing.T) {
	client := fetch.New()
	api := TaddySearchApi{
		Client:    *client,
		UserId:    os.Getenv("TADDY_USER_ID"),
		AuthToken: os.Getenv("TADDY_API_KEY"),
	}
	podcasts, err := api.TopPodcasts()
	if err != nil {
		t.Error(err)
	}
	if len(podcasts) != 50 {
		t.Errorf("not enough podcasts returned, want 50 got %d", len(podcasts))
	}
	if len(podcasts) == 0 {
		t.Error("no podcasts returned")
	}
}
