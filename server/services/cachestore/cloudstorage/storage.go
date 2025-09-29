package cloudstorage

import (
	"bytes"
	"context"
	"io"
	"log"
	"time"

	"cloud.google.com/go/storage"
	"github.com/dghwood/resonate/services/cachestore"
)

// const bucket = "resonate-cache"

type StorageStorageCachestore struct {
	bucket string
	client *storage.Client
}

func (d *StorageStorageCachestore) Close() {
	d.client.Close()
}

func NewStorageCachestore() *StorageStorageCachestore {
	ctx, _ := getContext(10)
	client, err := storage.NewClient(ctx)
	if err != nil {
		log.Fatalf("Failed to create client: %v", err)
	}
	return &StorageStorageCachestore{
		client: client,
		bucket: "resonate-cache",
	}
}

// Convience function to generate contexts
func getContext(seconds int) (context.Context, context.CancelFunc) {
	ctx, cancel := context.WithTimeout(
		context.Background(),
		time.Second*time.Duration(seconds))
	return ctx, cancel
}

// func generateKey(request Request) (key string, err error) {
// 	var buf bytes.Buffer
// 	enc := gob.NewEncoder(&buf)
// 	err = enc.Encode(request)
// 	if err != nil {
// 		return
// 	}
// 	hash := sha256.Sum256(buf.Bytes())
// 	key = base64.StdEncoding.EncodeToString(hash[:])
// 	key = strings.ReplaceAll(key, "/", "_")
// 	key = strings.ReplaceAll(key, "+", "-")
// 	// key = string(latin1)
// 	return
// }

func (d *StorageStorageCachestore) Put(key string, response []byte) (err error) {
	log.Println("CACHE::PUT")
	ctx, _ := getContext(10)
	if err != nil {
		return
	}
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

func (d *StorageStorageCachestore) Get(key string, ttl time.Duration) (response []byte, err error) {
	ctx, _ := getContext(10)
	if err != nil {
		log.Println(err)
		err = cachestore.ErrNotFound
		return
	}
	object := d.client.Bucket(d.bucket).Object(key)
	attrs, err := object.Attrs(ctx)
	if err != nil {
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
