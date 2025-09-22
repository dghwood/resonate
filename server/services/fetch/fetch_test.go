package fetch

import (
	"testing"
)

func TestFetchGet(t *testing.T) {
	url := "https://feeds.megaphone.fm/how-long-gone"
	client := New()
	body, err := client.Get(Request{Url: url})
	if err != nil {
		t.Error(err)
		return
	}

	if len(body) == 0 {
		t.Error("body is 0")
	}
}

// func TestFetchCachedGet(t *testing.T) {
// 	url := "https://feeds.megaphone.fm/how-long-gone"
// 	client := New()
// 	body, err := client.CachedGet(Request{Url: url}, 120*time.Second)
// 	if err != nil {
// 		t.Error(err)
// 		return
// 	}

// 	if len(body) == 0 {
// 		t.Error("body is 0")
// 	}
// }
