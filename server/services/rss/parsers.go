package rss

import (
	"encoding/xml"
	"errors"
	"fmt"
	"math"
	"strconv"
	"strings"
	"time"

	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/utils"
)

var pubDateFormats = []string{
	"Mon, 2 Jan 2006 15:04:05 -0700",
	time.RFC1123,  // "Sat, 03 Jan 2026 08:00:00 GMT"
	time.RFC1123Z, // "Sat, 03 Jan 2026 08:00:00 +0000"
	time.RFC3339,  // "2026-01-03T08:00:00Z"
	time.DateTime, // "2006-01-02 15:04:05"
	time.DateOnly, // "2006-01-02"
}

// TODO(duncan): Should this raise an error
func parsePubDateTimeSeconds(pubDate string) int64 {
	for _, format := range pubDateFormats {
		pubDateParsed, err := time.Parse(format, pubDate)
		if err == nil {
			return utils.ToTimestamp(pubDateParsed)
		}
	}
	return 0
}

// Supports two types of durations
// HH:MM:SS format
// HH:MM format
// SS format
func parseDurationSeconds(duration string) int64 {
	// // SS format
	// i, err := strconv.Atoi(duration)
	// if err == nil {
	// 	return int64(i)
	// }
	// HH:MM:SS, HH:MM format
	durationSeconds := 0
	timeParts := strings.Split(duration, ":")
	j := 0
	for i := len(timeParts) - 1; i >= 0; i-- {
		timePart := timeParts[i]
		timePathInt, err := strconv.Atoi(timePart)
		if err != nil {
			return 0
		}
		durationSeconds += timePathInt * int(math.Pow(60, float64(j)))
		j += 1
	}
	return int64(durationSeconds)
}

func parseRSS(body []byte) (rssFeed RSSFeed, err error) {
	err = xml.Unmarshal(body, &rssFeed)
	return
}

func trim(input string) string {
	return strings.TrimSpace(input)
}

func stripHtmlTags(input string) string {
	// This is a simple regex to strip HTML tags.
	output := strings.ReplaceAll(trim(input), "<p>", "")
	output = strings.ReplaceAll(output, "</p>", "")
	return output
}

func parsePodcast(rssFeed RSSFeed, podcast *models.Podcast) (err error) {
	podcast.Title = trim(rssFeed.Channel.Title)
	podcast.Description = stripHtmlTags(rssFeed.Channel.Description)
	if rssFeed.Channel.Image.Url != "" {
		podcast.ImageUrl = trim(rssFeed.Channel.Image.Url)
	} else if rssFeed.Channel.Image.Href != "" {
		podcast.ImageUrl = trim(rssFeed.Channel.Image.Href)
	}
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
	episode.Id = fmt.Sprintf("%s::%s", trim(podcast.Id), trim(rssItem.Guid))
	episode.Title = trim(rssItem.Title)
	episode.PodcastId = trim(podcast.Id)
	description := trim(rssItem.Summary)
	if description == "" {
		description = trim(rssItem.Description)
	}
	episode.Description = stripHtmlTags(description)
	episode.DurationSeconds = parseDurationSeconds(rssItem.Duration)
	episode.AudioUrl = trim(rssItem.AudioUrl.Url)
	episode.ImageUrl = trim(podcast.ImageUrl)
	episode.PublishTimestamp = parsePubDateTimeSeconds(rssItem.PubDate)
	return
}
