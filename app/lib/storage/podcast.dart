import 'dart:typed_data';
import 'package:idb_sqflite/idb_sqflite.dart' as idb;
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/storage/episode.dart';

/* TODO(duncanwood):

  * Need to remove the episodes before storing a podcast. 
  * And also need to store episodes in the episodeDb.
*/
class PodcastDatabase extends ProtoModelDatabase<PodcastMessage, Podcast> {
  PodcastDatabase(super.databaseService) {
    super.databaseService.registerStore(storeName, upgradeFunction);
  }

  @override
  String get storeName => 'PodcastMessage';

  @override
  Podcast newInstance() => Podcast.fromMessage(PodcastMessage());

  @override
  Podcast onBeforePut(Podcast model) {
    var message = model.toMessage();
    var proto = PodcastMessage();
    proto.mergeFromMessage(message);
    // Clear the episodes field
    proto.episodes.clear();
    return Podcast.fromMessage(proto);
  }

  @override
  Future<void> upgradeFunction(
    idb.VersionChangeEvent versionChangeEvent,
  ) async {
    print('registering PodcastMessage store');
    final db = versionChangeEvent.database;
    db.createObjectStore(storeName, keyPath: 'field_1');
    print('storeCreated');
  }
}
