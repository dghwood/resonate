package subscribe

import (
	"context"

	"github.com/dghwood/resonate/log"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
)

type List struct {
	Datastore datastore.Datastore
}

func (f List) RequireSignIn() bool { return true }

func (f List) RequestProto() *proto.ListSubscriptionMessage_Request {
	return &proto.ListSubscriptionMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f List) ResponseProto() *proto.ListSubscriptionMessage_Response {
	return &proto.ListSubscriptionMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}

func (f *List) Execute(
	ctx context.Context,
	loggedInUser *models.LoggedInUser,
	request *proto.ListSubscriptionMessage_Request,
	response *proto.ListSubscriptionMessage_Response) (err error) {

	log.Infof("ListSubscriptions for userId %s", request.UserId)
	// Need to query db for all subscriptions (paging?)
	// a user
	model := models.Subscription{}

	var cursor *models.QueryCursor
	cursorPb := request.Cursor
	if cursorPb != nil {
		cursor = &models.QueryCursor{}
		models.Merge(cursor, cursorPb)
	}

	it := f.Datastore.ListForIds(
		ctx,
		datastore.ListForIdsParams{
			Ids:          []string{request.UserId},
			IdFieldNum:   model.GetUserIdFieldNum(),
			SortFieldNum: -1, // Sort by something?
			Entity:       &model,
			Cursor:       cursor,
		})

	hasMore := true

	podcasts := make([]*models.Podcast, 0)
	for range 20 {
		model := models.Subscription{}
		err := it.Next(&model)
		if err == datastore.IteratorDone {
			hasMore = false
			break
		}
		if err != nil {
			log.Errorf("error in subscription it %s", err)
			return err
		}

		podcast := &models.Podcast{}
		podcast.Id = model.PodcastId
		podcasts = append(podcasts, podcast)

		response.Subscriptions = append(
			response.Subscriptions, &model.UserSubscriptionMessage)
	}
	if hasMore {
		response.Cursor = &it.Cursor().QueryCursor
	}

	if !request.IncludePodcasts {
		return
	}
	// Now get the podcast
	err = f.Datastore.GetMulti(ctx, podcasts)
	if err != nil {
		log.Errorf("getPodcasts %s", err)
		return
	}

	for _, subscription := range response.Subscriptions {
		for _, podcast := range podcasts {
			if subscription.PodcastId == podcast.Id {
				subscription.Podcast = &podcast.PodcastMessage
			}
		}
	}

	return
}
