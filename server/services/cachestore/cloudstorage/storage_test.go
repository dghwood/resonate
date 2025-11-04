package cloudstorage

import (
	"testing"
	"time"
)

func TestPut(t *testing.T) {
	store := NewStorageCachestore()
	defer store.Close()

	err := store.Put("foo", []byte("bar"))
	if err != nil {
		t.Error(err)
	}

	response, err := store.Get("foo", time.Hour)
	if err != nil {
		t.Error(err)
	}

	if len(response) != 3 {
		t.Error(response)
	}
}
