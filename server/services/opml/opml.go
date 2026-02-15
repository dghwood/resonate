package opml

import (
	"encoding/xml"

	"github.com/dghwood/resonate/log"
)

// TODO(duncan): All this OPML stuff could move to it's own service.
type opml struct {
	XMLName xml.Name `xml:"opml"`
	Body    opmlBody `xml:"body"`
}

type opmlBody struct {
	Outlines []opmlOutline `xml:"outline"`
}

type opmlOutline struct {
	Type     string        `xml:"type,attr"`
	Text     string        `xml:"text,attr"`
	XmlUrl   string        `xml:"xmlUrl,attr"`
	Outlines []opmlOutline `xml:"outline"`
}

func ExtractRssUrls(opmlBytes []byte) ([]string, error) {
	// Parse OPML
	var opmlData opml
	err := xml.Unmarshal(opmlBytes, &opmlData)
	if err != nil {
		log.Errorf("failed to parse OPML: %s", err)
		return nil, err
	}

	// Extract unique RSS URLs
	urlMap := make(map[string]bool)
	var rssUrls []string
	var extract func([]opmlOutline)
	extract = func(outlines []opmlOutline) {
		for _, outline := range outlines {
			if outline.Type == "rss" && outline.XmlUrl != "" {
				if !urlMap[outline.XmlUrl] {
					urlMap[outline.XmlUrl] = true
					rssUrls = append(rssUrls, outline.XmlUrl)
				}
			}
			if len(outline.Outlines) > 0 {
				extract(outline.Outlines)
			}
		}
	}
	extract(opmlData.Body.Outlines)
	return rssUrls, nil
}
