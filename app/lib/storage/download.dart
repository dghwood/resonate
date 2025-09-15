import 'package:idb_sqflite/idb_sqflite.dart' as idb;
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/database.dart';

class DownloadDatabase
    extends ProtoModelDatabase<UserDownloadMessage, UserDownload> {
  DownloadDatabase(super.databaseService) {
    super.databaseService.registerStore(storeName, upgradeFunction);
  }

  @override
  String get storeName => 'UserDownloadMessage';
  @override
  UserDownload newInstance() =>
      UserDownload.fromMessage(UserDownloadMessage());

  @override
  Future<void> upgradeFunction(
    idb.VersionChangeEvent versionChangeEvent,
  ) async {
    final db = versionChangeEvent.database;
    // TODO(duncan): Do I need a index on episode id? 
    db.createObjectStore(storeName, keyPath: 'field_1');
  }
}
