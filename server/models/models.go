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

/* Episode */
type Episode struct {
	proto.EpisodeMessage
}

func (p *Episode) GetId() string {
	return p.Id
}

// UserListen
type UserListen struct {
	proto.UserListenMessage
}

func (p *UserListen) GetId() string {
	return p.Id
}

// StorageMetadata
type StorageMetadata struct {
	proto.StorageMetadataMessage
}

type UserMessage struct {
	proto.UserMessage
}

// Extended user message
type LoggedInUserMessage struct {
	proto.UserMessage

	IsLoggedIn bool
	Token      *proto.TokenMessage
}

type Subscription struct {
	proto.UserSubscriptionMessage
}
