package imagestore

import (
	"errors"
	"time"
)

var (
	ErrNotFound = errors.New("not found")
	ErrExpired  = errors.New("expired")
)

type Imagestore interface {
	Put(key string,
		response []byte) (err error)
	Get(key string,
		ttl time.Duration) (response []byte, err error)
}
