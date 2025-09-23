package podcast

import (
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
)

type Get struct {
	Datastore datastore.Datastore
}

func (f Get) RequireSignIn() bool { return false }

func (f Get) RequestProto() *proto.GetPodcastMessage_Request {
	return &proto.GetPodcastMessage_Request{}
}
func (f Get) ResponseProto() *proto.GetPodcastMessage_Response {
	return &proto.GetPodcastMessage_Response{}
}

func (f *Get) Execute(
	loggedInUser *models.LoggedInUser,
	request *proto.GetPodcastMessage_Request,
	response *proto.GetPodcastMessage_Response) (err error) {

	id := request.PodcastId
	model := models.Podcast{}
	model.Id = id

	// Try the database, should I try requesting
	err = f.Datastore.Get(&model)
	if err != nil {
		return
	}
	response.Podcast = &model.PodcastMessage
	return
}
