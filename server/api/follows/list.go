package follows

import (
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
)

type List struct {
	Datastore datastore.Datastore
}

func (f List) RequireSignIn() bool { return true }

func (f List) RequestProto() *proto.ListFollowMessage_Request {
	return &proto.ListFollowMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f List) ResponseProto() *proto.ListFollowMessage_Response {
	return &proto.ListFollowMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}

func (f *List) Execute(
	loggedInUser *models.LoggedInUser,
	request *proto.ListFollowMessage_Request,
	response *proto.ListFollowMessage_Response) (err error) {

	// TODO(duncan): Do I need to have permissions here?
	model := models.Follow{}
	follows := f.Datastore.ListForIds(
		datastore.ListForIdsParams{
			Ids:          []string{request.UserId},
			IdFieldNum:   model.GetUserIdFieldNum(),
			SortFieldNum: -1, // Sort by something?
			Entity:       &model,
		})

	for {
		model := models.Follow{}
		err := follows.Next(&model)
		if err == datastore.IteratorDone {
			break
		}
		if err != nil {
			return err
		}
		response.Follows = append(
			response.Follows, &model.UserFollowMessage)
	}
	return
}
