package rss

import (
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/services/fetch"
)

func Get(feedUrl string) (podcast models.Podcast, episodes []*models.Episode, err error) {
	client := fetch.New()
	// TODO(duncan): How long should the cache last..
	body, err := client.Get(fetch.Request{Url: feedUrl})
	if err != nil {
		return
	}
	rssFeed, err := parseRSS(body)
	if err != nil {
		return
	}
	// TODO(duncan): Do I need to set both?
	podcast.Id = feedUrl
	podcast.Url = feedUrl

	err = parsePodcast(rssFeed, &podcast)
	if err != nil {
		return
	}
	episodes, err = parseEpisodes(podcast.Id, rssFeed)
	return
}
