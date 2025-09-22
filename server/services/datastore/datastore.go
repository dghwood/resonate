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

var ErrorEntityNotFound = errors.New("Datastore not found")
var ErrorParameterNotCorrect = errors.New("parameters are not correct")

type Datastore interface {
	Put(entity models.Model) (err error)
	Get(entity models.Model) (err error)
	PutMulti(entities any) (err error)
	GetMulti(entities any) (err error)
	// Run(ctx context.Context, q *datastore.Query) (it *datastore.Iterator)
	// Errors() DatastoreErrors
	Close()
}
