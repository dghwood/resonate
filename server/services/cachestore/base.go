package cachestore

import (
	"context"
	"errors"
	"time"
)

var (
	ErrNotFound = errors.New("not found")
	ErrExpired  = errors.New("expired")
)

type Cachestore interface {
	Put(ctx context.Context, key string,
		response []byte) (err error)
	Get(ctx context.Context, key string,
		ttl time.Duration) (response []byte, err error)
}
