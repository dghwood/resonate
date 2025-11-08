package search

import (
	"testing"

	"github.com/dghwood/resonate/services/search/taddy"
)

func TestTopType(t *testing.T) {
	var _ Search = (*taddy.TaddySearchApi)(nil)
}

// // Needs environment variables to run
// func TestSearch(t *testing.T) {
// 	podcasts, _, err := Search("podcast", &server.SearchRequestOptions{})
// 	if err != nil {
// 		t.Error(err)
// 	}
// 	if len(podcasts) == 0 {
// 		t.Error("0 podcasts found")
// 	}
// }
