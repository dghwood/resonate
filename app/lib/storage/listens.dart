import 'package:idb_sqflite/idb_sqflite.dart' as idb;
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/database.dart';

class ListenDatabase extends ProtoModelDatabase<UserListenMessage, UserListen> {
  ListenDatabase(super.databaseService) {
    super.databaseService.registerStore(storeName, upgradeFunction);
  }

  @override
  String get storeName => 'UserListenMessage';
  @override
  UserListen newInstance() => UserListen.fromMessage(UserListenMessage());

  @override
  Future<void> upgradeFunction(
    idb.VersionChangeEvent versionChangeEvent,
  ) async {
    final db = versionChangeEvent.database;
    // index by episodeId.
    db.createObjectStore(storeName, keyPath: 'field_3');
  }
}
