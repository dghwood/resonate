package datastore

import (
	"testing"

	"github.com/dghwood/resonate/models"
)

func TestMemoryDatastore(t *testing.T) {
	model := models.Podcast{}
	model.Id = "123"
	model.Title = "Test Podcast"

	ds := NewMemoryDatastore()
	err := ds.Put(&model)
	if err != nil {
		t.Errorf("Put() error = %v", err)
	}

	returnedModel := models.Podcast{}
	returnedModel.Id = "123"
	err = ds.Get(&returnedModel)
	if err != nil {
		t.Errorf("Get() error = %v", err)
	}

	if returnedModel.GetId() != "123" {
		t.Errorf("GetId() = %s; want 123", returnedModel.GetId())
	}
	if returnedModel.Title != "Test Podcast" {
		t.Errorf("Title = %s; want Test Podcast", returnedModel.Title)
	}
}

func TestMemoryMultiDatastore(t *testing.T) {
	model0 := models.Podcast{}
	model0.Id = "123"
	model0.Title = "Test Podcast"

	model1 := models.Podcast{}
	model1.Id = "321"
	model1.Title = "Test Podcast 2"

	modelsToPut := []*models.Podcast{&model0, &model1}

	ds := NewMemoryDatastore()
	err := ds.PutMulti(modelsToPut)
	if err != nil {
		t.Errorf("Put() error = %v", err)
	}

	returnedModel0 := models.Podcast{}
	returnedModel0.Id = "123"
	returnedModel1 := models.Podcast{}
	returnedModel1.Id = "321"
	returnedModels := []*models.Podcast{&returnedModel0, &returnedModel1}

	err = ds.GetMulti(returnedModels)
	if err != nil {
		t.Errorf("Get() error = %v", err)
	}

	if (returnedModel0.Title != "Test Podcast") || (returnedModel1.Title != "Test Podcast 2") {
		t.Errorf("Title = %s; want Test Podcast", returnedModel0.Title)
	}
}

func TestMemoryIsDatastore(t *testing.T) {
	var _ Datastore = (*MemoryDatastore)(nil)
}
