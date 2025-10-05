package listens

import (
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
)

type List struct {
	Datastore datastore.Datastore
}

func (f List) RequireSignIn() bool { return true }

func (f List) RequestProto() *proto.ListListenMessage_Request {
	return &proto.ListListenMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f List) ResponseProto() *proto.ListListenMessage_Response {
	return &proto.ListListenMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}

func (f *List) Execute(
	loggedInUser *models.LoggedInUser,
	request *proto.ListListenMessage_Request,
	response *proto.ListListenMessage_Response) (err error) {

	// TODO(duncan): Do I need to have permissions here?
	model := models.Listen{}
	Listens := f.Datastore.ListForIds(
		datastore.ListForIdsParams{
			Ids:          []string{request.UserId},
			IdFieldNum:   model.GetUserIdFieldNum(),
			SortFieldNum: -1, // Sort by something?
			Entity:       &model,
		})

	for {
		model := models.Listen{}
		err := Listens.Next(&model)
		if err == datastore.IteratorDone {
			break
		}
		if err != nil {
			return err
		}
		response.Listens = append(
			response.Listens, &model.UserListenMessage)
	}
	return
}
