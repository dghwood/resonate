package taddy

import (
	"context"
	"encoding/json"
	"errors"
	"log"
	"time"

	// "time"

	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/services/fetch"
)

// This needs to implement an interface
type TaddySearchApi struct {
	Client    *fetch.Client
	UserId    string
	AuthToken string
}

// This needs to return podcasts & episodes
func (t *TaddySearchApi) Podcasts(query string) (
	podcasts []*models.Podcast,
	err error) {

	queryBytes, err := constructQuery(query)
	if err != nil {
		return
	}
	request := fetch.Request{
		Url:  "https://api.taddy.org",
		Body: queryBytes,
		Headers: map[string]string{
			"Content-Type": "application/json",
			"X-USER-ID":    t.UserId,
			"X-API-KEY":    t.AuthToken,
		},
		CacheTtl: 24 * time.Hour,
	}
	// TODO(duncan): Read TTL from options?
	ctx := context.Background()
	responseBytes, err := t.Client.Post(ctx, request)
	if err != nil {
		return
	}
	response := TaddySearchQueryResponse{}
	err = json.Unmarshal(responseBytes, &response)
	if err != nil {
		return
	}
	if len(response.Errors) > 0 {
		err = errors.New(response.Errors[0].Message)
		return
	}
	for _, podcast := range response.Data.Search.Podcasts {
		message := models.Podcast{}
		err = parsePodcast(podcast, &message)
		if err != nil {
			log.Printf("unable to parse podcast %s", podcast)
			continue
		}
		podcasts = append(podcasts, &message)
	}
	// TODO(duncan): Add episode parsing
	return
}

func (t *TaddySearchApi) TopPodcasts() (
	podcasts []*models.Podcast,
	err error) {

	// TODO(duncan): How many should I request, limit is 25
	// Currently requesting 50 in total.
	for i := range 1 {
		topPodcasts, topErr := t.fetchTopPage(i)
		if topErr != nil {
			err = topErr
			return
		}
		podcasts = append(podcasts, topPodcasts...)
	}
	return
}

func (t *TaddySearchApi) fetchTopPage(pageNum int) (
	podcasts []*models.Podcast,
	err error) {
	client := t.Client
	queryBytes, err := constructTopQuery(pageNum)
	if err != nil {
		return
	}
	request := fetch.Request{
		Url:  "https://api.taddy.org",
		Body: queryBytes,
		Headers: map[string]string{
			"Content-Type": "application/json",
			"X-USER-ID":    t.UserId,
			"X-API-KEY":    t.AuthToken,
		},
		CacheTtl: 24 * time.Hour,
	}
	// TODO(duncan): Read TTL from options?
	ctx := context.Background()
	responseBytes, err := client.Post(ctx, request)
	if err != nil {
		return
	}
	response := TaddyTopPodcasts{}
	err = json.Unmarshal(responseBytes, &response)
	if err != nil {
		return
	}
	if len(response.Errors) > 0 {
		err = errors.New(response.Errors[0].Message)
		return
	}
	for _, podcast := range response.Data.GetTopChartsByCountry.PodcastSeries {
		message := models.Podcast{}
		err = parsePodcast(podcast, &message)
		if err != nil {
			log.Printf("unable to parse podcast %s", podcast)
			continue
		}
		podcasts = append(podcasts, &message)
	}
	return
}
