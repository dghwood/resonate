package feed

import (
	"sort"
	"time"

	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
)

func getFollowedUserIds(userId string, ds datastore.Datastore) ([]string, error) {
	model := models.Follow{}
	it := ds.ListForIds(
		datastore.ListForIdsParams{
			Ids:          []string{userId},
			IdFieldNum:   model.GetUserIdFieldNum(),
			SortFieldNum: model.GetFollowTimestampFieldNum(),
			Entity:       &model,
		})

	followedIds := make([]string, 0)
	for {
		model := models.Follow{}
		err := it.Next(&model)
		if err == datastore.IteratorDone {
			break
		}
		if err != nil {
			return nil, err
		}
		followedIds = append(followedIds, model.FollowedUserId)
	}
	return followedIds, nil
}

func getRecentListens(userIds []string, ds datastore.Datastore, since int64) ([]*models.Listen, error) {
	listens := make([]*models.Listen, 0)
	if len(userIds) == 0 {
		return listens, nil
	}

	model := models.Listen{}
	it := ds.ListForIds(
		datastore.ListForIdsParams{
			Ids:          userIds,
			IdFieldNum:   model.GetUserIdFieldNum(),
			SortFieldNum: model.GetListenTimestampFieldNum(),
			Entity:       &model,
		})

	for {
		m := models.Listen{}
		err := it.Next(&m)
		if err == datastore.IteratorDone {
			break
		}
		if err != nil {
			return nil, err
		}
		// ListForIds returns sorted by SortFieldNum descending (implementation detail of MemoryDatastore but assumed generally for feeds)
		// So we can break early.
		if m.ListenTimestamp < since {
			// This assumes descending sort order.
			// MemoryDatastore sorts by SortFieldNum if provided.
			// The implementation in memory.go sorts descending for integers.
			break
		}
		listens = append(listens, &m)
	}
	return listens, nil
}

func getRecentSubscriptions(userIds []string, ds datastore.Datastore, since int64) ([]*models.Subscription, error) {
	subscriptions := make([]*models.Subscription, 0)
	if len(userIds) == 0 {
		return subscriptions, nil
	}

	model := models.Subscription{}
	it := ds.ListForIds(
		datastore.ListForIdsParams{
			Ids:        userIds,
			IdFieldNum: model.GetUserIdFieldNum(),
			// SortFieldNum: -1, // Cannot sort by nested metadata easily
			Entity: &model,
		})

	for {
		m := models.Subscription{}
		err := it.Next(&m)
		if err == datastore.IteratorDone {
			break
		}
		if err != nil {
			return nil, err
		}
		// Check metadata created timestamp
		if m.Metadata != nil && m.Metadata.CreatedTimestamp >= since {
			subscriptions = append(subscriptions, &m)
		}
	}
	return subscriptions, nil
}

