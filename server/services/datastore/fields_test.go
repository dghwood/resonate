package datastore

import (
	"testing"

	"github.com/dghwood/resonate/server/models"
	"github.com/dghwood/resonate/server/proto"
	"google.golang.org/protobuf/reflect/protoreflect"
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

	item := GetFields(&model)

	if item.Fields[0].Name != "user_id" {
		t.Errorf("FieldName() = %s; want user_id", item.Fields[0].Name)
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

func TestRepeatedFields(t *testing.T) {
	repeatedProto := models.RefreshTokens{}
	repeatedProto.UserId = "123"
	repeatedProto.Tokens = []*proto.TokenMessage{
		{
			Token:              "token1",
			ExpiryUtcTimestamp: 1,
		},
		{
			Token:              "token2",
			ExpiryUtcTimestamp: 2,
		},
	}
	item := GetFields(&repeatedProto)

	retrievedProto := models.RefreshTokens{}

	err := RetrieveFields(item, &retrievedProto)
	if err != nil {
		t.Errorf("RetrieveFields() error = %v", err)
	}

	if retrievedProto.UserId != "123" {
		t.Errorf("UserId = %s; want 123", retrievedProto.UserId)
	}
	if len(retrievedProto.Tokens) != 2 {
		t.Errorf("len(Tokens) = %d; want 2", len(retrievedProto.Tokens))
	}
	if retrievedProto.Tokens[0].Token != "token1" {
		t.Errorf("Tokens[0].Token = %s; want token1", retrievedProto.Tokens[0].Token)
	}
	if retrievedProto.Tokens[0].ExpiryUtcTimestamp != 1 {
		t.Errorf("Tokens[0].ExpiryUtcTimestamp = %d; want 1", retrievedProto.Tokens[0].ExpiryUtcTimestamp)
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

func TestIndex(t *testing.T) {
	message := models.Podcast{}
	message.Description = "123"
	message.Title = "title"
	message.Author = "author"
	expectedMap := map[string]bool{
		"description": false,
		"title":       true,
		"author":      true,
	}
	message.ProtoReflect().Range(
		func(
			fd protoreflect.FieldDescriptor,
			value protoreflect.Value) bool {
			expectedValue, ok := expectedMap[string(fd.Name())]
			if ok && expectedValue != getIndex(fd) {
				t.Errorf("%s expected indexed: %t got %t", fd.Name(), expectedValue, getIndex(fd))
			}
			return true
		})
}

func TestIndexEpisode(t *testing.T) {
	message := models.Episode{}
	message.Description = "description"
	message.Title = "title"
	message.PodcastId = "podcast_id"
	expectedMap := map[string]bool{
		"description": false,
		"title":       false,
		"podcast_id":  true,
	}
	message.ProtoReflect().Range(
		func(
			fd protoreflect.FieldDescriptor,
			value protoreflect.Value) bool {
			expectedValue, ok := expectedMap[string(fd.Name())]
			if ok && expectedValue != getIndex(fd) {
				t.Errorf("%s expected indexed: %t got %t", fd.Name(), expectedValue, getIndex(fd))
			}
			return true
		})
}
