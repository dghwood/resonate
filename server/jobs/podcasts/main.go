package main

import (
	"github.com/dghwood/resonate/log"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/services/datastore"
	datastoreService "github.com/dghwood/resonate/services/datastore/firestore"
	fetchService "github.com/dghwood/resonate/services/fetch"
	"github.com/dghwood/resonate/services/rss"
	"github.com/dghwood/resonate/services/secrets"
	// "github.com/dghwood/resonate/services/secrets"
)

// TODO(duncan): Put these in the secrets?
var projectID = "level-prism-477102-p5"
var databaseId = "rxyz-db-test"

func main() {
	secrets.AccessSecrets()
	numSkipped := 0
	numCompleted := 0
	ds := datastoreService.NewFirestoreDatastore(projectID, databaseId)
	fetch := fetchService.New()

	it := ds.List(&models.Podcast{})
	for range 100 {
		model := models.Podcast{}
		err := it.Next(&model)
		if err == datastore.IteratorDone {
			break
		}
		if err != nil {
			log.Error("error iterating", "error", err)
			return
		}
		log.Info("updating podcast", "title", model.Title, "num_subscriptions", model.NumSubscriptions)
		if model.NumSubscriptions == 0 {
			// Don't refresh podcasts without subscriptions
			numSkipped += 1
			continue
		}
		// Should I check the last updated time?
		podcast, episodes, err := rss.Get(model.Url, fetch) // Use cached?
		models.Merge(&model, &podcast)
		if err != nil {
			log.Error("error getting rss", "error", err)
			return
		}
		err = ds.PutMulti(episodes)
		if err != nil {
			log.Error("error putting episodes", "error", err)
			return
		}
		err = ds.Put(&model)
		if err != nil {
			log.Error("error putting model", "error", err)
			return
		}
		numCompleted += 1
	}

	log.Info("Finished updating podcasts", "completed", numCompleted, "skipped", numSkipped)
}
