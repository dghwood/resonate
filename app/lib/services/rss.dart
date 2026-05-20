import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:resonate/models/models.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

final _log = Logger('services/rss');

class RSSFeed {
  final RSSChannel channel;
  RSSFeed({required this.channel});
}

class RSSChannel {
  final String title;
  final String description;
  final String explicit;
  final List<RSSItem> items;
  final RSSChannelImage image;
  final String link;

  RSSChannel({
    required this.title,
    required this.description,
    required this.explicit,
    required this.items,
    required this.image,
    required this.link,
  });
}

class RSSChannelImage {
  final String url;
  final String href;

  RSSChannelImage({required this.url, required this.href});
}

class RSSEnclosure {
  final String url;
  final String type;

  RSSEnclosure({required this.url, required this.type});
}

class RSSItem {
  final String title;
  final String link;
  final String pubDate;
  final String summary;
  final String description;
  final String author;
  final RSSEnclosure audioUrl;
  final String guid;
  final String explicit;
  final String duration;
  final int episodeNumber;

  RSSItem({
    required this.title,
    required this.link,
    required this.pubDate,
    required this.summary,
    required this.description,
    required this.author,
    required this.audioUrl,
    required this.guid,
    required this.explicit,
    required this.duration,
    required this.episodeNumber,
  });
}

class RssService {
  static final List<String> pubDateFormats = [
    'EEE, d MMM yyyy HH:mm:ss Z',
    'EEE, d MMM yyyy HH:mm:ss zzz',
    "yyyy-MM-dd'T'HH:mm:ss'Z'",
    'yyyy-MM-dd HH:mm:ss',
    'yyyy-MM-dd',
  ];

  static int parsePubDateTimeSeconds(String pubDate) {
    pubDate = pubDate.trim();
    for (var format in pubDateFormats) {
      try {
        // DateFormat from intl package
        var dateTime = DateFormat(format).parse(pubDate);
        return dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
      } catch (_) {}
    }
    // Try native DateTime.tryParse as fallback
    var dateTime = DateTime.tryParse(pubDate);
    if (dateTime != null) {
      return dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
    }
    return 0;
  }

  static int parseDurationSeconds(String duration) {
    duration = duration.trim();
    if (duration.isEmpty) return 0;

    var parts = duration.split(':');
    var durationSeconds = 0;
    try {
      if (parts.length == 1) {
        return int.tryParse(parts[0]) ?? 0;
      }
      for (var i = 0; i < parts.length; i++) {
        var part = int.parse(parts[parts.length - 1 - i]);
        durationSeconds += part * pow(60, i).toInt();
      }
    } catch (_) {
      return 0;
    }
    return durationSeconds;
  }

  static String stripHtmlTags(String input) {
    return input.replaceAll('<p>', '').replaceAll('</p>', '').trim();
  }

  static RSSFeed parseRSS(String xmlString) {
    final document = XmlDocument.parse(xmlString);
    final rss = document.getElement('rss');
    final channelElement = rss?.getElement('channel') ?? document.getElement('channel');

    if (channelElement == null) {
      throw Exception('Invalid RSS: channel not found');
    }

    final title = channelElement.getElement('title')?.innerText ?? '';
    final description = channelElement.getElement('description')?.innerText ?? '';
    final explicit = channelElement.getElement('itunes:explicit')?.innerText ?? '';
    final link = channelElement.getElement('link')?.innerText ?? '';

    final imageElement = channelElement.getElement('image');
    final channelImage = RSSChannelImage(
      url: imageElement?.getElement('url')?.innerText ?? '',
      href: imageElement?.getAttribute('href') ?? channelElement.getElement('itunes:image')?.getAttribute('href') ?? '',
    );

    final items = channelElement.findElements('item').map((itemElement) {
      final enclosureElement = itemElement.getElement('enclosure');
      final audioUrl = RSSEnclosure(
        url: enclosureElement?.getAttribute('url') ?? '',
        type: enclosureElement?.getAttribute('type') ?? '',
      );

      return RSSItem(
        title: itemElement.getElement('title')?.innerText.trim() ?? '',
        link: itemElement.getElement('link')?.innerText.trim() ?? '',
        pubDate: itemElement.getElement('pubDate')?.innerText.trim() ?? '',
        summary: itemElement.getElement('itunes:summary')?.innerText.trim() ?? '',
        description: itemElement.getElement('description')?.innerText.trim() ?? '',
        author: itemElement.getElement('itunes:author')?.innerText.trim() ?? '',
        audioUrl: audioUrl,
        guid: itemElement.getElement('guid')?.innerText.trim() ?? '',
        explicit: itemElement.getElement('itunes:explicit')?.innerText.trim() ?? '',
        duration: itemElement.getElement('itunes:duration')?.innerText.trim() ?? '',
        episodeNumber: int.tryParse(itemElement.getElement('itunes:episode')?.innerText ?? '') ?? 0,
      );
    }).toList();

    return RSSFeed(
      channel: RSSChannel(
        title: title.trim(),
        description: description.trim(),
        explicit: explicit.trim(),
        items: items,
        image: channelImage,
        link: link.trim(),
      ),
    );
  }

  static String setIdFromUrl(String url) {
    return base64.encode(utf8.encode(url));
  }

  static Future<(Podcast, List<Episode>)> fetchAndParseRSS(String feedUrl) async {
    final response = await http.get(Uri.parse(feedUrl));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch RSS: ${response.statusCode}');
    }

    final rssFeed = parseRSS(response.body);
    final podcastId = setIdFromUrl(feedUrl);

    final podcast = Podcast(
      id: podcastId,
      title: rssFeed.channel.title,
      description: stripHtmlTags(rssFeed.channel.description),
      url: feedUrl,
      imageUrl: rssFeed.channel.image.url.isNotEmpty ? rssFeed.channel.image.url : rssFeed.channel.image.href,
    );

    final episodes = rssFeed.channel.items.map((item) {
      final episodeId = '$podcastId::${item.guid}';
      return Episode(
        id: episodeId,
        podcastId: podcastId,
        title: item.title,
        description: stripHtmlTags(item.summary.isNotEmpty ? item.summary : item.description),
        audioUrl: item.audioUrl.url,
        imageUrl: podcast.imageUrl,
        publishTimestamp: parsePubDateTimeSeconds(item.pubDate),
        durationSeconds: parseDurationSeconds(item.duration),
        episodeNumber: item.episodeNumber,
        explicit: item.explicit.toLowerCase() == 'yes',
      );
    }).toList();

    return (podcast, episodes);
  }
}
