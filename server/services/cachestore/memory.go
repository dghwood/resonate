package cachestore

import (
	"context"
	"time"
)

type MemoryCachestore struct {
	Data map[string][]byte
}

func (m *MemoryCachestore) Put(
	ctx context.Context,
	key string,
	response []byte) (err error) {
	m.Data[key] = response
	return
}

func (m *MemoryCachestore) Get(
	ctx context.Context,
	key string,
	ttl time.Duration) (response []byte, err error) {
	response, ok := m.Data[key]
	if !ok {
		err = ErrNotFound
		return
	}
	return
}

func NewMemoryCachestore() *MemoryCachestore {
	return &MemoryCachestore{
		Data: make(map[string][]byte),
	}
}
