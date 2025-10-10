package imagestore

import "time"

type MemoryImageStore struct {
	Data map[string][]byte
}

func (m *MemoryImageStore) Put(
	key string,
	response []byte) (err error) {
	m.Data[key] = response
	return
}

func (m *MemoryImageStore) Get(
	key string,
	ttl time.Duration) (response []byte, err error) {
	response, ok := m.Data[key]
	if !ok {
		err = ErrNotFound
		return
	}
	return
}

func NewMemoryImageStore() *MemoryImageStore {
	return &MemoryImageStore{
		Data: make(map[string][]byte),
	}
}
