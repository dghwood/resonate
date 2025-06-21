import 'dart:typed_data';
import 'package:idb_sqflite/idb_sqflite.dart' as idb;
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/database.dart';

class PodcastDatabase extends ProtoModelDatabase<Podcast> {
  PodcastDatabase(super.databaseService) {
    super.databaseService.registerStore(upgradeFunction);
  }

  @override
  String get storeName => 'PodcastMessage';

  @override
  Podcast converter(Uint8List value) {
    final message = PodcastMessage.fromBuffer(value);
    return Podcast.fromMessage(message);
  }

  @override
  Future<void> upgradeFunction(
    idb.VersionChangeEvent versionChangeEvent,
  ) async {
    final db = versionChangeEvent.database;
    db
        .createObjectStore('podcasts', keyPath: 'id')
        .createIndex('id', 'id', unique: true);
  }
}