func getSocialFeedItems(
	loggedInUserId string,
	ds datastore.Datastore,
) ([]*proto.UserFeedItemRecommendationMessage, error) {

	followedIds, err := getFollowedUserIds(loggedInUserId, ds)
	if err != nil {
		return nil, err
	}

	if len(followedIds) == 0 {
		return []*proto.UserFeedItemRecommendationMessage{}, nil
	}

	// Look back 24 hours
	since := time.Now().Add(-24 * time.Hour).UnixMilli()

	listens, err := getRecentListens(followedIds, ds, since)
	if err != nil {
		return nil, err
	}

	subs, err := getRecentSubscriptions(followedIds, ds, since)
	if err != nil {
		return nil, err
	}

	// Aggregate Listens
	// Map: EpisodeId -> UserIds
	// We also track the max timestamp for sorting
	type group struct {
		UserIds      []string
		MaxTimestamp int64
	}
	listenMap := make(map[string]*group)

	for _, l := range listens {
		if _, ok := listenMap[l.EpisodeId]; !ok {
			listenMap[l.EpisodeId] = &group{UserIds: []string{}}
		}
		listenMap[l.EpisodeId].UserIds = append(listenMap[l.EpisodeId].UserIds, l.UserId)
		if l.ListenTimestamp > listenMap[l.EpisodeId].MaxTimestamp {
			listenMap[l.EpisodeId].MaxTimestamp = l.ListenTimestamp
		}
	}

	// Aggregate Subscriptions
	// Map: PodcastId -> UserIds
	subMap := make(map[string]*group)
	for _, s := range subs {
		if _, ok := subMap[s.PodcastId]; !ok {
			subMap[s.PodcastId] = &group{UserIds: []string{}}
		}
		subMap[s.PodcastId].UserIds = append(subMap[s.PodcastId].UserIds, s.UserId)
		if s.Metadata != nil && s.Metadata.CreatedTimestamp > subMap[s.PodcastId].MaxTimestamp {
			subMap[s.PodcastId].MaxTimestamp = s.Metadata.CreatedTimestamp
		}
	}

	type sortableItem struct {
		Timestamp int64
		Item      *proto.UserFeedItemRecommendationMessage
	}
	items := make([]sortableItem, 0)

	// Process Listens
	for episodeId, grp := range listenMap {
		userIds := uniqueStrings(grp.UserIds)
		users, err := getUsers(userIds, ds)
		if err != nil {
			continue
		}

		episode := &models.Episode{}
		episode.Id = episodeId
		if err := ds.Get(episode); err != nil {
			continue // Skip if episode not found
		}

		items = append(items, sortableItem{
			Timestamp: grp.MaxTimestamp,
			Item: &proto.UserFeedItemRecommendationMessage{
				Episode:     &episode.EpisodeMessage,
				UserListens: users,
			},
		})
	}

	// Process Subscriptions
	for podcastId, grp := range subMap {
		userIds := uniqueStrings(grp.UserIds)
		users, err := getUsers(userIds, ds)
		if err != nil {
			continue
		}

		podcast := &models.Podcast{}
		podcast.Id = podcastId
		if err := ds.Get(podcast); err != nil {
			continue
		}

		items = append(items, sortableItem{
			Timestamp: grp.MaxTimestamp,
			Item: &proto.UserFeedItemRecommendationMessage{
				Podcast:           &podcast.PodcastMessage,
				UserSubscriptions: users,
			},
		})
	}

	// Sort items descending by timestamp
	sort.Slice(items, func(i, j int) bool {
		return items[i].Timestamp > items[j].Timestamp
	})

	recommendations := make([]*proto.UserFeedItemRecommendationMessage, len(items))
	for i, item := range items {
		recommendations[i] = item.Item
	}

	return recommendations, nil
}

func getUsers(userIds []string, ds datastore.Datastore) ([]*proto.PublicUserMessage, error) {
	// Optimization: Use GetMulti if possible, but ds.GetMulti takes 'any' and expects a slice of models.
	// We need to construct a slice of *models.User
	usersToFetch := make([]*models.User, len(userIds))
	// Because ds.GetMulti expects a slice, we can pass []*models.User directly?
	// The interface is `GetMulti(entities any)`. Implementation does reflection.
	// But we need to set IDs on them.

	for i, id := range userIds {
		u := &models.User{}
		u.Id = id
		usersToFetch[i] = u
	}

	// ds.GetMulti modifies the passed slice elements in place (pointers)
	// But it might return error if ANY not found?
	// MemoryDatastore GetMulti returns ErrorEntityNotFound if ANY is missing.
	// This makes it brittle for social feeds where one user might be deleted.
	// So we stick to individual Get for robustness, or we accept partial failure.
	// Given typical datastore constraints, GetMulti is often all-or-nothing or returns partial errors.
	// MemoryDatastore implementation loops and returns on first error.
	// So we cannot use GetMulti safely here unless we are sure all users exist.
	// Users can be deleted. So individual Get is safer for now, despite N+1.
	// To optimize, we would need a GetMulti that supports partial results or check IsDeleted.

	users := make([]*proto.PublicUserMessage, 0)
	for _, u := range usersToFetch {
		if err := ds.Get(u); err == nil {
			users = append(users, u.ToPublicUser())
		}
	}
	return users, nil
}

func uniqueStrings(input []string) []string {
	u := make([]string, 0, len(input))
	m := make(map[string]bool)

	for _, val := range input {
		if _, ok := m[val]; !ok {
			m[val] = true
			u = append(u, val)
		}
	}
	sort.Strings(u)
	return u
}
