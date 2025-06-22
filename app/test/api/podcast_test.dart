import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:idb_sqflite/idb_sqflite.dart';
import 'package:resonate/api/podcast.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pbserver.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/services/http.dart';
import 'package:resonate/storage/podcast.dart';

void main() {
  group('GetPodcastApi', () {
    late MockHttpService mockHttpService;
    late DatabaseService mockDatabaseService;
    late GetPodcastApi getPodcastApi;

    setUp(() async {
      mockHttpService = MockHttpService({
        '/api/podcast/get':
            GetPodcastMessage_Response(
              responseInfo: ResponseInfo(success: true),
              podcast: PodcastMessage(
                id: '123',
                title: 'Test Podcast',
                episodes: [
                  EpisodeMessage(
                    id: '456',
                    title: 'Test Episode',
                    podcastId: '123',
                  ),
                ],
              ),
            ).writeToBuffer(),
      });
      mockDatabaseService = DatabaseService(idbFactoryMemory);
      getPodcastApi = GetPodcastApi(
        httpService: mockHttpService,
        databaseService: mockDatabaseService,
      );
      // Needs to be after the Api is set up
      await mockDatabaseService.init();
    });

    test('should return podcast from database if it exists', () async {
      final podcastId = '123';
      final results = await getPodcastApi.get(podcastId).toList();

      expect(results.length, 1);
      var result = results[0];
      switch (result) {
        case ApiOk():
          expect(result.value.id, podcastId);
          expect(result.value.title, 'Test Podcast');
        case ApiError():
          fail('Expected ApiOk, got ${result.error}');
      }

      // now the podcast should be in the database
      final cachedResults = await getPodcastApi.get(podcastId).toList();
      expect(cachedResults.length, 2);
      // first one is from the db
      for (var cachedResult in cachedResults) {
        // var cachedResult = cachedResults[0];
        switch (cachedResult) {
          case ApiOk():
            expect(cachedResult.value.id, '123');
            expect(cachedResult.value.title, 'Test Podcast');
            expect(cachedResult.value.episodes.length, 2);
          case ApiError():
            fail('Expected ApiOk, got ${cachedResult.error}');
        }
      }
    });
  });
}
