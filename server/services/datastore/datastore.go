/*
	Datastore

Generic wrapper around a datastore implementation
eg. firestore
*/
package datastore

import (
	// "context"

	"context"
	"errors"
	"fmt"

	"github.com/dghwood/resonate/models"
	// "google.golang.org/protobuf/proto"
)

// This is the same implementation as firestore has
type MultiError []error

// This implements the Error interface
func (m MultiError) Error() string {
	return fmt.Sprintf("%d errors", len(m))
}

var (
	ErrorEntityNotFound      = errors.New("Datastore entity not found")
	ErrorEntityDeleted       = errors.New("Datastore entity deleted")
	ErrorParameterNotCorrect = errors.New("parameters are not correct")
	IteratorDone             = errors.New("iterator done")
)

type Iterator interface {
	Next(entity models.Model) (err error)
	Cursor() *models.QueryCursor
}

type ListForIdsParams struct {
	Ids            []string
	IdFieldNum     int32
	SortFieldNum   int32
	Entity         models.Model
	Cursor         *models.QueryCursor
	IncludeDeleted bool
	Limit          int
}

type Datastore interface {
	Put(ctx context.Context, entity models.Model) (err error)
	Get(ctx context.Context, entity models.Model) (err error)
	List(ctx context.Context, entity models.Model) (iter Iterator)
	PutMulti(ctx context.Context, entities any) (err error)
	GetMulti(ctx context.Context, entities any) (err error)
	// This needs to implicitly filter for deleted I think
	ListForIds(ctx context.Context, params ListForIdsParams) (iter Iterator)
	Close()
}
