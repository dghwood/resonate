package firestore

import (
	"testing"

	firestore "cloud.google.com/go/datastore"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/services/datastore"
)

func TestFirestoreIsDatastore(t *testing.T) {
	var _ datastore.Datastore = (*FirestoreDatastore)(nil)
}

func TestFirestoreIsDatastoreIterator(t *testing.T) {
	var _ datastore.Iterator = (*FirestoreIterator)(nil)
}

func TestPropertyLoadSaver(t *testing.T) {
	var _ firestore.PropertyLoadSaver = (*DatabaseModel)(nil)
}

var projectID = "resonate-nyc"
var databaseId = "resonatedb-test"

func TestPut(t *testing.T) {
	ds := NewFirestoreDatastore(projectID, databaseId)
	podcast := models.Podcast{}
	podcast.Id = "123"
	podcast.Title = "Test Podcast"
	podcast.Description = "This is a test podcast"
	podcast.ImageUrl = "https://example.com/image.png"
	podcast.Url = "https://example.com/podcast.rss"

	err := ds.Put(&podcast)
	if err != nil {
		t.Errorf("Put() error = %v", err)
	}
}

func TestGet(t *testing.T) {
	ds := NewFirestoreDatastore(projectID, databaseId)
	podcast := models.Podcast{}
	podcast.Id = "123"

	err := ds.Get(&podcast)
	if err != nil {
		t.Errorf("Get() error = %v", err)
	}

	if podcast.Title != "Test Podcast" {
		t.Errorf("Title = %s; want Test Podcast", podcast.Title)
	}
}
