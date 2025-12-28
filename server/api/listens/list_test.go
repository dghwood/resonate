package listens

import (
	"context"
	"fmt"
	"testing"

	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/services/datastore"
)

func TestList(t *testing.T) {
	ds := datastore.NewMemoryDatastore()
	for i := range 10 {
		model := models.Listen{}
		model.Id = fmt.Sprint(i)
		if i%2 == 0 {
			model.UserId = "123"
		} else {
			model.UserId = "456"
		}

		ds.Put(&model)
	}
	list := &List{Datastore: ds}
	request := list.RequestProto()
	request.UserId = "123"

	response := list.ResponseProto()
	user := models.LoggedInUser{}
	user.IsLoggedIn = true
	user.Id = "456"
	ctx := context.Background()
	err := list.Execute(ctx, &user, request, response)
	if err != nil {
		t.Errorf("Execute() error = %v", err)
	}
	if len(response.Listens) != 5 {
		t.Errorf("len(response.Listens) = %d; want 5", len(response.Listens))
	}
}
