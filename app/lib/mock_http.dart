import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/http.dart';

PodcastMessage mockPodcastMessage({
  String title = 'Pod Save America',
  bool includeEpisodes = false,
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
  episodes:
      includeEpisodes
          ? List.generate(
            10,
            (i) => EpisodeMessage(
              id: 'episode-$i',
              title: 'Episode $i',
              description: 'Description for episode $i',
              audioUrl: 'https://example.com/episode-$i.mp3',
            ),
          )
          : [],
);

var mockHttpService = MockHttpService({
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
