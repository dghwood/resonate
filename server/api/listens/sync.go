package listens

import (
	"context"

	"github.com/dghwood/resonate/log"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
)

type Sync struct {
	Datastore datastore.Datastore
}

func (f Sync) RequireSignIn() bool { return true }

func (f Sync) RequestProto() *proto.SyncListenMessage_Request {
	return &proto.SyncListenMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f Sync) ResponseProto() *proto.SyncListenMessage_Response {
	return &proto.SyncListenMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}

func (f *Sync) Execute(
	ctx context.Context,
	loggedInUser *models.LoggedInUser,
	request *proto.SyncListenMessage_Request,
	response *proto.SyncListenMessage_Response) (err error) {

	log.Infof("Sync Listens for userId %s", loggedInUser.Id)

	// I need to reconcile the Listens provided with the db
	// reconcilation should be done at last updated timestamp.

	authorativeListens := make(map[string]*proto.UserListenMessage)
	model := &models.Listen{}
	it := f.Datastore.ListForIds(
		ctx,
		datastore.ListForIdsParams{
			Ids:            []string{loggedInUser.Id},
			IdFieldNum:     model.GetUserIdFieldNum(),
			Entity:         model,
			IncludeDeleted: true,
		})

	for {
		model := models.Listen{}
		err := it.Next(&model)
		if err == datastore.IteratorDone {
			break
		}
		if err != nil {
			log.Errorf("error in Listen it %s", err)
			return err
		}
		authorativeListens[model.EpisodeId] = &model.UserListenMessage
	}

	subcriptionClientMap := make(map[string]bool)
	for _, listen := range request.GetListens() {
		subcriptionClientMap[listen.GetId()] = true
		// If the Listen does exist ()
		dbListen, ok := authorativeListens[listen.GetEpisodeId()]
		if !ok {
			// Not in DB
			if !listen.GetMetadata().GetIsDeleted() {
				// Add if not deleted
				authorativeListens[listen.GetEpisodeId()] = listen
			}
			continue
		}
		// Reconcile the two versions
		if listen.GetMetadata().GetUpdatedTimestamp() >
			dbListen.GetMetadata().GetUpdatedTimestamp() {
			// client is the authority
			authorativeListens[listen.GetEpisodeId()] = listen
		}
	}

	// For any Listens from the server not on the client
	// load the episode message
	episodeModels := make([]*models.Episode, 0)
	for _, listen := range authorativeListens {
		if _, ok := subcriptionClientMap[listen.GetId()]; !ok {
			episode := &models.Episode{}
			episode.SetId(listen.GetEpisodeId())
			episodeModels = append(episodeModels, episode)
		}
	}

	if len(episodeModels) > 0 {
		err := f.Datastore.GetMulti(ctx, episodeModels)
		if err != nil {
			log.Errorf("error getting episodes %s", err)
			return err
		}
		for _, podcast := range episodeModels {
			authorativeListens[podcast.Id].Episode = &podcast.EpisodeMessage
		}
		log.Infof("loaded %d episodes", len(episodeModels))
	}

	// Return Listens
	// TODO(duncan): Should I delete the deleted ones?
	for _, listen := range authorativeListens {
		response.Listens = append(response.Listens, listen)
	}
	log.Infof("returning %d Listens", len(response.Listens))
	return
}
