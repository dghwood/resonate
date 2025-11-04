package firestore

import (
	"context"
	"errors"
	"fmt"

	"reflect"
	"time"

	firestore "cloud.google.com/go/datastore"
	"github.com/dghwood/resonate/log"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/services/datastore"
	"google.golang.org/api/iterator"
)

type FirestoreIterator struct {
	Iterator *firestore.Iterator
}

func (f *FirestoreIterator) Next(entity models.Model) (err error) {
	_, err = f.Iterator.Next(&DatabaseModel{Model: entity})
	if errors.Is(err, iterator.Done) {
		return datastore.IteratorDone
	}
	return
}
func (f *FirestoreIterator) Cursor() *models.QueryCursor {
	cursor, err := f.Iterator.Cursor()
	if err != nil {
		// TODO(duncan): Throw an error?
		log.Error(err)
		return nil
	}
	queryCursor := &models.QueryCursor{}
	queryCursor.Cursor = cursor.String()
	return queryCursor
}

type FirestoreDatastore struct {
	projectId  string
	databaseId string
	client     *firestore.Client
}

func NewFirestoreDatastore(
	projectId,
	databaseId string) *FirestoreDatastore {
	ctx, _ := getContext(10)
	client, err := firestore.NewClientWithDatabase(ctx, projectId, databaseId)
	if err != nil {
		log.Errorf("Failed to create client: %v", err)
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
	log.Infof("Putting key: %s", key)
	_, err = f.client.Put(ctx, key, &model)
	return
}

func (f *FirestoreDatastore) Get(entity models.Model) (err error) {
	ctx, _ := getContext(10)
	model := DatabaseModel{Model: entity}
	key := model.Key()
	log.Infof("Getting key: %s", key)
	err = f.client.Get(ctx, key, &model)
	if errors.Is(err, firestore.ErrNoSuchEntity) {
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

func (f *FirestoreDatastore) List(
	entity models.Model) (iter datastore.Iterator) {

	ctx, _ := getContext(10)
	query := firestore.NewQuery(models.Kind(entity))
	return &FirestoreIterator{
		Iterator: f.client.Run(ctx, query),
	}
}

func (f *FirestoreDatastore) ListForIds(
	params datastore.ListForIdsParams) (iter datastore.Iterator) {

	ids := params.Ids
	idFieldNum := params.IdFieldNum
	sortFieldNum := params.SortFieldNum
	entity := params.Entity
	// cursor := params.Cursor

	// Convert to interface
	// TODO(duncan): Make the interface accept any instead
	anyIds := make([]any, len(ids))
	for i, id := range ids {
		anyIds[i] = id
	}
	ctx, _ := getContext(10)
	query := firestore.NewQuery(models.Kind(entity))
	query = query.FilterField(
		getFieldName(idFieldNum),
		"in",
		anyIds,
	)
	if sortFieldNum >= 0 {
		// Descending order (with -)
		query = query.Order(fmt.Sprintf("-%s", getFieldName(sortFieldNum)))
	}
	if params.Cursor != nil && params.Cursor.Cursor != "" {
		cursor, err := firestore.DecodeCursor(params.Cursor.Cursor)
		if err != nil {
			// Throw an error?
			log.Error(err)
		}
		query = query.Start(cursor)
	}
	log.Print(query)
	return &FirestoreIterator{
		Iterator: f.client.Run(ctx, query),
	}
}

func getContext(seconds int) (context.Context, context.CancelFunc) {
	ctx, cancel := context.WithTimeout(context.Background(), time.Second*time.Duration(seconds))
	return ctx, cancel
}
