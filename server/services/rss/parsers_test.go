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
		"Sat, 03 Jan 2026 08:00:00 GMT",
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

func TestParseNPRFeed(t *testing.T) {
	xmlString := `<rss xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:media="http://search.yahoo.com/mrss/" xmlns:podcast="https://podcastindex.org/namespace/1.0" version="2.0">
<channel>
<title>The NPR Politics Podcast</title>
<item>
<title>Another government shutdown looms -- what you need to know</title>
<description>
<![CDATA[ <p class="p1">After immigration officials killed two people in Minneapolis this month, congressional Democrats demanded funding for immigration action be separated from other government funding. That's leading to a potential, partial, government shutdown. We unpack the latest from Capitol Hill.<p class="p1"><br><p class="p1">Then, why did the FBI raid Fulton County, Ga.'s election center this week, and what does it have to do with President Trump's continued false claims that the 2020 presidential election was stolen?<p class="p1"><br><p class="p1">And, we bid a fond farewell to one of our podcast stalwarts.<p class="p1"><br><p class="p1">This episode: senior White House correspondent Tamara Keith, congressional reporter Sam Gringlas, immigration policy correspondent Ximena Bustillo, political reporter Stephen Fowler, senior political editor & correspondent Domenico Montanaro, and political correspondent Sarah McCammon.<p class="p1"><br><p class="p1">This podcast was produced and edited by Casey Morell & Bria Suggs.<p class="p1"><br><p class="p1">Our executive producer is Muthoni Muturi.<p class="p2"><br><p class="p1">Listen to every episode of the NPR Politics Podcast sponsor-free, unlock access to bonus episodes with more from the NPR Politics team, and support public media when you sign up for The NPR Politics Podcast+ at <a href="http://plus.npr.org/politics"target="_blank" >plus.npr.org/politics</a>.<p class="p2"><br/><br/>Learn more about sponsor message choices: <a href="https://podcastchoices.com/adchoices">podcastchoices.com/adchoices</a><br/><br/><a href="https://www.npr.org/about-npr/179878450/privacy-policy">NPR Privacy Policy</a> ]]>
</description>
<pubDate>Fri, 30 Jan 2026 21:16:42 +0000</pubDate>
<guid isPermaLink="false">c95921bb-71c2-4145-8fcd-8217d23889aa</guid>
<content:encoded>
<![CDATA[ <p class="p1">After immigration officials killed two people in Minneapolis this month, congressional Democrats demanded funding for immigration action be separated from other government funding. That's leading to a potential, partial, government shutdown. We unpack the latest from Capitol Hill.<p class="p1"><br><p class="p1">Then, why did the FBI raid Fulton County, Ga.'s election center this week, and what does it have to do with President Trump's continued false claims that the 2020 presidential election was stolen?<p class="p1"><br><p class="p1">And, we bid a fond farewell to one of our podcast stalwarts.<p class="p1"><br><p class="p1">This episode: senior White House correspondent Tamara Keith, congressional reporter Sam Gringlas, immigration policy correspondent Ximena Bustillo, political reporter Stephen Fowler, senior political editor & correspondent Domenico Montanaro, and political correspondent Sarah McCammon.<p class="p1"><br><p class="p1">This podcast was produced and edited by Casey Morell & Bria Suggs.<p class="p1"><br><p class="p1">Our executive producer is Muthoni Muturi.<p class="p2"><br><p class="p1">Listen to every episode of the NPR Politics Podcast sponsor-free, unlock access to bonus episodes with more from the NPR Politics team, and support public media when you sign up for The NPR Politics Podcast+ at <a href="http://plus.npr.org/politics"target="_blank" >plus.npr.org/politics</a>.<p class="p2"><br/><br/>Learn more about sponsor message choices: <a href="https://podcastchoices.com/adchoices">podcastchoices.com/adchoices</a><br/><br/><a href="https://www.npr.org/about-npr/179878450/privacy-policy">NPR Privacy Policy</a> ]]>
</content:encoded>
</item>
</channel>
</rss>
`
	rssFeed := &RSSFeed{}
	err := xml.Unmarshal([]byte(xmlString), &rssFeed)
	if err != nil {
		t.Error(err)
	}
	if rssFeed.Channel.Item[0].Description == "" {
		t.Error("description is empty")
	}

}
