package datastore

import (
	"context"
	"testing"

	"github.com/dghwood/resonate/models"
)

func TestMemoryDatastore(t *testing.T) {
	model := models.Podcast{}
	model.Id = "123"
	model.Title = "Test Podcast"

	ds := NewMemoryDatastore()
	ctx := context.Background()
	err := ds.Put(ctx, &model)
	if err != nil {
		t.Errorf("Put() error = %v", err)
	}

	returnedModel := models.Podcast{}
	returnedModel.Id = "123"
	err = ds.Get(context.Background(), &returnedModel)
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
	err := ds.PutMulti(context.Background(), modelsToPut)
	if err != nil {
		t.Errorf("Put() error = %v", err)
	}

	returnedModel0 := models.Podcast{}
	returnedModel0.Id = "123"
	returnedModel1 := models.Podcast{}
	returnedModel1.Id = "321"
	returnedModels := []*models.Podcast{&returnedModel0, &returnedModel1}

	err = ds.GetMulti(context.Background(), returnedModels)
	if err != nil {
		t.Errorf("Get() error = %v", err)
	}

	if (returnedModel0.Title != "Test Podcast") || (returnedModel1.Title != "Test Podcast 2") {
		t.Errorf("Title = %s; want Test Podcast", returnedModel0.Title)
	}
}

func TestMemoryListIdsDatastore(t *testing.T) {
	model0 := models.Episode{}
	model0.Id = "1"
	model0.PodcastId = "1"
	model0.PublishTimestamp = 1

	model1 := models.Episode{}
	model1.Id = "2"
	model1.PodcastId = "2"
	model1.PublishTimestamp = 2

	model2 := models.Episode{}
	model2.Id = "3"
	model2.PodcastId = "2"
	model2.PublishTimestamp = 3

	modelsToPut := []*models.Episode{&model0, &model1, &model2}

	ds := NewMemoryDatastore()
	err := ds.PutMulti(context.Background(), modelsToPut)

	if err != nil {
		t.Errorf("Put() error = %v", err)
	}

	model := models.Episode{}
	iter := ds.ListForIds(
		context.Background(),
		ListForIdsParams{
			Ids:          []string{"2"},
			IdFieldNum:   model.GetPodcastIdFieldNum(),
			SortFieldNum: model.GetPublishTimestampFieldNum(),
			Entity:       &model,
		})

	results := make([]*models.Episode, 0)

	for {
		result := models.Episode{}
		err := iter.Next(&result)
		if err == IteratorDone {
			break
		}
		if err != nil {
			t.Errorf("Next() error = %v", err)
		}
		results = append(results, &result)
	}

	if len(results) != 2 {
		t.Errorf("len(results) = %d; want 2", len(results))
	}

}

func TestMemoryIsDatastore(t *testing.T) {
	var _ Datastore = (*MemoryDatastore)(nil)
}

func TestMemoryIsDatastoreIterator(t *testing.T) {
	var _ Iterator = (*MemoryDatastoreIterator)(nil)
}
