package cachestore

import "time"

type MemoryCachestore struct {
	Data map[string][]byte
}

func (m *MemoryCachestore) Put(
	key string,
	response []byte) (err error) {
	m.Data[key] = response
	return
}

func (m *MemoryCachestore) Get(
	key string,
	ttl time.Duration) (response []byte, err error) {
	response = m.Data[key]
	return
}

func NewMemoryCachestore() *MemoryCachestore {
	return &MemoryCachestore{
		Data: make(map[string][]byte),
	}
}
