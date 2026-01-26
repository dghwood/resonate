package feed

import (
	"context"
	"slices"

	"github.com/dghwood/resonate/log"
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
	ctx context.Context,
	loggedInUser *models.LoggedInUser,
	request *proto.GetFeedMessage_Request,
	response *proto.GetFeedMessage_Response) (err error) {

	log.Infof("Execute:%s", loggedInUser.Id)
	podcastIds, err := getUserSubscriptionEpisodeIds(ctx, loggedInUser.Id, f.Datastore)
	if err != nil {
		log.Error(err)
		return
	}
	log.Infof("Found %d subscriptions", len(podcastIds))
	episodes, err := getEpisodesForPodcastIds(ctx, podcastIds, f.Datastore)
	if err != nil {
		log.Error(err)
		return
	}
	log.Infof("Found %d subscribed episodes", len(episodes))

	// Add items to feed
	userFeed := &proto.UserFeedMessage{}
	userFeed.UserId = loggedInUser.Id
	for _, episode := range episodes {
		userFeed.Items = append(userFeed.Items, &proto.UserFeedItemMessage{
			EpisodeItem: &proto.UserFeedItemEpisodeMessage{
				Episode:      &episode.EpisodeMessage,
				FeedItemType: proto.FeedItemType_FEED_ITEM_SUBSCRIPTION,
			},
		})
	}
	response.Feed = userFeed
	if !request.IncludeFollowers {
		return
	}

	feedItems := GetFriendsFeed(ctx, loggedInUser.Id, f.Datastore)
	log.Infof("Found %d follower episodes", len(feedItems))
	// Now I need to merge with the current feed
	userFeed.Items = append(userFeed.Items, feedItems...)
	// Sort the items by something custom
	slices.SortFunc(userFeed.Items, func(
		a, b *proto.UserFeedItemMessage) int {
		return getTimestampForComparison(b) - getTimestampForComparison(a)
	})

	// Construct the feed
	return
}

func getTimestampForComparison(item *proto.UserFeedItemMessage) int {
	episodeItem := item.GetEpisodeItem()
	switch episodeItem.GetFeedItemType() {
	case proto.FeedItemType_FEED_ITEM_FOLLOWER_LISTEN:
		// This is in milliseconds whilst publish timestamp is in seconds
		return int(episodeItem.GetUserListens()[0].ListenTimestamp / 1000)
	case proto.FeedItemType_FEED_ITEM_SUBSCRIPTION:
		return int(episodeItem.GetEpisode().GetPublishTimestamp())
	default:
		return 0
	}
}

