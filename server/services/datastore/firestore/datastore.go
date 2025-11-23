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
	timeout    int
}

func (f *FirestoreDatastore) GetTimeout() int {
	if f.timeout > 0 {
		return f.timeout
	}
	return 10 // Default to 10 seconds
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
	if entity.GetMetadata() != nil && entity.GetMetadata().IsDeleted {
		return datastore.ErrorEntityDeleted
	}
	return
}

func (f *FirestoreDatastore) PutMulti(src any) (err error) {
	entities := reflect.ValueOf(src)
	if entities.Kind() != reflect.Slice {
		return datastore.ErrorParameterNotCorrect
	}
	ctx, _ := getContext(10)
	// TODO(duncan): What is the right number here
	//.              Also you could just increase the timeout
	const batchSize = 100

	for i := 0; i < entities.Len(); i += batchSize {
		end := i + batchSize
		if end > entities.Len() {
			end = entities.Len()
		}

		batchKeys := make([]*firestore.Key, end-i)
		batchDbModels := make([]DatabaseModel, end-i)

		for j := i; j < end; j++ {
			entity := entities.Index(j).Interface().(models.Model)
			model := DatabaseModel{Model: entity}
			batchDbModels[j-i] = model
			key := model.Key()
			batchKeys[j-i] = key
		}
		_, err = f.client.PutMulti(ctx, batchKeys, batchDbModels)
		if err != nil {
			return err // Return on first error, or accumulate errors
		}
	}
	return
}
func (f *FirestoreDatastore) _PutMulti(src any) (err error) {
	entities := reflect.ValueOf(src)
	if entities.Kind() != reflect.Slice {
		return datastore.ErrorParameterNotCorrect
	}
	ctx, _ := getContext(10)
	keys := make([]*firestore.Key, entities.Len())
	dbModels := make([]DatabaseModel, entities.Len())

	// Turn this into a batch operation

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
		// TODO(duncan): Handled deleted entities
	}
	err = f.client.GetMulti(ctx, keys, dbModels)
	// TODO(duncan): This can be a multierror and one can succeed whilst others fail
	return
}

// TODO(duncan): Handle deleted?
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
	includeDeleted := params.IncludeDeleted
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
	if !includeDeleted {
		query = query.FilterField(
			"meta.is_deleted",
			"=",
			false,
		)
	}
	if sortFieldNum > 0 {
		// Descending order (with -)
		query = query.Order(fmt.Sprintf("-%s", getFieldName(sortFieldNum)))
	}
	if params.Limit > 0 {
		query = query.Limit(params.Limit)
	}
	if params.Cursor != nil && params.Cursor.Cursor != "" {
		cursor, err := firestore.DecodeCursor(params.Cursor.Cursor)
		if err != nil {
			// Throw an error?
			log.Error(err)
		}
		query = query.Start(cursor)
	}
	// In the podcast list api I use offset as a way of managing between
	// returning from the URL vs. DB.
	if params.Cursor != nil && params.Cursor.Offset > 0 {
		query = query.Offset(int(params.Cursor.Offset))
	}
	return &FirestoreIterator{
		Iterator: f.client.Run(ctx, query),
	}
}

func getContext(seconds int) (context.Context, context.CancelFunc) {
	ctx, cancel := context.WithTimeout(context.Background(), time.Second*time.Duration(seconds))
	return ctx, cancel
}
