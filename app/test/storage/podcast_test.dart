import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/storage/podcast.dart';

void main() {
  late MockDatabaseService mockDatabaseService;
  late PodcastDatabase podcastDatabase;

  setUp(() {
    mockDatabaseService = MockDatabaseService();
    podcastDatabase = PodcastDatabase(mockDatabaseService);
  });

  group('PodcastDatabase Tests', () {
    test('Should initialize the database', () async {
      // await mockDatabaseService.init();
      expect(mockDatabaseService.upgradeFunctions.length, 1);
    });

    test('Should store and retrieve a podcast', () async {
      final podcastMessage =
          PodcastMessage()
            ..id = '123'
            ..title = 'Test Podcast';
      final podcast = Podcast.fromMessage(podcastMessage);

      await podcastDatabase.put(podcast);
      final retrievedPodcast = await podcastDatabase.get(podcast);

      expect(retrievedPodcast.id, podcast.id);
      expect(retrievedPodcast.title, podcast.title);
    });

    test('Should list all podcasts', () async {
      final podcastMessage1 =
          PodcastMessage()
            ..id = '123'
            ..title = 'Podcast 1';
      final podcastMessage2 =
          PodcastMessage()
            ..id = '456'
            ..title = 'Podcast 2';

      final podcast1 = Podcast.fromMessage(podcastMessage1);
      final podcast2 = Podcast.fromMessage(podcastMessage2);

      await podcastDatabase.put(podcast1);
      await podcastDatabase.put(podcast2);

      final podcasts = await podcastDatabase.list();

      expect(podcasts.length, 2);
      expect(podcasts.any((p) => p.id == podcast1.id), true);
      expect(podcasts.any((p) => p.id == podcast2.id), true);
    });

    test(
      'Should throw an error when retrieving a non-existent podcast',
      () async {
        final podcastMessage = PodcastMessage()..id = '999';
        final podcast = Podcast.fromMessage(podcastMessage);

        expect(
          () async => await podcastDatabase.get(podcast),
          throwsA(isA<DatabaseNotFoundException>()),
        );
      },
    );

    test('Should delete a podcast', () async {
      final podcastMessage =
          PodcastMessage()
            ..id = '123'
            ..title = 'Podcast to Delete';
      final podcast = Podcast.fromMessage(podcastMessage);

      await podcastDatabase.put(podcast);
      await podcastDatabase.databaseService.deleteValue(
        podcastDatabase.storeName,
        podcast.id,
      );

      expect(
        () async => await podcastDatabase.get(podcast),
        throwsA(isA<DatabaseNotFoundException>()),
      );
    });

    test('Should clear all podcasts', () async {
      final podcastMessage1 =
          PodcastMessage()
            ..id = '123'
            ..title = 'Podcast 1';
      final podcastMessage2 =
          PodcastMessage()
            ..id = '456'
            ..title = 'Podcast 2';

      final podcast1 = Podcast.fromMessage(podcastMessage1);
      final podcast2 = Podcast.fromMessage(podcastMessage2);

      await podcastDatabase.put(podcast1);
      await podcastDatabase.put(podcast2);

      await podcastDatabase.databaseService.clear(podcastDatabase.storeName);

      final podcasts = await podcastDatabase.list();
      expect(podcasts.isEmpty, true);
    });
  });
}
