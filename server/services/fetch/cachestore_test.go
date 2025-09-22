package fetch

import (
	"testing"
	"time"
)

func TestFingerprint2(t *testing.T) {
	request := Request{
		Url: "https://feeds.megaphone.fm/how-long-gone",
	}
	key, err := generateKey(request)
	if err != nil {
		t.Error(err)
	}
	t.Error(key)
}
func TestFingerprint(t *testing.T) {
	request1 := Request{
		Url:  "http://google.com",
		Body: []byte{1, 2, 3, 4},
		Headers: map[string]string{
			"foo": "bar",
		},
	}
	key1, err := generateKey(request1)
	if err != nil {
		t.Error(err)
	}
	request2 := Request{
		Url:  "http://google.com",
		Body: []byte{1, 2, 3, 4},
		Headers: map[string]string{
			"foo": "bar",
		},
	}
	key2, err := generateKey(request2)
	if err != nil {
		t.Error(err)
	}
	if key1 != key2 {
		t.Error("keys did not match")
	}

	request3 := Request{
		Url:  "http://google.com",
		Body: []byte{1, 2, 3, 4},
	}
	key3, err := generateKey(request3)
	if err != nil {
		t.Error(err)
	}
	if key3 == key1 || key3 == key2 {
		t.Error("keys matched")
	}
}

func TestPutCache(t *testing.T) {
	request := Request{
		Url:  "http://google.com",
		Body: []byte{1, 2, 3, 4},
	}
	response := []byte{5, 6, 7, 8}
	client := NewCachestore()
	err := client.Put(request, response)
	if err != nil {
		t.Error(err)
	}

}

func TestCacheGet(t *testing.T) {
	request := Request{
		Url:  "http://google.com",
		Body: []byte{1, 2, 3, 4},
	}
	response := []byte{5, 6, 7, 8}
	client := NewCachestore()
	cache, err := client.Get(request, 365*24*time.Hour)
	if err != nil {
		t.Error(err)
	}
	if len(cache) != len(response) {
		t.Errorf("cache did not match %d", len(cache))
	}
}

func TestCacheGetZero(t *testing.T) {
	request := Request{
		Url:  "http://google.com",
		Body: []byte{1, 2, 3, 4},
	}
	client := NewCachestore()
	_, err := client.Get(request, 0*time.Hour)
	if err != client.Errors.Expired {
		t.Error(err)
	}
}
