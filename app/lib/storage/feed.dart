import 'package:idb_sqflite/idb_sqflite.dart' as idb;
import 'package:logging/logging.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/database.dart';

Logger _log = Logger('storage/feed');

class FeedDatabase extends ProtoModelDatabase<UserFeedMessage, UserFeed> {
  FeedDatabase(super.databaseService) {
    _log.info('registerStore::$storeName');
    super.databaseService.registerStore(storeName, upgradeFunction);
  }

  @override
  String get storeName => 'UserFeedMessage';

  @override
  UserFeed newInstance() => UserFeed.fromMessage(UserFeedMessage());

  @override
  Future<void> upgradeFunction(
    idb.VersionChangeEvent versionChangeEvent,
  ) async {
    final db = versionChangeEvent.database;
    // index by userId.
    db.createObjectStore(storeName, keyPath: 'field_1');
    _log.info('setup $storeName db');
  }
}
