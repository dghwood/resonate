import 'package:idb_sqflite/idb_sqflite.dart' as idb;
import 'package:logging/logging.dart';
import 'package:resonate/errors/errors.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/database.dart';

final Logger _log = Logger('storage/settings');

class SettingsDatabase extends ProtoModelDatabase<SettingsMessage, Settings> {
  SettingsDatabase(super.databaseService) {
    super.databaseService.registerStore(storeName, upgradeFunction);
  }

  @override
  String get storeName => 'SettingsMessage';
  @override
  Settings newInstance() => Settings.fromMessage(SettingsMessage());

  @override
  Future<void> upgradeFunction(
    idb.VersionChangeEvent versionChangeEvent,
  ) async {
    final db = versionChangeEvent.database;
    var store = db.createObjectStore(storeName, keyPath: 'field_1');
  }
}
