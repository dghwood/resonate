import 'package:idb_sqflite/idb_sqflite.dart' as idb;
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/database.dart';

class PlaylistDatabase extends ProtoModelDatabase<PlaylistMessage, Playlist> {
  PlaylistDatabase(super.databaseService);

  @override
  String get storeName => 'playlist';

  @override
  Playlist newInstance() => Playlist.fromMessage(PlaylistMessage());

  @override
  void upgradeFunction(idb.VersionChangeEvent versionChangeEvent) {
    final db = versionChangeEvent.database;
    db.createObjectStore(storeName, keyPath: 'field_1');
  }
}
