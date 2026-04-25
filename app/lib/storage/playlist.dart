import 'package:idb_sqflite/idb_sqflite.dart' as idb;
import 'package:logging/logging.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/database.dart';

final Logger _log = Logger('/storage/playlist');

class PlaylistDatabase extends ProtoModelDatabase<PlaylistMessage, Playlist> {
  PlaylistDatabase(super.databaseService) {
    super.databaseService.registerStore(storeName, upgradeFunction);
  }

  @override
  String get storeName => 'PlaylistMessage';

  @override
  Playlist newInstance() => Playlist.fromMessage(PlaylistMessage());

  @override
  Future<void> upgradeFunction(
    idb.VersionChangeEvent versionChangeEvent,
  ) async {
    _log.info('creating $storeName');
    final db = versionChangeEvent.database;
    db.createObjectStore(storeName, keyPath: 'field_1');
  }
}

class Playlist2Database
    extends ProtoModelDatabase<Playlist2Message, Playlist2> {
  Playlist2Database(super.databaseService) {
    super.databaseService.registerStore(storeName, upgradeFunction);
  }

  @override
  String get storeName => 'PlaylistMessage2';

  @override
  Playlist2 newInstance() => Playlist2.fromMessage(Playlist2Message());

  @override
  Future<void> upgradeFunction(
    idb.VersionChangeEvent versionChangeEvent,
  ) async {
    _log.info('creating $storeName');
    final db = versionChangeEvent.database;
    db.createObjectStore(storeName, keyPath: 'field_1');
  }
}
