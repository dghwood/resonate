import 'dart:typed_data';
import 'package:idb_sqflite/idb_sqflite.dart' as idb;
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/database.dart';

class EpisodeDatabase extends ProtoModelDatabase<Episode> {
  EpisodeDatabase(super.databaseService) {
    super.databaseService.registerStore(upgradeFunction);
  }

  @override
  String get storeName => 'EpisodeMessage';

  @override
  Episode converter(Uint8List value) {
    final message = EpisodeMessage.fromBuffer(value);
    return Episode.fromMessage(message);
  }

  Future<Iterable<Episode>> fromPodcast(Podcast podcast) async {
    var results = await listFromIndex('podcastId', podcast.id);
    return results;
  }

  @override
  Future<void> upgradeFunction(
    idb.VersionChangeEvent versionChangeEvent,
  ) async {
    final db = versionChangeEvent.database;
    db.createObjectStore(storeName, keyPath: 'id')
      ..createIndex('id', 'id', unique: true)
      ..createIndex('podcastId', 'podcastId', unique: false);
  }
}
