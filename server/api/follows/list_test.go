package follows

import (
	"fmt"
	"testing"

	"github.com/dghwood/resonate/server/models"
	"github.com/dghwood/resonate/server/services/datastore"
)

func TestList(t *testing.T) {
	ds := datastore.NewMemoryDatastore()
	for i := range 10 {
		model := models.Follow{}
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

	err := list.Execute(&user, request, response)
	if err != nil {
		t.Errorf("Execute() error = %v", err)
	}
	if len(response.Follows) != 5 {
		t.Errorf("len(response.Follows) = %d; want 5", len(response.Follows))
	}
}
