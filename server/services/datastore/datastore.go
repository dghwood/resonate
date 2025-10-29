/*
	Datastore

Generic wrapper around a datastore implementation
eg. firestore
*/
package datastore

import (
	// "context"

	"errors"

	"github.com/dghwood/resonate/models"
	// "google.golang.org/protobuf/proto"
)

var (
	ErrorEntityNotFound      = errors.New("Datastore entity not found")
	ErrorParameterNotCorrect = errors.New("parameters are not correct")
	IteratorDone             = errors.New("iterator done")
)

type Iterator interface {
	Next(entity models.Model) (err error)
	Cursor() *models.QueryCursor
}

type ListForIdsParams struct {
	Ids          []string
	IdFieldNum   int32
	SortFieldNum int32
	Entity       models.Model
	Cursor       *models.QueryCursor
}

type Datastore interface {
	Put(entity models.Model) (err error)
	Get(entity models.Model) (err error)
	List(entity models.Model) (iter Iterator)
	PutMulti(entities any) (err error)
	GetMulti(entities any) (err error)
	// This needs to implicitly filter for deleted I think
	ListForIds(params ListForIdsParams) (iter Iterator)
	Close()
}
