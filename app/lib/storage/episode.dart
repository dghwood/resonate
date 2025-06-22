import 'dart:typed_data';
import 'package:idb_sqflite/idb_sqflite.dart' as idb;
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

  Future<void> populatePodcastEpisodes(Podcast podcast) async {
    var results = await listFromIndex('podcastId', podcast.id);
    if (results.isEmpty) return;
    podcast.setEpisodes(results);
  }

  @override
  Future<void> upgradeFunction(
    idb.VersionChangeEvent versionChangeEvent,
  ) async {
    final db = versionChangeEvent.database;
    db
        .createObjectStore(storeName, keyPath: 'field_1')
        .createIndex('podcastId', 'field_2', unique: false);
  }
}
