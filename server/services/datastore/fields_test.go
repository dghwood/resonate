package datastore

import (
	"testing"

	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
)

func TestMessageName(t *testing.T) {
	model := models.UserListen{}
	name := MessageName(&model)
	if name != "UserListenMessage" {
		t.Errorf("MessageName() = %s; want UserListenMessage", name)
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
