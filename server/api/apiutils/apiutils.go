package apiutils

import (
	"context"
	"time"

	"github.com/dghwood/resonate/log"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/services/datastore"
)

// This is creating a bit of a race condition when the
// user goes to subscribe, since if this hasn't finished the
// subscribe add won't successfully run.
// although it will get picked up on sync.
func AsyncSyncToDatabase(
	ds datastore.Datastore,
	podcast *models.Podcast,
	episodes []*models.Episode,
) {
	ctx, cancel := context.WithTimeout(context.Background(), time.Second*60)
	defer cancel()
	// TODO(duncan): This takes too long
	if err := ds.PutMulti(ctx, episodes); err != nil {
		log.Errorf("putting episodes error : %s", err)
		return
	}
	// Put the episode after the podcast since you want to update
	// the fetch date, latest episode timestamp
	log.Info("putting podcast")
	if err := ds.Put(ctx, podcast); err != nil {
		log.Errorf("putting podcast error : %s", err)
	}
}
