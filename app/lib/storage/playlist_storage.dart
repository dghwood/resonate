import 'package:idb_sqflite/idb_sqflite.dart' as idb;
import 'package:resonate/models/playlist.dart';
import 'package:resonate/services/database.dart';

class PlaylistDatabase extends ProtoModelDatabase<PlaylistMessage, Playlist> {
  PlaylistDatabase(super.databaseService);

  @override
  String get storeName => 'playlist';

  @override
  Playlist newInstance() => Playlist.fromMessage(PlaylistMessage());

  @override
  void upgradeFunction(idb.VersionChangeEvent event) {
    final db = event.database;
    if (!db.objectStoreNames.contains(storeName)) {
      db.createObjectStore(storeName, keyPath: 'id');
    }
  }
}
