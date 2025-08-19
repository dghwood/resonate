import 'package:idb_sqflite/idb_sqflite.dart' as idb;
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/database.dart';

class SubscriptionDatabase
    extends ProtoModelDatabase<UserSubscriptionMessage, UserSubscription> {
  SubscriptionDatabase(super.databaseService) {
    super.databaseService.registerStore(storeName, upgradeFunction);
  }

  @override
  String get storeName => 'SubscriptionMessage';
  @override
  UserSubscription newInstance() =>
      UserSubscription.fromMessage(UserSubscriptionMessage());

  @override
  Future<void> upgradeFunction(
    idb.VersionChangeEvent versionChangeEvent,
  ) async {
    final db = versionChangeEvent.database;
    db.createObjectStore(storeName, keyPath: 'field_1');
  }
}
