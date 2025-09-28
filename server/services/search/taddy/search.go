package taddy

import (
	"encoding/json"
	"errors"
	"log"

	// "time"

	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/services/fetch"
)

// This needs to implement an interface
type TaddySearchApi struct {
	UserId    string
	AuthToken string
}

// This needs to return podcasts & episodes
func (t TaddySearchApi) Podcasts(query string) (
	podcasts []*models.Podcast,
	err error) {

	client := fetch.New()
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
	}
	// TODO(duncan): Read TTL from options?
	responseBytes, err := client.Post(request)
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

// TODO(duncan): Add caching for this?
func (t TaddySearchApi) TopPodcasts(query string) (
	podcasts []*models.Podcast,
	err error) {

	client := fetch.New()
	// TODO(duncan): How many should I request, limit is 25
	// Currently requesting 50 in total.
	for i := range 2 {
		queryBytes, err := constructTopQuery(i)
		if err != nil {
			return podcasts, err
		}
		request := fetch.Request{
			Url:  "https://api.taddy.org",
			Body: queryBytes,
			Headers: map[string]string{
				"Content-Type": "application/json",
				"X-USER-ID":    t.UserId,
				"X-API-KEY":    t.AuthToken,
			},
		}
		// TODO(duncan): Read TTL from options?
		responseBytes, err := client.Post(request)
		if err != nil {
			return podcasts, err
		}
		response := TaddyTopPodcasts{}
		err = json.Unmarshal(responseBytes, &response)
		if err != nil {
			return podcasts, err
		}
		if len(response.Errors) > 0 {
			err = errors.New(response.Errors[0].Message)
			return podcasts, err
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
	}
	return
}
