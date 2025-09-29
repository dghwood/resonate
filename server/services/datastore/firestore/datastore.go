package firestore

import (
	"context"
	"errors"
	"fmt"
	"log"
	"reflect"
	"time"

	firestore "cloud.google.com/go/datastore"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/services/datastore"
	"google.golang.org/api/iterator"
)

type FirestoreIterator struct {
	Iterator *firestore.Iterator
}

func (f *FirestoreIterator) Next(entity models.Model) (err error) {
	_, err = f.Iterator.Next(DatabaseModel{Model: entity})
	if errors.Is(err, iterator.Done) {
		return datastore.IteratorDone
	}
	return
}
func (f *FirestoreIterator) Cursor() string {
	cursor, err := f.Iterator.Cursor()
	if err != nil {
		// TODO(duncan): Throw an error?
		return ""
	}
	return cursor.String()
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
	model := DatabaseModel{Model: entity}
	key := model.Key()
	_, err = f.client.Put(ctx, key, model)
	return
}

func (f *FirestoreDatastore) Get(entity models.Model) (err error) {
	ctx, _ := getContext(10)
	model := DatabaseModel{Model: entity}
	key := model.Key()
	// Need to
	err = f.client.Get(ctx, key, &model)
	if errors.Is(err, datastore.ErrorEntityNotFound) {
		return datastore.ErrorEntityNotFound
	}
	return
}

func (f *FirestoreDatastore) PutMulti(src any) (err error) {
	entities := reflect.ValueOf(src)
	if entities.Kind() != reflect.Slice {
		return datastore.ErrorParameterNotCorrect
	}
	ctx, _ := getContext(10)
	keys := make([]*firestore.Key, entities.Len())
	dbModels := make([]DatabaseModel, entities.Len())

	for i := 0; i < entities.Len(); i++ {
		entity := entities.Index(i).Interface().(models.Model)
		model := DatabaseModel{Model: entity}
		dbModels[i] = model
		key := model.Key()
		keys[i] = key
	}
	_, err = f.client.PutMulti(ctx, keys, dbModels)
	// TODO(duncan): This can be a multierror and one can succeed whilst others fail
	return
}

func (f *FirestoreDatastore) GetMulti(src any) (err error) {
	entities := reflect.ValueOf(src)
	if entities.Kind() != reflect.Slice {
		return datastore.ErrorParameterNotCorrect
	}
	ctx, _ := getContext(10)
	keys := make([]*firestore.Key, entities.Len())
	dbModels := make([]DatabaseModel, entities.Len())

	for i := 0; i < entities.Len(); i++ {
		entity := entities.Index(i).Interface().(models.Model)
		model := DatabaseModel{Model: entity}
		dbModels[i] = model
		key := model.Key()
		keys[i] = key
	}
	err = f.client.GetMulti(ctx, keys, dbModels)
	// TODO(duncan): This can be a multierror and one can succeed whilst others fail
	return
}

func (f *FirestoreDatastore) ListForIds(
	ids []string,
	idFieldNum int32,
	sortFieldNum int32,
	entity models.Model) (iter datastore.Iterator) {

	ctx, _ := getContext(10)
	query := firestore.NewQuery(models.Kind(entity))
	query = query.FilterField(
		getFieldName(idFieldNum),
		"in",
		ids,
	)
	if sortFieldNum >= 0 {
		// Descending order (with -)
		query = query.Order(fmt.Sprintf("-%s", getFieldName(sortFieldNum)))
	}

	return &FirestoreIterator{
		Iterator: f.client.Run(ctx, query),
	}
}

func getContext(seconds int) (context.Context, context.CancelFunc) {
	ctx, cancel := context.WithTimeout(context.Background(), time.Second*time.Duration(seconds))
	return ctx, cancel
}
