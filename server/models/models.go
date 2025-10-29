/*
Base Model

	These are wrappers around the Proto objects
*/
package models

import (
	// "context"

	"fmt"

	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/utils"
	pb "google.golang.org/protobuf/proto"
)

const (
	// TODO(duncan): Move to ENV variables
	USER_ID_SALT = "this-is-a-salt-dont-leave-it-here"
)

type Model interface {
	pb.Message
	GetId() string
	GetMetadata() *proto.StorageMetadataMessage
}

// Mainly used to enable list for user
// methods in the datastore
type UserModel interface {
	Model
	GetUserId() string
	GetUserIdFieldNum() int32
}

func Merge(to, from pb.Message) {
	pb.Merge(to, from)
}

func Kind(model Model) string {
	return string(model.ProtoReflect().Descriptor().FullName())
}

/* Podcast */
type Podcast struct {
	proto.PodcastMessage
}

func (p *Podcast) GetId() string {
	return p.Id
}

func (p *Podcast) SetIdFromUrl(url string) string {
	p.Id = utils.Base64Encode(url)
	p.Url = url
	return p.Id
}

func (p *Podcast) GetUrlFromId() (url string, err error) {
	url, err = utils.Base64Decode(p.Id)
	if err != nil {
		return
	}
	p.Url = url
	return
}

func (p *Podcast) New() Model {
	return &Podcast{}
}

/* Episode */
type Episode struct {
	proto.EpisodeMessage
}

func (p *Episode) GetMessage() *proto.EpisodeMessage {
	return &p.EpisodeMessage
}

func (p *Episode) GetId() string {
	return p.Id
}

func (p *Episode) New() Model {
	return &Episode{}
}

func (p *Episode) GetPodcastIdFieldNum() int32 {
	return 2
}
func (p *Episode) GetPublishTimestampFieldNum() int32 {
	return 8
}

// UserListen
type UserListen struct {
	proto.UserListenMessage
}

func (p *UserListen) GetId() string {
	return p.Id
}

func (p *UserListen) New() Model {
	return &UserListen{}
}

// StorageMetadata
type StorageMetadata struct {
	proto.StorageMetadataMessage
}

type User struct {
	proto.UserMessage
}

func (p *User) GetUserIdFieldNum() int32 {
	return 1
}

func (p *User) SetIdFromPhoneNumber(phoneNumber string) {
	// TODO(duncan): Change this.. ?
	// p.Id = utils.HashPhoneNumber(phoneNumber)
	p.Id = utils.GenerateUniqueID()
	// Should I even store this?
	p.PhoneNumber = phoneNumber
	p.EncryptedPhoneNumber = utils.HashPhoneNumber(phoneNumber)
}

func (p *User) New() Model {
	return &User{}
}

func (p *User) ToPublicUser() *proto.PublicUserMessage {
	return &proto.PublicUserMessage{
		Id:       p.Id,
		Name:     p.Name,
		ImageUrl: p.ImageUrl,
	}
}

// Extended user message
type LoggedInUser struct {
	proto.UserMessage

	IsLoggedIn bool
	Token      *proto.TokenMessage
}

func (p *LoggedInUser) New() Model {
	// This won't work
	return &LoggedInUser{}
}

// Subscription
type Subscription struct {
	proto.UserSubscriptionMessage
}

func (p *Subscription) GetUserIdFieldNum() int32 {
	return 2
}

func (p *Subscription) New() Model {
	// This won't work
	return &Subscription{}
}

// Listen
type Listen struct {
	proto.UserListenMessage
}

func (p *Listen) GetUserIdFieldNum() int32 {
	return 2
}

type Follow struct {
	proto.UserFollowMessage
}

func (p *Follow) GetUserIdFieldNum() int32 {
	return 2
}

func (p *Follow) GetFollowedUserIdFieldNum() int32 {
	return 3
}

func (p *Follow) GetFollowTimestampFieldNum() int32 {
	return 4
}

type LoginAttempt struct {
	proto.LoginAttempt
}

func (p *LoginAttempt) GetId() string {
	// TODO(duncan): Add something unique to this like the time
	return utils.HashString(p.PhoneNumber)
}

type RefreshTokens struct {
	proto.RefreshTokensMessage
}

func (p *RefreshTokens) GetId() string {
	return fmt.Sprintf("refresh-token-%s", p.UserId)
}

type QueryCursor struct {
	proto.QueryCursor
}

type UserContact struct {
	proto.UserContactMessage
}

type UserContacts struct {
	proto.UserContactsMessage
}

func (u *UserContacts) SetIdFromUserId(userId string) {
	u.Id = "contacts-" + userId
	u.UserId = userId
}
