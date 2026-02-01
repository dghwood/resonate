package follows

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
	ctx context.Context,
	loggedInUser *models.LoggedInUser,
	request *proto.ListFollowMessage_Request,
	response *proto.ListFollowMessage_Response) (err error) {

	userId := request.UserId
	includeUsers := request.IncludeUsers
	// Whether to return followed or following users
	isFollowed := request.IsFollowed

	log.Infof("follows for user %s", userId)

	var cursor *models.QueryCursor
	if cursorPb := request.Cursor; cursorPb != nil {
		cursor = &models.QueryCursor{}
		models.Merge(cursor, cursorPb)
	}

	// TODO(duncan): Do I need to have permissions here?
	model := models.Follow{}
	idFieldNum := model.GetUserIdFieldNum()
	if isFollowed {
		idFieldNum = model.GetFollowedUserIdFieldNum()
	}
	log.Infof("idFieldNum: %d", idFieldNum)
	follows := f.Datastore.ListForIds(
		ctx,
		datastore.ListForIdsParams{
			Ids:          []string{userId},
			IdFieldNum:   idFieldNum,
			SortFieldNum: model.GetFollowTimestampFieldNum(),
			Entity:       &model,
		})

	users := make([]*models.User, 0)

	more := true
	for range 20 {
		model := models.Follow{}
		err := follows.Next(&model)
		if err == datastore.IteratorDone {
			more = true
			break
		}
		if err != nil {
			log.Error(err)
			return err
		}
		response.Follows = append(
			response.Follows, &model.UserFollowMessage)
		if includeUsers {
			user := &models.User{}
			if isFollowed {
				user.Id = model.UserId
			} else {
				user.Id = model.FollowedUserId
			}
			users = append(users, user)
		}
	}
	log.Infof("Got %d users", len(response.Follows))

	if more {
		response.Cursor = &follows.Cursor().QueryCursor
	}

	if !includeUsers {
		return
	}
	// Now get the users
	err = f.Datastore.GetMulti(ctx, users)
	for _, follow := range response.Follows {
		for _, user := range users {
			if isFollowed {
				if follow.UserId == user.Id {
					follow.User = user.ToPublicUser()
				}
			} else {
				if follow.FollowedUserId == user.Id {
					follow.User = user.ToPublicUser()
				}
			}
		}
	}
	return
}
