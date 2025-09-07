import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/http.dart';

EpisodeMessage mockEpisodeMessage({
  String id = '312',
  String title = 'Episode 1',
  String description = 'Description for episode 1',
}) => EpisodeMessage(
  id: id,
  title: title,
  description: description,
  audioUrl:
      'https://pdst.fm/e/arttrk.com/p/CRMDA/claritaspod.com/measure/pscrb.fm/rss/p/mgln.ai/e/284/pdrl.fm/b85a46/stitcher.simplecastaudio.com/9aa1e238-cbed-4305-9808-c9228fc6dd4f/episodes/0ba25cc3-528a-41c6-9569-a53ed26bcdb2/audio/128/default.mp3?aid=rss_feed&awCollectionId=9aa1e238-cbed-4305-9808-c9228fc6dd4f&awEpisodeId=0ba25cc3-528a-41c6-9569-a53ed26bcdb2&feed=dxZsm5kX',
  durationSeconds: Int64(30),
  imageUrl:
      'https://image.simplecastcdn.com/images/3b29236c-8a35-4012-9d27-62c02dd189a8/c750eec7-c202-404d-a5bc-eee317e2ce3d/3000x3000/uploads-2f1595947484360-nc4atf9w7ur-dbbaa7ee07a1ee325ec48d2e666ac261-2fpodsave100daysfinal1800.jpg?aid=rss_feed',
);
PodcastMessage mockPodcastMessage({
  String title = 'Pod Save America',
}) => PodcastMessage(
  title: title,
  id: '123',
  author: 'Crooked Media',
  description:
      '''Pod Save America is a no-bullshit conversation about politics hosted by former
Obama aides Jon Favreau, Jon Lovett, Dan Pfeiffer, and Tommy Vietor. It cuts through the
noise to break down the week’s news and helps people figure out what matters and how
they can help. They’re regularly joined by journalists, activists, politicians,
entertainers, and world leaders. You can watch on YouTube or listen to new episodes
every Tuesday and Friday. Subscribe to Friends of the Pod! Your subscription makes
Crooked’s work possible and gives you access to ad-free episodes of Pod Save America and
Pod Save the World, plus exclusive content and a lively Discord community. Learn more
and subscribe at crooked.com/friends or on Apple Podcasts. For a transcript of an
episode of Pod Save America, please email transcripts@crooked.com''',
  imageUrl:
      'https://image.simplecastcdn.com/images/3b29236c-8a35-4012-9d27-62c02dd189a8/c750eec7-c202-404d-a5bc-eee317e2ce3d/3000x3000/uploads-2f1595947484360-nc4atf9w7ur-dbbaa7ee07a1ee325ec48d2e666ac261-2fpodsave100daysfinal1800.jpg?aid=rss_feed',
);

var mockHttpService = MockHttpService({
  '/api/feed':
      () =>
          GetFeedMessage_Response(
            responseInfo: ResponseInfo(success: true),
            feed: UserFeedMessage(
              userId: '123',
              items: List.generate(20, (i) => i).map(
                (i) => UserFeedItemMessage(
                  episodeItem: UserFeedItemEpisodeMessage(
                    episode: mockEpisodeMessage(id: '$i', title: 'Episode $i'),
                  ),
                  // listens: UserListenMessage()
                ),
              ),
            ),
          ).writeToBuffer(),
  '/api/subscribe/add':
      () =>
          AddSubscriptionMessage_Response(
            responseInfo: ResponseInfo(success: true),
            subscription: UserSubscriptionMessage(
              userId: '123',
              podcastId: '123',
            ),
          ).writeToBuffer(),
  '/api/subscribe/remove':
      () =>
          RemoveSubscriptionMessage_Response(
            responseInfo: ResponseInfo(success: true),
          ).writeToBuffer(),
  '/api/podcast/list':
      () =>
          ListPodcastEpisodesMessage_Response(
            responseInfo: ResponseInfo(success: true),
            episodes:
                List.generate(20, (i) => i)
                    .map(
                      (i) => mockEpisodeMessage(
                        id: '$i',
                        title: 'Pod Save America $i',
                      ),
                    )
                    .toList(),
          ).writeToBuffer(),
  '/api/podcast/get':
      () =>
          GetPodcastMessage_Response(
            responseInfo: ResponseInfo(success: true),
            podcast: mockPodcastMessage(),
          ).writeToBuffer(),
  '/api/search':
      () =>
          SearchMessage_Response(
            responseInfo: ResponseInfo(success: true),
            searchResults: SearchResultsMessage(
              results: List.generate(20, (i) => i).map(
                (i) => SearchResultMessage(
                  podcast: mockPodcastMessage(title: 'Pod Save America $i'),
                ),
              ),
            ),
          ).writeToBuffer(),
  '/api/login/request':
      () =>
          LoginRequestMessage_Response(
            responseInfo: ResponseInfo(success: true),
          ).writeToBuffer(),
  '/api/login':
      () =>
          LoginUserMessage_Response(
            responseInfo: ResponseInfo(success: true),
            user: UserMessage(
              id: '123',
              name: 'Test User',
              email: 'example@example.com',
            ),
            refreshToken: TokenMessage(token: 'mock-refresh-token'),
            accessToken: TokenMessage(
              token: 'mock-token',
              expiryUtcTimestamp: Int64(
                DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch,
              ),
            ),
          ).writeToBuffer(),
  '/api/user/get':
      () =>
          GetUserMessage_Response(
            responseInfo: ResponseInfo(success: true),
            user: UserMessage(
              id: '123',
              name: 'Test User',
              email: 'example@example.com',
            ),
          ).writeToBuffer(),
});