func getEpisodesForPodcastIds(
	ctx context.Context,
	podcastIds []string,
	ds datastore.Datastore) ([]*models.Episode, error) {
	episodes := make([]*models.Episode, 0)
	if len(podcastIds) == 0 {
		return episodes, nil
	}
	model := models.Episode{}

	it := ds.ListForIds(
		ctx,
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
	ctx context.Context,
	userId string,
	ds datastore.Datastore) ([]string, error) {
	model := models.Subscription{}
	it := ds.ListForIds(
		ctx,
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

func getFollowedUserIds(
	ctx context.Context,
	userId string,
	ds datastore.Datastore) (userIds []string, err error) {

	model := &models.Follow{}
	it := ds.ListForIds(
		ctx,
		datastore.ListForIdsParams{
			Ids:          []string{userId},
			IdFieldNum:   model.GetUserIdFieldNum(),
			SortFieldNum: -1,
			Entity:       model,
		})

	// TODO(duncan): I'm hardcoding this for now
	for _ = range 30 {
		model := &models.Follow{}
		err := it.Next(model)
		if err == datastore.IteratorDone {
			break
		}
		if err != nil {
			log.Error(err)
			return nil, err
		}
		userIds = append(userIds, model.GetFollowedUserId())
	}
	return
}

type EpisodeUserListen struct {
	UserId string
	Listen *models.UserListen
}
type EpisodeUsers struct {
	EpisodeId          string
	EpisodeUserListens []EpisodeUserListen
}

func getListensForUserIds(
	ctx context.Context,
	userIds []string,
	ds datastore.Datastore) (episodeUsers []EpisodeUsers, err error) {

	model := models.UserListen{}
	// TODO(duncan): I probably want to filter this for
	//.              after a certain timestamp
	it := ds.ListForIds(
		ctx,
		datastore.ListForIdsParams{
			Ids:          userIds,
			IdFieldNum:   model.GetUserIdFieldNum(),
			SortFieldNum: model.GetListenTimestampFieldNum(),
			Entity:       &model,
			Limit:        100, // TODO(duncan): Arbitrary limit
		})

	episodeMap := make(map[string]int)
	episodeIds := make([]EpisodeUsers, 0)
	for {
		model := models.UserListen{}
		err := it.Next(&model)
		if err == datastore.IteratorDone {
			break
		}
		if err != nil {
			return nil, err
		}
		// This keeps the listens sorted by timestamp
		// but aggregates the multiple listeners
		episodeIndex, found := episodeMap[model.GetEpisodeId()]
		episodeUserListen := EpisodeUserListen{
			UserId: model.GetUserId(),
			Listen: &model,
		}
		if found {
			// The sorting here will be most recent first
			// maybe it should be something else?
			episodeIds[episodeIndex].EpisodeUserListens = append(
				episodeIds[episodeIndex].EpisodeUserListens,
				episodeUserListen)
		} else {
			episodeIds = append(episodeIds, EpisodeUsers{
				EpisodeId:          model.GetEpisodeId(),
				EpisodeUserListens: []EpisodeUserListen{episodeUserListen},
			})
			episodeMap[model.GetEpisodeId()] = len(episodeIds) - 1
		}
	}
	return episodeIds, nil
}

func GetFriendsFeed(
	ctx context.Context,
	userId string,
	ds datastore.Datastore,
) (feedItems []*proto.UserFeedItemMessage) {

	userIds, err := getFollowedUserIds(ctx, userId, ds)
	if err != nil {
		// TODO(duncan): Don't error out?
		log.Error(err)
		return
	}
	// Get the unique list of episodes (sorted by most recent listen)
	// annotated with users
	episodeUsers, err := getListensForUserIds(ctx, userIds, ds)
	if err != nil || len(episodeUsers) == 0 {
		return
	}

	// I need to get the episode models and public users
	// but first I need to construct the listen of unique
	// models to GetMulti
	userMap := make(map[string]*models.User)
	episodes := make([]*models.Episode, len(episodeUsers))
	for i, episodeUser := range episodeUsers {
		episodes[i] = &models.Episode{}
		episodes[i].SetId(episodeUser.EpisodeId)

		for _, episodeUserListen := range episodeUser.EpisodeUserListens {
			user := &models.User{}
			user.SetId(episodeUserListen.UserId)
			userMap[episodeUserListen.UserId] = user
		}
	}
	users := make([]*models.User, 0, len(userMap))
	for _, user := range userMap {
		users = append(users, user)
	}

	// Now I can get the users & episodes
	err = ds.GetMulti(ctx, users)
	if err != nil {
		return
	}
	err = ds.GetMulti(ctx, episodes)
	if err != nil {
		return
	}

	feedItems = make([]*proto.UserFeedItemMessage, len(episodeUsers))
	for i, episodeUser := range episodeUsers {
		listens := make([]*proto.UserListenMessage, len(episodeUser.EpisodeUserListens))
		for j, episodeUserListen := range episodeUser.EpisodeUserListens {
			publicUser := userMap[episodeUserListen.UserId].ToPublicUser()
			// Note: I'm not using the listen information, including the timestamp
			episodeUserListen.Listen.PublicUser = publicUser
			listens[j] = &episodeUserListen.Listen.UserListenMessage
		}
		feedItem := &proto.UserFeedItemMessage{
			EpisodeItem: &proto.UserFeedItemEpisodeMessage{
				FeedItemType: proto.FeedItemType_FEED_ITEM_FOLLOWER_LISTEN,
				Episode:      &episodes[i].EpisodeMessage,
				UserListens:  listens,
			},
		}
		feedItems[i] = feedItem
	}
	return
}
