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

func TestPutMulti(t *testing.T) {
	ds := NewFirestoreDatastore(projectID, databaseId)
	podcast1 := models.Podcast{}
	podcast1.Id = "123"
	podcast1.Title = "Test Podcast 1"
	podcast2 := models.Podcast{}
	podcast2.Id = "456"
	podcast2.Title = "Test Podcast 2"
	podcasts := []*models.Podcast{&podcast1, &podcast2}
	err := ds.PutMulti(podcasts)
	if err != nil {
		t.Errorf("PutMulti() error = %v", err)
	}
}

func TestGetMulti(t *testing.T) {
	ds := NewFirestoreDatastore(projectID, databaseId)
	podcast1 := models.Podcast{}
	podcast1.Id = "123"
	podcast2 := models.Podcast{}
	podcast2.Id = "456"
	podcasts := []*models.Podcast{&podcast1, &podcast2}
	err := ds.GetMulti(podcasts)
	if err != nil {
		t.Errorf("GetMulti() error = %v", err)
	}
	if podcasts[0].Title != "Test Podcast 1" {
		t.Errorf("Title = %s; want Test Podcast 1", podcasts[0].Title)
	}
	if podcasts[1].Title != "Test Podcast 2" {
		t.Errorf("Title = %s; want Test Podcast 2", podcasts[1].Title)
	}
}

func TestListForIds(t *testing.T) {
	ds := NewFirestoreDatastore(projectID, databaseId)
	episode1 := models.Episode{}
	episode1.Id = "123"
	episode1.PodcastId = "123"
	episode2 := models.Episode{}
	episode2.Id = "456"
	episode2.PodcastId = "123"
	episode3 := models.Episode{}
	episode3.Id = "678"
	episode3.PodcastId = "456"
	episodes := []*models.Episode{&episode1, &episode2, &episode3}
	err := ds.PutMulti(episodes)
	if err != nil {
		t.Errorf("PutMulti() error = %v", err)
	}
	it := ds.ListForIds(
		[]string{"123"},
		episode1.GetPodcastIdFieldNum(),
		episode1.GetPublishTimestampFieldNum(),
		&episode1)

	retrievedEpisodes := []*models.Episode{}
	for {
		episode := models.Episode{}
		er := it.Next(&episode)
		if er == datastore.IteratorDone {
			break
		}
		if er != nil {
			t.Errorf("Next() error = %v", er)
			break
		}
		retrievedEpisodes = append(retrievedEpisodes, &episode)
	}

	if len(retrievedEpisodes) != 2 {
		t.Errorf("retrievedEpisodes = %d; want 2", len(retrievedEpisodes))
	}

	if retrievedEpisodes[0].PodcastId != "123" {
		t.Errorf("PodcastId = %s; want 123", retrievedEpisodes[0].PodcastId)
	}
	if retrievedEpisodes[1].PodcastId != "123" {
		t.Errorf("PodcastId = %s; want 123", retrievedEpisodes[1].PodcastId)
	}
}
