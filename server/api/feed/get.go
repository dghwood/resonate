package feed

import (
	"github.com/dghwood/resonate/server/log"
	"github.com/dghwood/resonate/server/models"
	"github.com/dghwood/resonate/server/proto"
	"github.com/dghwood/resonate/server/services/datastore"
)

type Get struct {
	Datastore datastore.Datastore
}

func (f Get) RequireSignIn() bool { return true }

func (f Get) RequestProto() *proto.GetFeedMessage_Request {
	return &proto.GetFeedMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f Get) ResponseProto() *proto.GetFeedMessage_Response {
	return &proto.GetFeedMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}

/*
	GetFeedMessage

This has to do a lot
* Get a list of subscriptions
* Get a list of episodes for those subscriptions

TODO(duncan):
* Get a list of followers
* Get a list of subscriptions for followers
* Get a list of episodes for those subscriptions

* Piece that all together in a feed
*/
func (f *Get) Execute(
	loggedInUser *models.LoggedInUser,
	request *proto.GetFeedMessage_Request,
	response *proto.GetFeedMessage_Response) (err error) {

	log.Infof("Execute:%s", loggedInUser.Id)
	podcastIds, err := getUserSubscriptionEpisodeIds(loggedInUser.Id, f.Datastore)
	if err != nil {
		log.Error(err)
		return
	}
	log.Infof("Found %d subscriptions", len(podcastIds))
	episodes, err := getEpisodesForPodcastIds(podcastIds, f.Datastore)
	if err != nil {
		log.Error(err)
		return
	}
	log.Infof("Found %d episodes", len(episodes))
	userFeed := &proto.UserFeedMessage{}
	userFeed.UserId = loggedInUser.Id
	for _, episode := range episodes {
		userFeed.Items = append(userFeed.Items, &proto.UserFeedItemMessage{
			EpisodeItem: &proto.UserFeedItemEpisodeMessage{
				Episode: &episode.EpisodeMessage,
			},
		})
	}
	log.Infof("Returning %d feed items", len(userFeed.Items))
	response.Feed = userFeed
	return
}

func getEpisodesForPodcastIds(
	podcastIds []string,
	ds datastore.Datastore) ([]*models.Episode, error) {
	episodes := make([]*models.Episode, 0)
	if len(podcastIds) == 0 {
		return episodes, nil
	}
	model := models.Episode{}

	it := ds.ListForIds(
		datastore.ListForIdsParams{
			Ids:          podcastIds,
			IdFieldNum:   model.GetPodcastIdFieldNum(),
			SortFieldNum: model.GetPublishTimestampFieldNum(),
			Entity:       &model,
		})
	i := 0
	for {
		if i > 20 {
			break
		}
		model := models.Episode{}
		err := it.Next(&model)
		if err == datastore.IteratorDone {
			break
		}
		if err != nil {
			return episodes, err
		}
		episodes = append(episodes, &model)
		i++
	}
	return episodes, nil

}

func getUserSubscriptionEpisodeIds(
	userId string,
	ds datastore.Datastore) ([]string, error) {
	model := models.Subscription{}
	it := ds.ListForIds(
		datastore.ListForIdsParams{
			Ids:          []string{userId},
			IdFieldNum:   model.GetUserIdFieldNum(),
			SortFieldNum: -1,
			Entity:       &model,
		})

	podcastIds := make([]string, 0)
	for {
		model := models.Subscription{}
		err := it.Next(&model)
		if err == datastore.IteratorDone {
			break
		}
		if err != nil {
			return podcastIds, err
		}
		podcastIds = append(podcastIds, model.PodcastId)
	}
	return podcastIds, nil
}
