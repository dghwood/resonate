package listens

import (
	"github.com/dghwood/resonate/errors"
	"github.com/dghwood/resonate/log"
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

	userId := request.UserId
	if userId == "" {
		log.Info("userId is null, using current user")
		userId = loggedInUser.Id
	}
	if userId == "" {
		return errors.ERROR_INTERNAL
	}
	log.Info("listens for user", "user_id", userId)
	var cursor *models.QueryCursor
	cursorPb := request.Cursor
	log.Info("cursorPb", "cursor_pb", cursorPb)
	if cursorPb != nil {
		cursor = &models.QueryCursor{}
		models.Merge(cursor, cursorPb)
		log.Info("cursor", "cursor", cursor)
	}

	// TODO(duncan): Do I need to have permissions here?
	model := models.Listen{}
	it := f.Datastore.ListForIds(
		datastore.ListForIdsParams{
			Ids:          []string{userId},
			IdFieldNum:   model.GetUserIdFieldNum(),
			SortFieldNum: -1, // Sort by something?
			Entity:       &model,
			Cursor:       cursor,
		})

	listens := make([]*models.Listen, 0)
	episodes := make([]*models.Episode, 0)
	i := 0
	for {
		model := models.Listen{}
		err := it.Next(&model)
		if err == datastore.IteratorDone {
			break
		}
		if err != nil {
			return err
		}
		if request.IncludeEpisodes {
			listens = append(listens, &model)
			episode := &models.Episode{}
			episode.Id = model.EpisodeId
			episodes = append(episodes, episode)
		} else {
			response.Listens = append(
				response.Listens, &model.UserListenMessage)
		}
		if i > 20 {
			response.Cursor = &it.Cursor().QueryCursor
		}
		i++
	}

	if !request.IncludeEpisodes {
		return
	}
	// Now get the episodes
	err = f.Datastore.GetMulti(episodes)
	if err != nil {
		return
	}
	for _, listen := range listens {
		for _, episode := range episodes {
			if listen.EpisodeId == episode.Id {
				listen.Episode = &episode.EpisodeMessage
				response.Listens = append(response.Listens, &listen.UserListenMessage)
			}
		}
	}

	return
}
