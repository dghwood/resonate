package taddy

import (
	"encoding/json"
	"fmt"
	"strconv"

	"github.com/dghwood/resonate/models"
)

func parsePodcast(podcast TaddyPodcast, message *models.Podcast) (err error) {
	message.Id = podcast.RssUrl
	message.Title = podcast.Name
	message.Description = podcast.Description
	message.Url = podcast.RssUrl
	message.ImageUrl = podcast.ImageUrl
	return
}

func constructQuery(query string) (response []byte, err error) {
	// filterForTypes:[PODCASTSERIES, PODCASTEPISODE]
	formatString := `
	{
		search(term:%s, filterForTypes:PODCASTSERIES){
			searchId
			podcastSeries{
			uuid
			name
			description
			imageUrl
			rssUrl
			}
		}
	}`

	queryJson := map[string]string{
		"query": fmt.Sprintf(formatString, strconv.Quote(query)),
	}
	response, err = json.Marshal(queryJson)
	return
}
