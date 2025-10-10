package cloudstorage

import (
	"bytes"
	"context"
	"errors"
	"io"
	"log"
	"time"

	"cloud.google.com/go/storage"
	"github.com/dghwood/resonate/services/cachestore"
)

type StorageImagestore struct {
	bucket string
	client *storage.Client
}

func (d *StorageImagestore) Close() {
	d.client.Close()
}

func NewStorageCachestore() *StorageImagestore {
	ctx, _ := getContext(10)
	client, err := storage.NewClient(ctx)
	if err != nil {
		log.Fatalf("Failed to create client: %v", err)
	}
	return &StorageImagestore{
		client: client,
		bucket: "resonate-images",
	}
}

// Convience function to generate contexts
func getContext(seconds int) (context.Context, context.CancelFunc) {
	ctx, cancel := context.WithTimeout(
		context.Background(),
		time.Second*time.Duration(seconds))
	return ctx, cancel
}

func (d *StorageImagestore) Put(key string, response []byte) (err error) {
	ctx, _ := getContext(10)
	object := d.client.Bucket(d.bucket).Object(key)
	writer := object.NewWriter(ctx)
	buffer := bytes.NewBuffer(response)
	_, err = io.Copy(writer, buffer)
	if err != nil {
		writer.Close()
		return
	}
	err = writer.Close()
	return
}

func (d *StorageImagestore) Get(key string, ttl time.Duration) (response []byte, err error) {
	ctx, _ := getContext(10)
	object := d.client.Bucket(d.bucket).Object(key)
	attrs, err := object.Attrs(ctx)
	if err != nil {
		if errors.Is(err, storage.ErrObjectNotExist) {
			err = cachestore.ErrNotFound
			return
		}
		return
	}
	if time.Since(attrs.Updated) > ttl {
		err = cachestore.ErrExpired
		return
	}
	reader, err := object.NewReader(ctx)
	if err != nil {
		return
	}
	buffer := bytes.NewBuffer(response)
	_, err = io.Copy(buffer, reader)
	if err != nil {
		reader.Close()
	}
	response, err = io.ReadAll(buffer)
	if err != nil {
		reader.Close()
		return
	}
	err = reader.Close()
	return
}
