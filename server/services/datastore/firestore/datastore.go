package firestore

import (
	"context"
	"log"
	"time"

	firestore "cloud.google.com/go/datastore"
	"github.com/dghwood/resonate/models"
)

type FirestoreIterator struct {
	// Next(entity models.Model) (err error)
	// Cursor() string
}

type FirestoreDatastore struct {
	projectId  string
	databaseId string
	client     *firestore.Client
	// Put(entity models.Model) (err error)
	// Get(entity models.Model) (err error)
	// PutMulti(entities any) (err error)
	// GetMulti(entities any) (err error)
	// // This needs to implicitly filter for deleted I think
	// ListForIds(
	// 	ids []string,
	// 	idFieldNum int32,
	// 	sortFieldNum int32,
	// 	entity models.Model) (iter Iterator)
	// Close()
}

func NewFirestoreDatastore(
	projectId,
	databaseId string) *FirestoreDatastore {
	ctx, _ := getContext(10)
	client, err := firestore.NewClientWithDatabase(ctx, projectId, databaseId)
	if err != nil {
		log.Fatalf("Failed to create client: %v", err)
	}

	return &FirestoreDatastore{
		client:     client,
		projectId:  projectId,
		databaseId: databaseId,
	}
}

func (f *FirestoreDatastore) Close() {
	f.client.Close()
}

func (f *FirestoreDatastore) Put(entity models.Model) (err error) {
	ctx, _ := getContext(10)
	key := firestore.NameKey(
		models.Kind(entity), entity.GetId(), nil)
	// Need to
	_, err = f.client.Put(ctx, key, DatabaseModel{Model: entity})
	return
}

func (f *FirestoreDatastore) Get(entity models.Model) (err error) {
	ctx, _ := getContext(10)
	model := DatabaseModel{Model: entity}
	key := firestore.NameKey(
		models.Kind(entity), entity.GetId(), nil)
	// Need to
	err = f.client.Get(ctx, key, &model)
	return
}

func getContext(seconds int) (context.Context, context.CancelFunc) {
	ctx, cancel := context.WithTimeout(context.Background(), time.Second*time.Duration(seconds))
	return ctx, cancel
}
