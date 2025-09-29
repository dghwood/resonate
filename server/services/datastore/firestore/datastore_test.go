package firestore

import (
	"testing"

	"github.com/dghwood/resonate/services/datastore"
)

func TestFirestoreIsDatastore(t *testing.T) {
	var _ datastore.Datastore = (*FirestoreDatastore)(nil)
}

func TestFirestoreIsDatastoreIterator(t *testing.T) {
	var _ datastore.Iterator = (*FirestoreIterator)(nil)
}
