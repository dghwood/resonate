package search

import "github.com/dghwood/resonate/models"

/*
	Do I need to use this, or is it easier to
	just cache the fetch
*/
type CachedSearchApi struct {
	Api Search
}

func (c CachedSearchApi) Podcasts(query string) (
	podcasts []*models.Podcast,
	err error) {
	podcasts, err = c.Api.Podcasts(query)
	return
}

func (c CachedSearchApi) TopPodcasts() (
	podcasts []*models.Podcast,
	err error) {
	podcasts, err = c.Api.TopPodcasts()
	return
}
