import 'package:idb_sqflite/idb_sqflite.dart' as idb;
import 'package:resonate/errors/errors.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/database.dart';

class EpisodeDatabase extends ProtoModelDatabase<EpisodeMessage, Episode> {
  EpisodeDatabase(super.databaseService) {
    super.databaseService.registerStore(storeName, upgradeFunction);
  }

  @override
  String get storeName => 'EpisodeMessage';
  @override
  Episode newInstance() => Episode.fromMessage(EpisodeMessage());

  Future<Iterable<Episode>> listFromPodcastId(String podcastId) async {
    var results = await listFromIndex('podcastId', podcastId);
    if (results.isEmpty) {
      throw DatabaseNotFoundException(
        'episodes not found for podcastId: $podcastId',
      );
    }
    return results;
  }

  // Future<Iterable<Episode>> listFromTimestamp(DateTime since) {
  //   var results = await getAllValuesFromLowerBoundIndex('publish_timestamp')
  // }

  // Future<void> populatePodcastEpisodes(Podcast podcast) async {
  //   var results = await listFromIndex('podcastId', podcast.id);
  //   if (results.isEmpty) return;
  //   podcast.setEpisodes(results);
  // }

  @override
  Future<void> upgradeFunction(
    idb.VersionChangeEvent versionChangeEvent,
  ) async {
    final db = versionChangeEvent.database;
    var store = db.createObjectStore(storeName, keyPath: 'field_1');
    store.createIndex('podcastId', 'field_2', unique: false);
    store.createIndex('publish_timestamp', 'field_8', unique: false);
  }
}
