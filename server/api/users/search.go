package users

import (
	"strings"

	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
	"github.com/dghwood/resonate/utils"
)

type Search struct {
	Datastore datastore.Datastore
}

func (f Search) RequireSignIn() bool { return true }

func (f Search) RequestProto() *proto.SearchContactsMessage_Request {
	return &proto.SearchContactsMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f Search) ResponseProto() *proto.SearchContactsMessage_Response {
	return &proto.SearchContactsMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}

func (f *Search) Execute(
	loggedInUser *models.LoggedInUser,
	request *proto.SearchContactsMessage_Request,
	response *proto.SearchContactsMessage_Response) (err error) {

	// There are different modes here
	//   * Contacts is populated, then return the contacts.
	//   * Query is populated, then query (in memory)
	//   * Query & Contacts is populated?
	if len(request.Contacts) > 0 {
		return f.ExecuteForContacts(loggedInUser, request, response)
	}

	it := f.Datastore.List(&models.User{})
	// TODO(duncan): Random limit to stop this going crazy
	for range 1000 {
		entity := &models.User{}
		err := it.Next(entity)
		if err == datastore.IteratorDone {
			break
		}
		if err != nil {
			return err
		}

		if request.Query == "" ||
			strings.Contains(strings.ToLower(entity.Name), request.Query) {
			response.Users = append(response.Users, entity.ToPublicUser())
		}
	}

	return
}

func (f *Search) ExecuteForContacts(
	loggedInUser *models.LoggedInUser,
	request *proto.SearchContactsMessage_Request,
	response *proto.SearchContactsMessage_Response) (err error) {

	// Add to datastore
	userContacts := &models.UserContacts{}
	userContacts.SetIdFromUserId(loggedInUser.Id)
	userContacts.Contacts = request.Contacts
	err = f.Datastore.Put(userContacts)
	if err != nil {
		return
	}

	// Find contacts
	// Easier to do this in memory for now
	message := &models.User{}
	users := make([]*models.User, 0)
	it := f.Datastore.List(message)
	for {
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

	for _, contact := range request.Contacts {
		for _, user := range users {
			if utils.HashPhoneNumber(contact.PhoneNumber) == user.EncryptedPhoneNumber {
				response.Users = append(response.Users, user.ToPublicUser())
			}
		}
		// No cursor?
	}
	return
}
