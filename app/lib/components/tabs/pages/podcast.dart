import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/podcast.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/api/subscription.dart';
import 'package:resonate/components/common/episode.dart';
import 'package:resonate/components/common/infinite_scroll.dart';
import 'package:resonate/components/common/infinite_scroll2.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/components/common/refresh.dart';
import 'package:resonate/components/common/subscribe.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/components/tabs/pages/base.dart';
import 'package:resonate/models/models.dart';

Logger _log = Logger('components/tabs/pages/podcast');

class PodcastPage extends PageComponentWithScaffold {
  const PodcastPage({
    super.key,
    required this.podcastId,
    required PodcastApi podcastApi,
    required AuthUser authUser,
  }) : _podcastApi = podcastApi,
       _authUser = authUser,
       super(title: 'Podcast');

  final String podcastId;
  final PodcastApi _podcastApi;
  final AuthUser _authUser;

  @override
  Widget buildChild(BuildContext context) {
    var scrollController = ScrollController();
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        PodcastHeaderComponent(
          authUser: _authUser,
          podcastStream: _podcastApi.get(podcastId),
        ),
        PodcastEpisodeInfiniteListComponent(
          scrollController: scrollController,
          podcastId: podcastId,
          // refreshFunc: () => _podcastApi.list(podcastId),
        ),
      ],
    );
    // return SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       PodcastHeaderComponent(
    //         authUser: _authUser,
    //         podcastStream: _podcastApi.get(podcastId),
    //       ),
    //       PodcastEpisodeListComponent(
    //         episodeStream: _podcastApi.list(podcastId),
    //       ),
    //     ],
    //   ),
    // );
  }
}

class PodcastHeaderComponent extends StatelessWidget {
  const PodcastHeaderComponent({
    super.key,
    required this.podcastStream,
    required this.authUser,
  });

  final Stream<ApiResult<Podcast>> podcastStream;
  final AuthUser authUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: podcastStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverFillRemaining(child: LoadingSpinnerComponent());
        }
        var result = snapshot.requireData;
        switch (result) {
          case ApiOk():
            var podcast = result.value;
            return SliverToBoxAdapter(
              child: Column(
                children: [
                  ImageComponent(podcast.imageUrl, width: 200, height: 200),
                  Text('Podcast: ${podcast.title}'),

                  SubscribeIconCommponent(authUser: authUser, podcast: podcast),
                ],
              ),
            );
          case ApiError():
            return SliverToBoxAdapter(child: Text('error: ${result.error}'));
        }
      },
    );
  }
}

class PodcastEpisodeListComponent extends StatelessWidget {
  const PodcastEpisodeListComponent({super.key, required this.podcastId});

  final String podcastId;

  @override
  Widget build(BuildContext context) {
    var podcastApi = context.read<PodcastApi>();

    return StreamBuilder(
      stream: podcastApi.list(podcastId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SliverFillRemaining(child: LoadingSpinnerComponent());
        }
        var result = snapshot.requireData;
        switch (result) {
          case ApiOk():
            var results = result.value;
            // TODO(duncan): Infinite scroll?
            return SliverList.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                var episode = results.elementAt(index);
                return EpisodeComponent(episode: episode);
              },
            );
          case ApiError():
            return SliverToBoxAdapter(child: Text('Error: ${result.error}'));
        }
      },
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
