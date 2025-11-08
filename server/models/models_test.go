package models

import (
	"testing"
	// "github.com/dghwood/resonate/server/proto"
	// "github.com/dghwood/resonate/server/proto"
)

func TestModel(t *testing.T) {
	model := Podcast{
		// proto.PodcastMessage{},
	}
	model.Id = "123"

	if model.GetId() != "123" {
		t.Errorf("GetId() = %s; want 123", model.GetId())
	}
}

func TestNew(t *testing.T) {
	model := Podcast{}
	model.Id = "123"
	newModel := model.New()
	if newModel.GetId() == "123" {
		t.Errorf("GetId() = %s; want empty string", newModel.GetId())
	}
}

func TestPodcastId(t *testing.T) {
	model := Podcast{}
	model.SetIdFromUrl("https://feeds.megaphone.fm/how-long-gone")
	if model.Id == "" {
		t.Errorf("Id is empty")
	}
	url, err := model.GetUrlFromId()
	if err != nil {
		t.Error(err)
	}
	if url != "https://feeds.megaphone.fm/how-long-gone" {
		t.Errorf("Url is %s; want https://feeds.megaphone.fm/how-long-gone", url)
	}

}

func TestPodcastIsModel(t *testing.T) {
	var _ Model = (*Podcast)(nil)
}

func TestEpisodeIsModel(t *testing.T) {
	var _ Model = (*Episode)(nil)
}

func TestUserListenIsModel(t *testing.T) {
	var _ Model = (*UserListen)(nil)
}

func TestUserIsModel(t *testing.T) {
	var _ Model = (*User)(nil)
}

func TestLoggedInUserIsModel(t *testing.T) {
	var _ Model = (*LoggedInUser)(nil)
}

func TestSubscriptionIsModel(t *testing.T) {
	var _ Model = (*Subscription)(nil)
}
func TestSubscriptionIsUserModel(t *testing.T) {
	var _ UserModel = (*Subscription)(nil)
}
