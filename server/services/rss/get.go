package rss

import (
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/services/fetch"
)

func Get(feedUrl string, client *fetch.Client) (podcast models.Podcast, episodes []*models.Episode, err error) {

	// TODO(duncan): How long should the cache last..
	body, err := client.Get(fetch.Request{
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
	err = parsePodcast(rssFeed, &podcast)
	if err != nil {
		return
	}
	episodes, err = parseEpisodes(&podcast, rssFeed)
	return
}
