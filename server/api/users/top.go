package users

import (
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

	log.Info("found users", "num_users", len(users))

	// Add to datastore
	if len(request.Contacts) > 0 {
		log.Info("request has contacts", "num_contacts", len(request.Contacts))
		userContacts := &models.UserContacts{}
		userContacts.SetIdFromUserId(loggedInUser.Id)
		userContacts.Contacts = request.Contacts
		err = f.Datastore.Put(userContacts)
		if err != nil {
			log.Error("error putting user contacts", "error", err)
			return
		}

		for _, contact := range request.Contacts {
			for _, user := range users {
				log.Info("contact phone number", "phone_number", contact.PhoneNumber)
				log.Info("user phone number", "phone_number", user.PhoneNumber)
				log.Info("hashed contact phone number", "hashed_phone_number", utils.HashPhoneNumber(contact.PhoneNumber))
				log.Info("encrypted user phone number", "encrypted_phone_number", user.EncryptedPhoneNumber)
				if utils.HashPhoneNumber(contact.PhoneNumber) == user.EncryptedPhoneNumber {
					log.Info("found match")
					response.Users = append(response.Users, user.ToPublicUser())
				}
			}
			// No cursor?
		}
		log.Info("returning contacts", "num_contacts", len(response.Users))
		return
	}

	// Just return all the users
	log.Info("returning all users", "num_users", len(users))
	for _, user := range users {
		response.Users = append(response.Users, user.ToPublicUser())
	}
	return
}
