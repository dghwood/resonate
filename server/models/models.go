/*
Base Model

	These are wrappers around the Proto objects
*/
package models

import (
	// "context"

	"github.com/dghwood/resonate/proto"
	pb "google.golang.org/protobuf/proto"
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

/* Podcast */
type Podcast struct {
	proto.PodcastMessage
}

func (p *Podcast) GetId() string {
	return p.Id
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

func (p *User) New() Model {
	return &User{}
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
