package users

import (
	"context"

	"github.com/dghwood/resonate/log"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
	"github.com/dghwood/resonate/utils"
)

type Top struct {
	Datastore datastore.Datastore
}

func (f Top) RequireSignIn() bool { return true }

func (f Top) RequestProto() *proto.SearchTopContactsMessage_Request {
	return &proto.SearchTopContactsMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f Top) ResponseProto() *proto.SearchTopContactsMessage_Response {
	return &proto.SearchTopContactsMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}

func (f *Top) Execute(
	ctx context.Context,
	loggedInUser *models.LoggedInUser,
	request *proto.SearchTopContactsMessage_Request,
	response *proto.SearchTopContactsMessage_Response) (err error) {

	// Find contacts
	// Easier to do this in memory for now
	message := &models.User{}
	users := make([]*models.User, 0)
	it := f.Datastore.List(message)
	for range 1000 {
		entity := &models.User{}
		err := it.Next(entity)
		if err == datastore.IteratorDone {
			break
		}
		if err != nil {
			return err
		}

		users = append(users, entity)
	}

	log.Infof("found %d users", len(users))

	// Add to datastore
	if len(request.Contacts) > 0 {
		log.Infof("request has contacts: %d", len(request.Contacts))
		userContacts := &models.UserContacts{}
		userContacts.SetIdFromUserId(loggedInUser.Id)
		userContacts.Contacts = request.Contacts
		err = f.Datastore.Put(userContacts)
		if err != nil {
			log.Error(err)
			return
		}

		for _, contact := range request.Contacts {
			for _, user := range users {
				log.Info(contact.PhoneNumber)
				log.Info(user.PhoneNumber)
				log.Info(utils.HashPhoneNumber(contact.PhoneNumber))
				log.Info(user.EncryptedPhoneNumber)
				if utils.HashPhoneNumber(contact.PhoneNumber) == user.EncryptedPhoneNumber {
					log.Info("found match")
					response.Users = append(response.Users, user.ToPublicUser())
				}
			}
			// No cursor?
		}
		log.Infof("returning contacts: %d", len(response.Users))
		return
	}

	// Just return all the users
	log.Infof("returning all users: %d", len(users))
	for _, user := range users {
		response.Users = append(response.Users, user.ToPublicUser())
	}
	return
}
