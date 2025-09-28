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
	ErrorEntityNotFound      = errors.New("Datastore not found")
	ErrorParameterNotCorrect = errors.New("parameters are not correct")
	IteratorDone             = errors.New("iterator done")
)

type Iterator interface {
	Next(entity models.Model) (err error)
	Cursor() string
}

type Datastore interface {
	Put(entity models.Model) (err error)
	Get(entity models.Model) (err error)
	PutMulti(entities any) (err error)
	GetMulti(entities any) (err error)
	// This needs to implicitly filter for deleted I think
	ListForIds(
		ids []string,
		idFieldNum int32,
		sortFieldNum int32,
		entity models.Model) (iter Iterator)
	Close()
}
