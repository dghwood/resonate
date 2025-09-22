package datastore

import (
	"log"
	"reflect"

	"github.com/dghwood/resonate/models"
)

type memoryDatabase struct {
	Data map[string]models.Model
}

func NewMemoryDatabase() memoryDatabase {
	return memoryDatabase{
		Data: make(map[string]models.Model),
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
	dbName := MessageName(entity)
	if val, ok := ds.Data[dbName]; ok {
		return val
	}
	db := NewMemoryDatabase()
	ds.Data[dbName] = db
	return db
}

func (ds *MemoryDatastore) Put(entity models.Model) error {
	database := ds.getDb(entity)
	database.Data[entity.GetId()] = entity
	log.Println(GetFields(entity))
	return nil
}

func (ds *MemoryDatastore) Get(entity models.Model) error {
	database := ds.getDb(entity)
	if val, ok := database.Data[entity.GetId()]; ok {
		models.Merge(entity, val)
		return nil
	}
	return ErrorEntityNotFound
}

func (ds *MemoryDatastore) PutMulti(src any) error {
	entities := reflect.ValueOf(src)
	if entities.Kind() != reflect.Slice {
		return ErrorParameterNotCorrect
	}
	for i := 0; i < entities.Len(); i++ {
		entity := entities.Index(i).Interface().(models.Model)
		database := ds.getDb(entity)
		database.Data[entity.GetId()] = entity
		log.Println(GetFields(entity))
	}
	return nil
}

func (ds *MemoryDatastore) GetMulti(src any) error {
	entities := reflect.ValueOf(src)
	if entities.Kind() != reflect.Slice {
		return ErrorParameterNotCorrect
	}
	for i := 0; i < entities.Len(); i++ {
		entity := entities.Index(i).Interface().(models.Model)
		database := ds.getDb(entity)
		if val, ok := database.Data[entity.GetId()]; ok {
			models.Merge(entity, val)
		} else {
			return ErrorEntityNotFound
		}
	}
	return nil
}

func (ds *MemoryDatastore) Close() {
}
