import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/podcast.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/api/subscription.dart';
import 'package:resonate/components/common/models/episode.dart';
import 'package:resonate/components/common/infinite_scroll.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/components/common/refresh.dart';
import 'package:resonate/components/common/models/subscribe.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/components/tabs/pages/base.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/utils/external_link.dart';

Logger _log = Logger('components/tabs/pages/podcast');

const samplePodcastUrl =
    'https://image.simplecastcdn.com/images/3b29236c-8a35-4012-9d27-62c02dd189a8/c750eec7-c202-404d-a5bc-eee317e2ce3d/3000x3000/uploads-2f1595947484360-nc4atf9w7ur-dbbaa7ee07a1ee325ec48d2e666ac261-2fpodsave100daysfinal1800.jpg?aid=rss_feed';

class PodcastHeaderDelegate extends SliverPersistentHeaderDelegate {
  const PodcastHeaderDelegate({
    this.minHeight = 64,
    this.maxHeight = 148,
    required this.stream,
  });

  final double minHeight;
  final double maxHeight;
  final Stream<ApiResult<Podcast>> stream;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    var shrink = shrinkOffset / maxExtent;
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        Podcast podcast;
        if (snapshot.connectionState == ConnectionState.waiting) {
          podcast = Podcast(id: '', title: 'Loading...');
        } else {
          var result = snapshot.requireData;
          switch (result) {
            case ApiOk():
              podcast = result.value;
            case ApiError():
              podcast = Podcast(id: '', title: '${result.error}');
          }
        }
        return SkeletonLoadingComponent(
          enabled: snapshot.connectionState == ConnectionState.waiting,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1.0,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (Navigator.of(context).canPop()) BackButton(),
                  Expanded(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 8,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                podcast.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: lerpDouble(24, 16, shrink),
                                ),
                              ),
                            ),
                            if (shrink < 0.1)
                              IconButton(
                                icon: Icon(Icons.rss_feed_rounded),
                                onPressed: () => openBrowser(podcast.url),
                              ),
                          ],
                        ),
                        // if (shrink < 0.5) Text(podcast.author),
                        if (shrink < 0.4)
                          SubscribeButtonComponent(
                            podcast: podcast,
                            subscriptionApi:
                                context.read<AuthUser>().subscriptionApi,
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: lerpDouble(maxHeight - 8, minHeight - 8, shrink),
                    height: lerpDouble(maxHeight - 8, minHeight - 8, shrink),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: ImageComponent(podcast.imageUrl),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  FloatingHeaderSnapConfiguration? get snapConfiguration =>
      FloatingHeaderSnapConfiguration(
        curve: Curves.bounceIn,
        duration: Duration(seconds: 1),
      );

  @override
  bool shouldRebuild(covariant PodcastHeaderDelegate oldDelegate) {
    return minHeight != oldDelegate.minHeight ||
        maxHeight != oldDelegate.maxHeight ||
        stream != oldDelegate.stream;
  }
}

class PodcastPage extends StatelessWidget {
  const PodcastPage({
    super.key,
    required this.podcastId,
    required PodcastApi podcastApi,
    required AuthUser authUser,
  }) : _podcastApi = podcastApi,
       _authUser = authUser;

  final String podcastId;
  final PodcastApi _podcastApi;
  final AuthUser _authUser;

  @override
  Widget build(BuildContext context) {
    var scrollController = ScrollController();
    var podcastStream = _podcastApi.get(podcastId).asBroadcastStream();
    return SafeArea(
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverPersistentHeader(
            delegate: PodcastHeaderDelegate(stream: podcastStream),
            pinned: true,
          ),

          PodcastEpisodeInfiniteListComponent(
            scrollController: scrollController,
            podcastId: podcastId,
            // refreshFunc: () => _podcastApi.list(podcastId),
          ),
        ],
      ),
    );
  }
}

class PodcastEpisodeInfiniteListComponent extends StatelessWidget {
  const PodcastEpisodeInfiniteListComponent({
    super.key,
    required this.podcastId,
    required this.scrollController,
  });

  final String podcastId;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    var podcastApi = context.read<PodcastApi>();
    var apiResultStream = podcastApi.listEpisodes(podcastId);

    return StreamBuilder(
      stream: apiResultStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverFillRemaining(child: LoadingSpinnerComponent());
        }

        _log.info('build::podcastEpisodeInfinite::stream');
        var result = snapshot.requireData;
        switch (result) {
          case ApiOkIterable():
            _log.info(
              'build::podcastEpisodeInfinite::stream::ok::${result.next != null}',
            );
            return SliverMainAxisGroup(
              slivers: [
                if (snapshot.connectionState != ConnectionState.done)
                  SliverToBoxAdapter(child: LinearProgressIndicator()),
                SliverInfiniteScrollComponent(
                  // Needed to put this here, since
                  // the stream would cache this component
                  key: Key(result.hashCode.toString()),
                  iterableApiResult: result,
                  scrollController: scrollController,
                  itemBuilder: (context, item) {
                    return EpisodeComponent(episode: item);
                  },
                ),
              ],
            );
          case ApiErrorIterable():
            return SliverToBoxAdapter(child: Text('Error: ${result.error}'));
        }
      },
    );
  }
}
