import 'package:flutter_test/flutter_test.dart';
import 'package:idb_sqflite/idb_sqflite.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/storage/episode.dart';

void main() {
  late DatabaseService mockDatabaseService;
  late EpisodeDatabase episodeDatabase;

  setUp(() async {
    mockDatabaseService = DatabaseService(idbFactoryMemory);
    episodeDatabase = EpisodeDatabase(mockDatabaseService);
    await mockDatabaseService.init();
  });

  group('EpisodeDatabase Tests', () {
    test('Should initialize the database', () async {
      expect(mockDatabaseService.isInitialized, true);
    });

    test('Should store and retrieve an episode', () async {
      final episodeMessage =
          EpisodeMessage()
            ..id = '123'
            ..title = 'Test Episode'
            ..podcastId = '456';
      final episode = Episode.fromMessage(episodeMessage);

      await episodeDatabase.put(episode);

      var retrievedEpisode = Episode(id: '123', podcastId: '456');

      await episodeDatabase.get(retrievedEpisode);

      expect(retrievedEpisode.id, episode.id);
      expect(retrievedEpisode.title, episode.title);
      expect(retrievedEpisode.podcastId, episode.podcastId);
    });

    test('Should list all episodes', () async {
      final episodeMessage1 =
          EpisodeMessage()
            ..id = '123'
            ..title = 'Episode 1'
            ..podcastId = '456';
      final episodeMessage2 =
          EpisodeMessage()
            ..id = '789'
            ..title = 'Episode 2'
            ..podcastId = '456';

      final episode1 = Episode.fromMessage(episodeMessage1);
      final episode2 = Episode.fromMessage(episodeMessage2);

      await episodeDatabase.put(episode1);
      await episodeDatabase.put(episode2);

      final episodes = await episodeDatabase.list();

      expect(episodes.length, 2);
      expect(episodes.any((e) => e.id == episode1.id), true);
      expect(episodes.any((e) => e.id == episode2.id), true);
    });

    test('Should retrieve episodes by podcastId index', () async {
      final episodeMessage1 =
          EpisodeMessage()
            ..id = '123'
            ..title = 'Episode 1'
            ..podcastId = '456';
      final episodeMessage2 =
          EpisodeMessage()
            ..id = '789'
            ..title = 'Episode 2'
            ..podcastId = '456';
      final episodeMessage3 =
          EpisodeMessage()
            ..id = '101'
            ..title = 'Episode 3'
            ..podcastId = '999';

      final episode1 = Episode.fromMessage(episodeMessage1);
      final episode2 = Episode.fromMessage(episodeMessage2);
      final episode3 = Episode.fromMessage(episodeMessage3);

      await episodeDatabase.put(episode1);
      await episodeDatabase.put(episode2);
      await episodeDatabase.put(episode3);

      final episodes = await episodeDatabase.listFromIndex('podcastId', '456');

      expect(episodes.length, 2);
      expect(episodes.any((e) => e.id == episode1.id), true);
      expect(episodes.any((e) => e.id == episode2.id), true);
      expect(episodes.any((e) => e.id == episode3.id), false);
    });

    test('Should delete an episode', () async {
      final episodeMessage =
          EpisodeMessage()
            ..id = '123'
            ..title = 'Episode to Delete'
            ..podcastId = '456';
      final episode = Episode.fromMessage(episodeMessage);

      await episodeDatabase.put(episode);
      await episodeDatabase.databaseService.deleteValue(
        episodeDatabase.storeName,
        episode.id,
      );

      expect(
        () async => await episodeDatabase.get(episode),
        throwsA(isA<DatabaseNotFoundException>()),
      );
    });

    test('Should clear all episodes', () async {
      final episodeMessage1 =
          EpisodeMessage()
            ..id = '123'
            ..title = 'Episode 1'
            ..podcastId = '456';
      final episodeMessage2 =
          EpisodeMessage()
            ..id = '789'
            ..title = 'Episode 2'
            ..podcastId = '456';

      final episode1 = Episode.fromMessage(episodeMessage1);
      final episode2 = Episode.fromMessage(episodeMessage2);

      await episodeDatabase.put(episode1);
      await episodeDatabase.put(episode2);

      await episodeDatabase.databaseService.clear(episodeDatabase.storeName);

      final episodes = await episodeDatabase.list();
      expect(episodes.isEmpty, true);
    });
  });
}
