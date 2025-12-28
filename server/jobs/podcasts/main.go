package main

import (
	"context"
	"time"

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
			log.Error(err)
			return
		}
		log.Infof("updating podcast::%s::%d", model.Title, model.NumSubscriptions)
		if model.NumSubscriptions == 0 {
			// Don't refresh podcasts without subscriptions
			numSkipped += 1
			continue
		}
		// Should I check the last updated time?
		ctx, _ := context.WithTimeout(context.Background(), time.Second*20)
		podcast, episodes, err := rss.Get(ctx, model.Url, fetch) // Use cached?
		models.Merge(&model, &podcast)
		if err != nil {
			log.Error(err)
			return
		}
		err = ds.PutMulti(episodes)
		if err != nil {
			log.Error(err)
			return
		}
		err = ds.Put(&model)
		if err != nil {
			log.Error(err)
			return
		}
		numCompleted += 1
	}

	log.Infof("Finished updating podcasts, %d completed, %d skipped", numCompleted, numSkipped)
}
