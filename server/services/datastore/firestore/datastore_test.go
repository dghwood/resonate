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

// gcloud emulators firestore start --database-mode=datastore-mode --verbosity=debug --host-port=localhost:8081
var host = "localhost:8081"

func TestPut(t *testing.T) {
	t.Setenv("DATASTORE_EMULATOR_HOST", host)
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
	t.Setenv("DATASTORE_EMULATOR_HOST", host)
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
	t.Setenv("DATASTORE_EMULATOR_HOST", host)
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
	t.Setenv("DATASTORE_EMULATOR_HOST", host)
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

func newEpisodeId(id string) *models.Episode {
	episode := models.Episode{}
	episode.Id = id
	return &episode
}

func newEpisode(id string, podcastId string, publishTimestamp int64) *models.Episode {
	episode := newEpisodeId(id)
	episode.PodcastId = podcastId
	episode.PublishTimestamp = publishTimestamp
	return episode
}

func TestListForIds(t *testing.T) {
	t.Setenv("DATASTORE_EMULATOR_HOST", host)
	ds := NewFirestoreDatastore(projectID, databaseId)
	episode1 := newEpisode("123", "123", 1)
	episode2 := newEpisode("456", "123", 2)
	episode3 := newEpisode("789", "456", 3)

	episodes := []*models.Episode{episode1, episode2, episode3}
	err := ds.PutMulti(episodes)
	if err != nil {
		t.Errorf("PutMulti() error = %v", err)
	}

	// Test they are in there
	episode := newEpisodeId("123")
	err = ds.Get(episode)
	if err != nil {
		t.Errorf("Get() error = %v", err)
	}
	if episode.PodcastId != "123" {
		t.Errorf("PodcastId = %s; want 123", episode.PodcastId)
	}
	if episode.PublishTimestamp != 1 {
		t.Errorf("PublishTimestamp = %d; want 1", episode.PublishTimestamp)
	}

	it := ds.ListForIds(
		datastore.ListForIdsParams{
			Ids:          []string{"123"},
			IdFieldNum:   episode1.GetPodcastIdFieldNum(),
			SortFieldNum: episode1.GetPublishTimestampFieldNum(),
			Entity:       episode,
		})

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
		t.FailNow()
	}

	if retrievedEpisodes[0].PodcastId != "123" {
		t.Errorf("PodcastId = %s; want 123", retrievedEpisodes[0].PodcastId)
	}
	if retrievedEpisodes[1].PodcastId != "123" {
		t.Errorf("PodcastId = %s; want 123", retrievedEpisodes[1].PodcastId)
	}
}
