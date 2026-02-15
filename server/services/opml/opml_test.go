package opml

import (
	"testing"
)

func TestRssUrls(t *testing.T) {
	opml := `<?xml version="1.0" encoding="UTF-8"?>
<opml version="1.0">
  <body>
    <outline type="rss" xmlUrl="https://example.com/rss" />
	<outline type="rss" xmlUrl="https://example2.com/rss" />
	<outline type="not_rss" xmlUrl="https://example2.com/rss" />
  </body>
</opml>`

	rssUrls, err := ExtractRssUrls([]byte(opml))
	if err != nil {
		t.Fatalf("getRssUrls failed: %v", err)
	}
	if len(rssUrls) != 2 {
		t.Errorf("expected 2 RSS URL, got %d", len(rssUrls))
	}
}
