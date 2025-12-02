import 'package:idb_sqflite/idb_sqflite.dart' as idb;
import 'package:resonate/errors/errors.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/database.dart';

class FollowsDatabase
    extends ProtoModelDatabase<UserFollowMessage, UserFollow> {
  FollowsDatabase(super.databaseService) {
    super.databaseService.registerStore(storeName, upgradeFunction);
  }

  @override
  String get storeName => 'UserFollowMessage';
  @override
  UserFollow newInstance() => UserFollow.fromMessage(UserFollowMessage());

  Future<Iterable<UserFollow>> listFromUserId(String userId) async {
    var results = await listFromSortedIndex(_userIdIndexName, userId);
    if (results.isEmpty) {
      throw DatabaseNotFoundException(
        'userFollow not found for userId: $userId',
      );
    }
    return results;
  }

  final String _userIdIndexName = 'userId_timestamp';

  @override
  Future<void> upgradeFunction(
    idb.VersionChangeEvent versionChangeEvent,
  ) async {
    final db = versionChangeEvent.database;
    // index by id.
    var store = db.createObjectStore(storeName, keyPath: 'field_1');
    // Do I need a userId/followedId index..
    store.createIndex(_userIdIndexName, [
      'field_2', // userId
      'field_4', // follow_utc_timestamp_ms
    ], unique: false);
  }
}
