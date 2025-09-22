package fetch

import (
	"bytes"
	"context"
	"crypto/sha256"
	"encoding/base64"
	"encoding/gob"
	"errors"
	"io"
	"log"
	"strings"
	"time"

	// "cloud.google.com/go/datastore"
	// "cloud.google.com/go/datastore"
	"cloud.google.com/go/storage"
)

type CachestoreErrors struct {
	NotFound         error
	Expired          error
	GenerateKeyError error
}

type Cachestore struct {
	client *storage.Client
	Errors CachestoreErrors
}

func (d *Cachestore) Close() {
	d.client.Close()
}

func NewCachestore() *Cachestore {
	ctx, _ := getContext(10)
	client, err := storage.NewClient(ctx)
	if err != nil {
		log.Fatalf("Failed to create client: %v", err)
	}
	return &Cachestore{
		client: client,
		Errors: CachestoreErrors{
			NotFound:         storage.ErrObjectNotExist,
			Expired:          errors.New("cache expired"),
			GenerateKeyError: errors.New("unable to generate key"),
		},
	}
}

// Convience function to generate contexts
func getContext(seconds int) (context.Context, context.CancelFunc) {
	ctx, cancel := context.WithTimeout(context.Background(), time.Second*time.Duration(seconds))
	return ctx, cancel
}

func generateKey(request Request) (key string, err error) {
	var buf bytes.Buffer
	enc := gob.NewEncoder(&buf)
	err = enc.Encode(request)
	if err != nil {
		return
	}
	hash := sha256.Sum256(buf.Bytes())
	key = base64.StdEncoding.EncodeToString(hash[:])
	key = strings.ReplaceAll(key, "/", "_")
	key = strings.ReplaceAll(key, "+", "-")
	// key = string(latin1)
	return
}

const bucket = "resonate-cache"

func (d Cachestore) Put(request Request, response []byte) (err error) {
	log.Println("CACHE::PUT")
	ctx, _ := getContext(10)
	key, err := generateKey(request)
	if err != nil {
		return
	}
	object := d.client.Bucket(bucket).Object(key)
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

func (d Cachestore) Get(request Request, ttl time.Duration) (response []byte, err error) {
	ctx, _ := getContext(10)
	key, err := generateKey(request)
	if err != nil {
		log.Println(err)
		err = d.Errors.GenerateKeyError
		return
	}
	object := d.client.Bucket(bucket).Object(key)
	attrs, err := object.Attrs(ctx)
	if err != nil {
		return
	}
	if time.Since(attrs.Updated) > ttl {
		err = d.Errors.Expired
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
