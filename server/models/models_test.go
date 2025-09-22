package models

import (
	"testing"
	// "github.com/dghwood/resonate/proto"
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

func TestPodcastIsModel(t *testing.T) {
	var _ Model = (*Podcast)(nil)
}
