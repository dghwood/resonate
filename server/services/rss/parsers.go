package rss

import (
	"encoding/xml"
	"errors"
	"fmt"
	"regexp"
	"strconv"
	"time"

	"github.com/dghwood/resonate/models"
)

var pubDateFormats = []string{
	"Mon, 02 Jan 2006 15:04:05 -0700",
	"Mon, 2 Jan 2006 15:04:05 -0700",
}

// TODO(duncan): Should this raise an error
func parsePubDateTimeSeconds(pubDate string) int64 {
	for _, format := range pubDateFormats {
		pubDateParsed, err := time.Parse(format, pubDate)
		if err == nil {
			return pubDateParsed.Unix()
		}
	}
	return 0
}

// Supports two types of durations
// HH:MM:SS format
// SS format
func parseDurationSeconds(duration string) int64 {
	i, err := strconv.Atoi(duration)
	if err == nil {
		return int64(i)
	}
	// hh:mm:ss
	re := regexp.MustCompile(`^(\d{2}):(\d{2}):(\d{2})$`)
	match := re.FindStringSubmatch(duration)
	if len(match) == 4 {
		hours, mins, seconds := match[1], match[2], match[3]
		durationSeconds := 0
		h, _ := strconv.Atoi(hours)
		durationSeconds += h * 60 * 60
		m, _ := strconv.Atoi(mins)
		durationSeconds += m * 60
		s, _ := strconv.Atoi(seconds)
		durationSeconds += s
		return int64(durationSeconds)
	}
	return 0
}

func parseRSS(body []byte) (rssFeed RSSFeed, err error) {
	err = xml.Unmarshal(body, &rssFeed)
	return
}

func parsePodcast(rssFeed RSSFeed, podcast *models.Podcast) (err error) {
	podcast.Title = rssFeed.Channel.Title
	podcast.Description = rssFeed.Channel.Description
	podcast.ImageUrl = rssFeed.Channel.Image.Url
	return
}

func parseEpisodes(podcast *models.Podcast, rssFeed RSSFeed) (episodes []*models.Episode, err error) {
	failedEpisodes := 0
	for _, rssItem := range rssFeed.Channel.Item {
		episode := models.Episode{}
		err = parseEpisode(podcast, rssItem, &episode)
		if err != nil {
			// Should I return if only 1 episode doesn't parse
			failedEpisodes += 1
			continue
		}
		episodes = append(episodes, &episode)
	}
	if failedEpisodes > 0 {
		err = errors.New("failed to parse episodes")
	}
	return
}

func parseEpisode(podcast *models.Podcast, rssItem RSSItem, episode *models.Episode) (err error) {
	// TODO(duncan): Move this to models?
	episode.Id = fmt.Sprintf("%s::%s", podcast.Id, rssItem.Guid)
	episode.Title = rssItem.Title
	episode.PodcastId = podcast.Id
	episode.Description = rssItem.Description
	episode.DurationSeconds = parseDurationSeconds(rssItem.Duration)
	episode.AudioUrl = rssItem.AudioUrl.Url
	episode.ImageUrl = podcast.ImageUrl
	episode.PublishTimestamp = parsePubDateTimeSeconds(rssItem.PubDate)
	return
}
