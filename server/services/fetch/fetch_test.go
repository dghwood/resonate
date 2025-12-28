package fetch

import (
	"context"
	"testing"

	cacheService "github.com/dghwood/resonate/services/cachestore"
)

func TestKeyGeneration(t *testing.T) {
	request0 := Request{
		Url: "https://feeds.megaphone.fm/how-long-gone",
	}
	request1 := Request{
		Url:  request0.Url,
		Body: []byte("test"),
	}
	key0, err := generateKey(request0)
	if err != nil {
		t.Error(err)
		return
	}
	key1, err := generateKey(request1)
	if err != nil {
		t.Error(err)
		return
	}
	if key1 == key0 {
		t.Error("keys are the same")
	}

}
func TestFetchGet(t *testing.T) {
	url := "https://feeds.megaphone.fm/how-long-gone"
	client := New()
	ctx := context.Background()
	body, err := client.Get(ctx, Request{Url: url})
	if err != nil {
		t.Error(err)
		return
	}

	if len(body) == 0 {
		t.Error("body is 0")
	}
}

func TestFetchGetCache(t *testing.T) {
	url := "https://feeds.megaphone.fm/how-long-gone"
	cachestore := cacheService.NewMemoryCachestore()
	client := NewCached(cachestore)
	ctx := context.Background()
	body, err := client.Post(ctx, Request{Url: url, Body: []byte("test")})
	if err != nil {
		t.Error(err)
		return
	}

	if len(body) == 0 {
		t.Error("body is 0")
	}
}
