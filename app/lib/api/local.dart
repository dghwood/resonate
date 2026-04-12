import 'dart:isolate';
import 'package:logging/logging.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/storage/episode.dart';
import 'package:resonate/storage/podcast.dart';
import 'package:resonate/services/rss.dart';

final _log = Logger('api/local');

class LocalPodcastApi {
  LocalPodcastApi({
    required AbstractDatabaseService databaseService,
  }) : _podcastDatabase = PodcastDatabase(databaseService),
       _episodeDatabase = EpisodeDatabase(databaseService);

  final PodcastDatabase _podcastDatabase;
  final EpisodeDatabase _episodeDatabase;

  Future<void> syncPodcast(String feedUrl) async {
    _log.info('syncPodcast:: $feedUrl');
    try {
      // Use Isolate.run to perform fetch and parse in a separate isolate
      final result = await Isolate.run(() => RssService.fetchAndParseRSS(feedUrl));

      final podcast = result.$1;
      final episodes = result.$2;

      _log.info('parsed ${episodes.length} episodes for ${podcast.title}');

      // Update local databases
      await _podcastDatabase.put(podcast);
      await _episodeDatabase.putAll(episodes);

      _log.info('syncPodcast complete');
    } catch (e) {
      _log.severe('Error syncing podcast: $e');
      rethrow;
    }
  }
}
