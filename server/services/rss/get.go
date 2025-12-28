package rss

import (
	"context"

	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/services/fetch"
	"github.com/dghwood/resonate/utils"
)

func Get(ctx context.Context, feedUrl string, client *fetch.Client) (podcast models.Podcast, episodes []*models.Episode, err error) {

	// TODO(duncan): How long should the cache last..
	body, err := client.Get(ctx, fetch.Request{
		Url:      feedUrl,
		CacheTtl: 0})
	if err != nil {
		return
	}
	rssFeed, err := parseRSS(body)
	if err != nil {
		return
	}
	// TODO(duncan): Do I need to set both?
	podcast.SetIdFromUrl(feedUrl)
	podcast.LastFetchTimestamp = utils.Now()
	err = parsePodcast(rssFeed, &podcast)
	if err != nil {
		return
	}
	episodes, err = parseEpisodes(&podcast, rssFeed)
	if err != nil {
		return
	}
	if len(episodes) > 0 {
		// This should be ordered by latest right?
		podcast.LatestEpisodeTimestamp = episodes[0].PublishTimestamp
	}
	return
}
