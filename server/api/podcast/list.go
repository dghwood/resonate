package podcast

import (
	"github.com/dghwood/resonate/log"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/proto"
	"github.com/dghwood/resonate/services/datastore"
	"github.com/dghwood/resonate/services/fetch"
	"github.com/dghwood/resonate/services/rss"
	"github.com/dghwood/resonate/utils"
)

type List struct {
	Datastore   datastore.Datastore
	FetchClient *fetch.Client
}

func (f List) RequireSignIn() bool { return false }

func (f List) RequestProto() *proto.ListPodcastEpisodesMessage_Request {
	return &proto.ListPodcastEpisodesMessage_Request{
		RequestInfo: &proto.RequestInfo{},
	}
}
func (f List) ResponseProto() *proto.ListPodcastEpisodesMessage_Response {
	return &proto.ListPodcastEpisodesMessage_Response{
		ResponseInfo: &proto.ResponseInfo{},
	}
}

func (f *List) executeFromDatabase(
	podcast *models.Podcast,
	loggedInUser *models.LoggedInUser,
	request *proto.ListPodcastEpisodesMessage_Request,
	response *proto.ListPodcastEpisodesMessage_Response) (err error) {
	log.Info("List::executeFromDatabase")
	var cursor *models.QueryCursor
	cursorPb := request.Cursor
	log.Info("cursorPb: ", cursorPb)
	if cursorPb != nil {
		cursor = &models.QueryCursor{}
		models.Merge(cursor, cursorPb)
		log.Info("cursor: ", cursor)
	}
	// Check the updated timestamp, and request the episodes from DB
	episode := &models.Episode{}
	it := f.Datastore.ListForIds(
		datastore.ListForIdsParams{
			Ids:          []string{podcast.Id},
			IdFieldNum:   episode.GetPodcastIdFieldNum(),
			SortFieldNum: episode.GetPublishTimestampFieldNum(),
			Entity:       episode,
			Cursor:       cursor,
		})

	i := 0
	for {
		episode := models.Episode{}
		er := it.Next(&episode)
		if er == datastore.IteratorDone {
			break
		}
		if er != nil {
			log.Error(er)
			return er
		}
		if i > 20 {
			cursor := it.Cursor()
			if cursor != nil {
				response.Cursor = &cursor.QueryCursor
				log.Info("returned cursor: ", response.Cursor)
			}
			break
		}
		i++
		response.Episodes = append(
			response.Episodes, &episode.EpisodeMessage)
	}
	log.Infof("returning %d episodes", len(response.Episodes))
	return
}
func (f *List) Execute(
	loggedInUser *models.LoggedInUser,
	request *proto.ListPodcastEpisodesMessage_Request,
	response *proto.ListPodcastEpisodesMessage_Response) (err error) {

	log.Info("List::Execute")

	id := request.PodcastId
	log.Info("fetching podcast for : ", id)

	podcast := &models.Podcast{}
	podcast.Id = id
	url, err := podcast.GetUrlFromId()
	if err != nil {
		log.Error(err)
		return
	}

	// Try the database,
	if f.Datastore.Get(podcast) == nil &&
		podcast.LatestEpisodeTimestamp > 0 &&
		// Move this to models?
		// This returns from the DB if the podcast has been fetched in the last 12 hours
		utils.TimestampDelta(
			podcast.LastFetchTimestamp,
			utils.Now()).Hours() < 12 {
		return f.executeFromDatabase(podcast, loggedInUser, request, response)
	}

	updatedPodcast, episodes, err := rss.Get(url, f.FetchClient)
	// Don't let the updated podcast override other fields
	models.Merge(podcast, &updatedPodcast)
	if err != nil {
		log.Error(err)
		return
	}

	response.Podcast = &podcast.PodcastMessage
	for i, episode := range episodes {
		if i > 20 {
			break
		}
		// Need to figure out the cursor options for this?
		response.Episodes = append(response.Episodes, &episode.EpisodeMessage)
		cursor := models.NewOffsetCursor(20)
		response.Cursor = &cursor.QueryCursor

	}
	go f.asyncSyncToDatabase(podcast, episodes)
	return
}

func (f *List) asyncSyncToDatabase(
	podcast *models.Podcast,
	episodes []*models.Episode,
) {
	// TODO(duncan): This takes too long
	if err := f.Datastore.PutMulti(episodes); err != nil {
		log.Errorf("putting episodes error : %s", err)
		return
	}
	// Put the episode after the podcast since you want to update
	// the fetch date, latest episode timestamp
	log.Info("putting podcast")
	if err := f.Datastore.Put(podcast); err != nil {
		log.Errorf("putting podcast error : %s", err)
	}
}
