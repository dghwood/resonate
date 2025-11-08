package find

import (
	"github.com/dghwood/resonate/errors"
	"github.com/dghwood/resonate/log"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
	"github.com/dghwood/resonate/utils"
)

type Users struct {
	Datastore datastore.Datastore
}

func (f Users) RequireSignIn() bool { return true }

func (f Users) RequestProto() *proto.FindContactsMessage_Request {
	return &proto.FindContactsMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f Users) ResponseProto() *proto.FindContactsMessage_Response {
	return &proto.FindContactsMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}

func (f *Users) Execute(
	loggedInUser *models.LoggedInUser,
	request *proto.FindContactsMessage_Request,
	response *proto.FindContactsMessage_Response) (err error) {

	log.Info("FindUsers")

	if len(request.PhoneNumbers) == 0 {
		return errors.ERROR_INTERNAL
	}

	encyptedPhoneNumbers := make([]string, len(request.PhoneNumbers))
	for i, phoneNumber := range request.PhoneNumbers {
		encyptedPhoneNumbers[i] = utils.HashPhoneNumber(phoneNumber)
	}

	var cursor *models.QueryCursor
	cursorPb := request.Cursor
	if cursorPb != nil {
		cursor = &models.QueryCursor{}
		models.Merge(cursor, cursorPb)
	}

	model := &models.User{}
	it := f.Datastore.ListForIds(datastore.ListForIdsParams{
		Ids: encyptedPhoneNumbers,
		// TODO(duncan): I should probably have diff
		// encyrption for ID vs. search ID
		IdFieldNum:   model.GetUserIdFieldNum(),
		SortFieldNum: -1,
		Entity:       model,
		Cursor:       cursor,
	})

	i := 0
	for {
		model := models.User{}
		err := it.Next(&model)
		if err == datastore.IteratorDone {
			break
		}
		if err != nil {
			return err
		}
		response.Users = append(response.Users, model.ToPublicUser())
		if i > 20 {
			response.Cursor = &it.Cursor().QueryCursor
		}
		i++
	}

	return
}
