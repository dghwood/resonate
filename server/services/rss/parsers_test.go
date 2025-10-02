package rss

import (
	"testing"

	"github.com/dghwood/resonate/models"
)

func TestParseEpisode(t *testing.T) {
	item := RSSItem{
		Guid:        "456",
		Title:       "title",
		Description: "description",
		AudioUrl: RssEnclosure{
			Url: "http://example.com/image.mp4",
		},
	}
	podcast := &models.Podcast{}
	podcast.Id = "213"
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
	values := []string{
		"01:10:05",
		"123",
	}
	for _, value := range values {
		if parseDurationSeconds(value) == 0 {
			t.Errorf("value is 0 for %s", value)
		}
	}
}
