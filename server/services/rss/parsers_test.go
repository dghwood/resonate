package rss

import (
	"encoding/xml"
	"strings"
	"testing"

	"github.com/dghwood/resonate/models"
)

func TestParseEpisode(t *testing.T) {
	item := RSSItem{
		Guid:        "456 ",
		Title:       "title ",
		Description: " description",
		AudioUrl: RssEnclosure{
			Url: " http://example.com/image.mp4",
		},
	}
	podcast := &models.Podcast{}
	podcast.Id = "123"
	podcast.ImageUrl = "http://example.com/image.jpg"
	p := models.Episode{}
	err := parseEpisode(podcast, item, &p)
	if err != nil {
		t.Error(err)
	}
	if p.Id != "123::456" {
		t.Errorf("expected id=123::456, got %s", p.Id)
	}
	if p.Title != "title" {
		t.Errorf("expected title, got %s", p.Title)
	}
	if p.Description != "description" {
		t.Errorf("expected description, got %s", p.Description)
	}
	if p.AudioUrl != "http://example.com/image.mp4" {
		t.Errorf("expected http://example.com/image.mp4, got %s", p.AudioUrl)
	}
	if p.ImageUrl != "http://example.com/image.jpg" {
		t.Errorf("expected http://example.com/image.jpg, got %s", p.ImageUrl)
	}
}

func TestParsePubDateTimeSeconds(t *testing.T) {
	values := []string{
		// This fails
		"Tue, 1 Apr 2025 07:05:00 +0000",
		"Tue, 01 Apr 2025 07:05:00 +0000",
	}

	for _, value := range values {
		if parsePubDateTimeSeconds(value) == 0 {
			t.Errorf("value is 0 for %s", value)
		}
	}
}

func TestParseDurationSeconds(t *testing.T) {
	values := map[string]int64{
		"01:10:05": 1*60*60 + 10*60 + 5,
		// https://publicfeeds.net/f/5770/in-the-dark
		"54:26": 54*60 + 26,
		"123":   123,
	}

	for value, expected := range values {
		if parseDurationSeconds(value) != expected {
			t.Errorf("expected %d, got %d for %s", expected, parseDurationSeconds(value), value)
		}
	}
}

func TestXMlParse(t *testing.T) {
	xmlString := `
		<rss xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" version="2.0">
<channel>
<title>
<![CDATA[ Dwarkesh Podcast ]]>
</title>
<description>
<![CDATA[ Deeply researched interviews <br/><br/><a href="https://www.dwarkesh.com?utm_medium=podcast">www.dwarkesh.com</a> ]]>
</description>
<link>https://www.dwarkesh.com/podcast</link>
<generator>Substack</generator>
<lastBuildDate>Thu, 18 Dec 2025 00:51:43 GMT</lastBuildDate>
<atom:link href="https://api.substack.com/feed/podcast/69345.rss" rel="self" type="application/rss+xml"/>
<author>
<![CDATA[ Dwarkesh Patel ]]>
</author>
<copyright>
<![CDATA[ Dwarkesh Patel ]]>
</copyright>
<language>
<![CDATA[ en ]]>
</language>
<webMaster>
<![CDATA[ dwarkesh@substack.com ]]>
</webMaster>
<itunes:new-feed-url>https://api.substack.com/feed/podcast/69345.rss</itunes:new-feed-url>
<itunes:author>Dwarkesh Patel</itunes:author>
<itunes:subtitle>Deeply researched interviews</itunes:subtitle>
<itunes:type>episodic</itunes:type>
<itunes:owner>
<itunes:name>Dwarkesh Patel</itunes:name>
<itunes:email>dwarkesh@substack.com</itunes:email>
</itunes:owner>
<itunes:explicit>No</itunes:explicit>
<itunes:category text="Technology"/>
<itunes:category text="Science"/>
<itunes:image href="https://substackcdn.com/feed/podcast/69345/db6ef1755a45c6e0e7a478f6dbe68984.jpg"/>
<item>
<title>
<![CDATA[ Ilya Sutskever – We're moving from the age of scaling to the age of research ]]>
</title>
</item>
</channel>
</rss>
	`
	rssFeed := &RSSFeed{}
	err := xml.Unmarshal([]byte(xmlString), &rssFeed)
	if err != nil {
		t.Error(err)
	}

	if strings.TrimSpace(rssFeed.Channel.Title) != "Dwarkesh Podcast" {
		t.Errorf("expected Dwarkesh Podcast, got %s", rssFeed.Channel.Title)
	}
	if rssFeed.Channel.Image.Href != "https://substackcdn.com/feed/podcast/69345/db6ef1755a45c6e0e7a478f6dbe68984.jpg" {
		t.Errorf("expected https://substackcdn got %s", rssFeed.Channel.Image.Href)
	}

}
