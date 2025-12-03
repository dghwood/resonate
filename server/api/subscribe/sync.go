package subscribe

import (
	"github.com/dghwood/resonate/log"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
)

type Sync struct {
	Datastore datastore.Datastore
}

func (f Sync) RequireSignIn() bool { return true }

func (f Sync) RequestProto() *proto.SyncSubscriptionsMessage_Request {
	return &proto.SyncSubscriptionsMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f Sync) ResponseProto() *proto.SyncSubscriptionsMessage_Response {
	return &proto.SyncSubscriptionsMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}

func (f *Sync) Execute(
	loggedInUser *models.LoggedInUser,
	request *proto.SyncSubscriptionsMessage_Request,
	response *proto.SyncSubscriptionsMessage_Response) (err error) {

	log.Infof("SyncSubscriptions for userId %s", loggedInUser.Id)

	// Fetch existing subscriptions for the user
	model := models.Subscription{}
	existingSubscriptions := make(map[string]*models.Subscription)

	it := f.Datastore.ListForIds(
		datastore.ListForIdsParams{
			Ids:        []string{loggedInUser.Id},
			IdFieldNum: model.GetUserIdFieldNum(),
			// Include deleted so we can resolve conflicts properly if client sends a live one but server has deleted
			IncludeDeleted: true,
			Entity:         &model,
		})

	for {
		sub := models.Subscription{}
		err = it.Next(&sub)
		if err == datastore.IteratorDone {
			break
		}
		if err != nil {
			log.Errorf("error fetching existing subscriptions: %v", err)
			return err
		}
		existingSubscriptions[sub.PodcastId] = &sub
	}

	// Prepare a map of updates
	updatedSubscriptions := make(map[string]*models.Subscription)

	// Process client subscriptions
	for _, clientSubProto := range request.Subscriptions {
		clientSub := &models.Subscription{UserSubscriptionMessage: *clientSubProto}

		// Ensure userId matches logged in user
		if clientSub.UserId != loggedInUser.Id {
			log.Errorf("User mismatch in sync: %s vs %s", clientSub.UserId, loggedInUser.Id)
			// Should we error or skip? Skipping seems safer.
			continue
		}

		serverSub, exists := existingSubscriptions[clientSub.PodcastId]

		if !exists {
			// Server doesn't have it, add it
			// Wait, if it's marked as deleted in client, and server doesn't have it, we don't need to add it?
			// But maybe we should store the tombstone?
			// "return a full list of resolved messages"
			updatedSubscriptions[clientSub.PodcastId] = clientSub
		} else {
			// Resolve conflict
			clientMeta := clientSub.Metadata
			serverMeta := serverSub.Metadata

			clientUpdated := int64(0)
			if clientMeta != nil {
				clientUpdated = clientMeta.UpdatedTimestamp
			}
			serverUpdated := int64(0)
			if serverMeta != nil {
				serverUpdated = serverMeta.UpdatedTimestamp
			}

			if clientUpdated > serverUpdated {
				// Client is authority
				updatedSubscriptions[clientSub.PodcastId] = clientSub
			} else {
				// Server is authority (or equal)
				updatedSubscriptions[clientSub.PodcastId] = serverSub
			}
		}
	}

	// Add any server subscriptions that were not in the client request
	for podcastId, serverSub := range existingSubscriptions {
		if _, processed := updatedSubscriptions[podcastId]; !processed {
			updatedSubscriptions[podcastId] = serverSub
		}
	}

	// Identify what needs to be written to DB
	// The user said "return a full list of resolved messages".
	// And "assume the client is uploading a full list of subscriptionsmessages".
	// If the client uploaded a full list, then any missing from client list but present in server list means:
	// 1. Client deleted it locally but hasn't synced the deletion? No, if client deleted it, it should send the message with is_deleted=true.
	// 2. Client is stale and doesn't know about a new subscription added elsewhere?
	// In case 2, we keep the server version (which we did above).

	// Now we need to persist changes.
	// We only need to write if the client provided a newer version.
	// OR if we merged lists.

	toWrite := make([]models.Model, 0)

	// Check which ones changed from server state
	for podcastId, resolvedSub := range updatedSubscriptions {
		serverSub, exists := existingSubscriptions[podcastId]

		needsUpdate := false
		if !exists {
			needsUpdate = true
		} else {
			// Compare timestamps to see if we accepted a change from client
			resolvedMeta := resolvedSub.Metadata
			serverMeta := serverSub.Metadata

			resolvedUpdated := int64(0)
			if resolvedMeta != nil {
				resolvedUpdated = resolvedMeta.UpdatedTimestamp
			}
			serverUpdated := int64(0)
			if serverMeta != nil {
				serverUpdated = serverMeta.UpdatedTimestamp
			}

			if resolvedUpdated > serverUpdated {
				needsUpdate = true
			}
		}

		if needsUpdate {
			toWrite = append(toWrite, resolvedSub)
		}

		// Add to response
		response.Subscriptions = append(response.Subscriptions, &resolvedSub.UserSubscriptionMessage)
	}

	if len(toWrite) > 0 {
		// Use PutMulti for batch update
		log.Infof("Updating %d subscriptions", len(toWrite))
		// PutMulti takes `any`, usually slice of struct pointers or interfaces
		err = f.Datastore.PutMulti(toWrite)
		if err != nil {
			log.Errorf("Error saving subscriptions: %v", err)
			return err
		}

		// Update podcast subscription counts?
		// The `Add` handler updates `Podcast.NumSubscriptions`.
		// If we are adding new subscriptions here, we might need to update counts.
		// However, calculating which ones are "newly added" (vs updated or deleted) is tricky in batch.
		// If we want to be correct, we should check `is_deleted` transitions.

		// For now, I will skip updating counts to keep it simple as per instructions "keep it simple".
		// If strict consistency for counts is required, we'd need more logic.
	}

	return nil
}
