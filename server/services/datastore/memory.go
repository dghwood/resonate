package datastore

import (
	"log"
	"reflect"

	"github.com/dghwood/resonate/models"
)

type MemoryDatastore struct {
	Data map[string]models.Model
}

func NewMemoryDatastore() *MemoryDatastore {
	return &MemoryDatastore{
		Data: make(map[string]models.Model),
	}
}

func (ds *MemoryDatastore) Put(entity models.Model) error {
	ds.Data[entity.GetId()] = entity
	log.Println(GetFields(entity))
	return nil
}

func (ds *MemoryDatastore) Get(entity models.Model) error {
	if val, ok := ds.Data[entity.GetId()]; ok {
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
		ds.Data[entity.GetId()] = entity
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
		if val, ok := ds.Data[entity.GetId()]; ok {
			models.Merge(entity, val)
		} else {
			return ErrorEntityNotFound
		}
	}
	return nil
}

func (ds *MemoryDatastore) Close() {
}
