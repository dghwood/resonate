import 'package:flutter_test/flutter_test.dart';
import 'package:resonate/services/rss.dart';

void main() {
  group('RssService', () {
    test('parseDurationSeconds', () {
      expect(RssService.parseDurationSeconds('01:10:05'), 1 * 3600 + 10 * 60 + 5);
      expect(RssService.parseDurationSeconds('54:26'), 54 * 60 + 26);
      expect(RssService.parseDurationSeconds('123'), 123);
      expect(RssService.parseDurationSeconds(''), 0);
    });

    test('parsePubDateTimeSeconds', () {
      // "Fri, 30 Jan 2026 21:16:42 +0000"
      expect(RssService.parsePubDateTimeSeconds('Fri, 30 Jan 2026 21:16:42 +0000'), 1769807802);
      expect(RssService.parsePubDateTimeSeconds('2026-01-30T21:16:42Z'), 1769807802);
    });

    test('parseRSS', () {
      const xmlString = '''
<rss xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" version="2.0">
<channel>
  <title>The NPR Politics Podcast</title>
  <description>Politics description</description>
  <link>https://www.npr.org/politics</link>
  <itunes:image href="https://example.com/podcast.jpg"/>
  <item>
    <title>Episode Title</title>
    <description>Episode description</description>
    <pubDate>Fri, 30 Jan 2026 21:16:42 +0000</pubDate>
    <guid>episode-guid</guid>
    <enclosure url="https://example.com/audio.mp3" type="audio/mpeg"/>
    <itunes:duration>00:30:00</itunes:duration>
  </item>
</channel>
</rss>
''';
      final rssFeed = RssService.parseRSS(xmlString);
      expect(rssFeed.channel.title, 'The NPR Politics Podcast');
      expect(rssFeed.channel.image.href, 'https://example.com/podcast.jpg');
      expect(rssFeed.channel.items.length, 1);
      expect(rssFeed.channel.items[0].title, 'Episode Title');
      expect(rssFeed.channel.items[0].audioUrl.url, 'https://example.com/audio.mp3');
    });
  });
}
