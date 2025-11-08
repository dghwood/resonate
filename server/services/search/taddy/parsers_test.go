package taddy

import (
	"testing"
	// "github.com/dghwood/resonate/server/models"
)

func TestConstructQuery(t *testing.T) {
	queryBytes, err := constructQuery("query_string")
	if err != nil {
		t.Error(err)
	}
	if len(queryBytes) == 0 {
		t.Error("Query is null")
	}
}
