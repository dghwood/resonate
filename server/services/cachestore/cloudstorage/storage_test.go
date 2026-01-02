package cloudstorage

import (
	"context"
	"testing"
	"time"
)

func TestPut(t *testing.T) {
	store := NewStorageCachestore("rxyz-fetch-cache")
	defer store.Close()
	ctx := context.Background()
	err := store.Put(ctx, "foo", []byte("bar"))
	if err != nil {
		t.Error(err)
	}

	response, err := store.Get(ctx, "foo", time.Hour)
	if err != nil {
		t.Error(err)
	}

	if len(response) != 3 {
		t.Error(response)
	}
}
