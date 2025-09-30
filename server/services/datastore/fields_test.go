package datastore

import (
	"testing"

	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
)

func TestMessageName(t *testing.T) {
	model := models.UserListen{}
	name := models.Kind(&model)
	if name != "resonate.UserListenMessage" {
		t.Errorf("MessageName() = %s; want resonate.UserListenMessage", name)
	}
}

func TestFieldName(t *testing.T) {
	model := models.Subscription{}
	model.UserId = "123"

	fields := GetFields(&model)

	if fields[0].Name != "user_id" {
		t.Errorf("FieldName() = %s; want user_id", fields[0].Name)
	}
}

func TestFields(t *testing.T) {
	model := models.UserListen{}
	model.Id = "123"
	model.Completed = true
	model.Seconds = 60
	model.Metadata = &proto.StorageMetadataMessage{
		UpdatedTimestamp: 1,
	}

	fields := GetFields(&model)

	retrievedModel := models.UserListen{}
	err := RetrieveFields(fields, &retrievedModel)
	if err != nil {
		t.Errorf("RetrieveFields() error = %v", err)
	}

	if retrievedModel.GetId() != "123" {
		t.Errorf("GetId() = %s; want 123", retrievedModel.GetId())
	}
	if retrievedModel.Completed != true {
		t.Errorf("Completed = %t; want true", retrievedModel.Completed)
	}
	if retrievedModel.Seconds != 60 {
		t.Errorf("Seconds = %d; want 60", retrievedModel.Seconds)
	}
	if retrievedModel.Metadata.UpdatedTimestamp != 1 {
		t.Errorf("UpdatedTimestamp = %d; want 1", retrievedModel.Metadata.UpdatedTimestamp)
	}
}

func TestPodcast(t *testing.T) {
	podcast := models.Podcast{}
	podcast.Id = "123"
	podcast.Title = "Test Podcast"
	podcast.Description = "This is a test podcast"
	podcast.ImageUrl = "https://example.com/image.png"
	podcast.Url = "https://example.com/podcast.rss"
	fields := GetFields(&podcast)
	retrievedPodcast := models.Podcast{}
	err := RetrieveFields(fields, &retrievedPodcast)
	if err != nil {
		t.Errorf("RetrieveFields() error = %v", err)
	}

	if retrievedPodcast.Title != "Test Podcast" {
		t.Errorf("Title = %s; want Test Podcast", retrievedPodcast.Title)
	}

}
