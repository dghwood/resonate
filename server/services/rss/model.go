// Keep this to models for rss
package rss

type RSSFeed struct {
	Channel RSSChannel `xml:"channel"`
}

type RSSChannel struct {
	Title       string          `xml:"title" json:"title"`
	Description string          `xml:"description"`
	Explicit    string          `xml:"explicit"`
	Item        []RSSItem       `xml:"item"`
	Image       RssChannelImage `xml:"image"`
	Link        string          `xml:"link"`
}

type RssChannelImage struct {
	Url  string `xml:"url"`
	Href string `xml:"href,attr"`
}

type RssEnclosure struct {
	Url  string `xml:"url,attr"`
	Type string `xml:"type,attr"`
}
type RssItemImage struct {
	Url string `xml:"href,attr"`
}
type RSSItem struct {
	Title         string       `xml:"title"`
	Link          string       `xml:"link"`
	PubDate       string       `xml:"pubDate"`
	Summary       string       `xml:"summary"`
	Description   string       `xml:"description"`
	Author        string       `xml:"author"`
	AudioUrl      RssEnclosure `xml:"enclosure"`
	Guid          string       `xml:"guid"`
	Explicit      string       `xml:"explicit"`
	Duration      string       `xml:"duration"`
	EpisodeNumber int          `xml:"episode"`
	// Image         RssItemImage     `xml:image`
	/*
		Other fields:
		* itunes:keywords
	*/
}
