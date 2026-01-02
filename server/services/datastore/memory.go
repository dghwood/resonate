package datastore

import (
	"context"
	"reflect"
	"sort"

	"github.com/dghwood/resonate/log"
	"github.com/dghwood/resonate/models"
)

type memoryDatabase struct {
	Data map[string]DatastoreItem
}

func NewMemoryDatabase() memoryDatabase {
	return memoryDatabase{
		Data: make(map[string]DatastoreItem),
	}
}

type MemoryDatastore struct {
	Data map[string]memoryDatabase
}

func NewMemoryDatastore() *MemoryDatastore {
	return &MemoryDatastore{
		Data: make(map[string]memoryDatabase),
	}
}

func (ds *MemoryDatastore) getDb(entity models.Model) memoryDatabase {
	dbName := models.Kind(entity)
	if val, ok := ds.Data[dbName]; ok {
		return val
	}
	db := NewMemoryDatabase()
	ds.Data[dbName] = db
	return db
}

func (ds *MemoryDatastore) Put(ctx context.Context, entity models.Model) error {
	database := ds.getDb(entity)
	database.Data[entity.GetId()] = GetFields(entity)

	return nil
}

func (ds *MemoryDatastore) Get(ctx context.Context, entity models.Model) error {
	database := ds.getDb(entity)
	if val, ok := database.Data[entity.GetId()]; ok {
		RetrieveFields(val, entity)
		return nil
	}
	return ErrorEntityNotFound
}

func (ds *MemoryDatastore) PutMulti(ctx context.Context, src any) error {
	entities := reflect.ValueOf(src)
	if entities.Kind() != reflect.Slice {
		return ErrorParameterNotCorrect
	}
	for i := 0; i < entities.Len(); i++ {
		entity := entities.Index(i).Interface().(models.Model)
		database := ds.getDb(entity)
		database.Data[entity.GetId()] = GetFields(entity)
	}
	return nil
}

func (ds *MemoryDatastore) GetMulti(ctx context.Context, src any) error {
	entities := reflect.ValueOf(src)
	if entities.Kind() != reflect.Slice {
		return ErrorParameterNotCorrect
	}
	for i := 0; i < entities.Len(); i++ {
		entity := entities.Index(i).Interface().(models.Model)
		database := ds.getDb(entity)
		if val, ok := database.Data[entity.GetId()]; ok {
			// models.Merge(entity, val)
			RetrieveFields(val, entity)
		} else {
			return ErrorEntityNotFound
		}
	}
	return nil
}

func (ds *MemoryDatastore) Close() {
}

type MemoryDatastoreIterator struct {
	data []DatastoreItem
	i    int
}

func (it *MemoryDatastoreIterator) Next(entity models.Model) (err error) {
	if it.i >= len(it.data) {
		return IteratorDone
	}
	RetrieveFields(it.data[it.i], entity)
	it.i += 1
	return
}
func (it *MemoryDatastoreIterator) Cursor() *models.QueryCursor {
	cursor := &models.QueryCursor{}
	cursor.Offset = int32(it.i)
	return cursor
}

func (ds *MemoryDatastore) List(ctx context.Context, entity models.Model) (iter Iterator) {
	database := ds.getDb(entity)
	data := make([]DatastoreItem, 0)
	for _, fields := range database.Data {
		data = append(data, fields)
	}
	return &MemoryDatastoreIterator{
		data: data,
		// This should just default to 0
		i: 0,
	}
}

func (ds *MemoryDatastore) ListForIds(
	ctx context.Context,
	params ListForIdsParams,
) Iterator {
	ids := params.Ids
	idFieldNum := params.IdFieldNum
	sortFieldNum := params.SortFieldNum
	entity := params.Entity
	// cursor := params.Cursor

	log.Infof("ListForIds: %s %d %d", ids, idFieldNum, sortFieldNum)
	database := ds.getDb(entity)
	log.Infof("database with %d entries", len(database.Data))

	data := make([]DatastoreItem, 0)
	for _, item := range database.Data {
		for _, field := range item.Fields {
			if field.Number == idFieldNum {
				var value = field.Value.(string)
				for _, userId := range ids {
					if value == userId {
						data = append(data, item)
						break
					}
				}
			}
		}
	}
	log.Infof("data with %d entries", len(data))

	// I'm sure this will throw an error if the wrong type
	if sortFieldNum >= 0 {
		sort.Slice(data, func(i, j int) bool {
			for _, field := range data[i].Fields {
				if field.Number == sortFieldNum {
					for _, field2 := range data[j].Fields {
						if field2.Number == sortFieldNum {
							return field.Value.(int64) > field2.Value.(int64)
						}
					}
				}
			}
			return false
		})
	}

	i := 0
	// Check if Cursor is filled out
	if params.Cursor != nil && params.Cursor.Offset > 0 {
		i = int(params.Cursor.Offset)
	}

	return &MemoryDatastoreIterator{
		data: data,
		// This should just default to 0
		i: i,
	}
}
