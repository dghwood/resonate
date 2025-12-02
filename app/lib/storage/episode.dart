import 'package:idb_sqflite/idb_sqflite.dart' as idb;
import 'package:logging/logging.dart';
import 'package:resonate/errors/errors.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/database.dart';

final Logger _log = Logger('storage/episode');

class EpisodeDatabase extends ProtoModelDatabase<EpisodeMessage, Episode> {
  EpisodeDatabase(super.databaseService) {
    super.databaseService.registerStore(storeName, upgradeFunction);
  }

  @override
  String get storeName => 'EpisodeMessage';
  @override
  Episode newInstance() => Episode.fromMessage(EpisodeMessage());

  Future<Iterable<Episode>> listFromPodcastId(String podcastId) async {
    var results = await listFromSortedIndex(_podcastIdIndexName, podcastId);
    if (results.isEmpty) {
      throw DatabaseNotFoundException(
        'episodes not found for podcastId: $podcastId',
      );
    }
    return results;
  }

  final String _podcastIdIndexName = 'podcastId_publish_timestamp';

  @override
  Future<void> upgradeFunction(
    idb.VersionChangeEvent versionChangeEvent,
  ) async {
    _log.info('EpisodeDatabase::upgradeFunction');
    final db = versionChangeEvent.database;
    var store = db.createObjectStore(storeName, keyPath: 'field_1');
    // store.createIndex('podcastId', 'field_2', unique: false);
    // store.createIndex('publish_timestamp', 'field_8', unique: false);
    store.createIndex(_podcastIdIndexName, [
      'field_2', // podcastId
      'field_8', // publish_timestamp
    ], unique: false);
  }
}
