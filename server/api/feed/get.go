package feed

import (
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
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

	podcastIds, err := getUserSubscriptionEpisodeIds(loggedInUser.Id, f.Datastore)
	if err != nil {
		return
	}
	episodes, err := getEpisodesForPodcastIds(podcastIds, f.Datastore)
	if err != nil {
		return
	}
	userFeed := &proto.UserFeedMessage{}
	userFeed.UserId = loggedInUser.Id
	for _, episode := range episodes {
		userFeed.Items = append(userFeed.Items, &proto.UserFeedItemMessage{
			EpisodeItem: &proto.UserFeedItemEpisodeMessage{
				Episode: &episode.EpisodeMessage,
			},
		})
	}
	response.Feed = userFeed
	return
}

func getEpisodesForPodcastIds(
	podcastIds []string,
	ds datastore.Datastore) ([]*models.Episode, error) {
	model := models.Episode{}
	it := ds.ListForIds(
		podcastIds,
		model.GetPodcastIdFieldNum(),
		model.GetPublishTimestampFieldNum(),
		&models.Episode{},
	)
	episodes := make([]*models.Episode, 0)
	for {
		model := models.Episode{}
		err := it.Next(&model)
		if err == datastore.IteratorDone {
			break
		}
		if err != nil {
			return episodes, err
		}
		episodes = append(episodes, &model)
	}
	return episodes, nil

}

func getUserSubscriptionEpisodeIds(
	userId string,
	ds datastore.Datastore) ([]string, error) {
	model := models.Subscription{}
	it := ds.ListForIds(
		[]string{userId},
		model.GetUserIdFieldNum(),
		-1, // Sort by something?
		&models.Subscription{},
	)

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
