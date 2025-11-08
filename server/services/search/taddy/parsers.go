package taddy

import (
	"encoding/json"
	"fmt"
	"strconv"

	"github.com/dghwood/resonate/models"
)

func parsePodcast(podcast TaddyPodcast, message *models.Podcast) (err error) {
	message.SetIdFromUrl(podcast.RssUrl)
	message.Title = podcast.Name
	message.Description = podcast.Description
	message.Url = podcast.RssUrl
	message.ImageUrl = podcast.ImageUrl
	return
}

func constructTopQuery(pageNum int) (response []byte, err error) {
	formatString := `
	{
		getTopChartsByCountry(
			taddyType:PODCASTSERIES, 
			country:UNITED_STATES_OF_AMERICA, 
			limitPerPage:25, 
			page:%d){
				topChartsId
				podcastSeries{
					uuid
					name
					description
					imageUrl
					rssUrl
				}
			}
	}
	`
	queryJson := map[string]string{
		"query": fmt.Sprintf(formatString, pageNum+1),
	}
	response, err = json.Marshal(queryJson)
	return
}

func constructQuery(query string) (response []byte, err error) {
	// filterForTypes:[PODCASTSERIES, PODCASTEPISODE]
	formatString := `
	{
		search(term:%s, 
			filterForTypes:PODCASTSERIES,
			limitPerPage:25, 
			page:1){
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
