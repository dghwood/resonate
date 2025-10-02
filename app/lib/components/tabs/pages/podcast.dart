import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/podcast.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/api/subscription.dart';
import 'package:resonate/components/common/episode.dart';
import 'package:resonate/components/common/infinite_scroll2.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/components/common/subscribe.dart';
import 'package:resonate/components/tabs/pages/base.dart';
import 'package:resonate/models/models.dart';

Logger _log = Logger('components/tabs/pages/podcast');

class PodcastPage extends PageComponent {
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
    return SingleChildScrollView(
      child: Column(
        children: [
          PodcastHeaderComponent(
            authUser: _authUser,
            podcastStream: _podcastApi.get(podcastId),
          ),
          PodcastEpisodeListComponent(
            episodeStream: _podcastApi.list(podcastId),
          ),
        ],
      ),
    );
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
          return LoadingSpinnerComponent();
        }
        var result = snapshot.requireData;
        switch (result) {
          case ApiOk():
            var podcast = result.value;
            return Column(
              children: [
                Image.network(podcast.imageUrl),
                Text('Podcast: ${podcast.title}'),

                SubscribeIconCommponent(authUser: authUser, podcast: podcast),
              ],
            );
          case ApiError():
            return Text('error: ${result.error}');
        }
      },
    );
  }
}

class PodcastEpisodeListComponent extends StatelessWidget {
  const PodcastEpisodeListComponent({super.key, required this.episodeStream});

  final Stream<ApiResult<Iterable<Episode>>> episodeStream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: episodeStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoadingSpinnerComponent();
        }
        var result = snapshot.requireData;
        switch (result) {
          case ApiOk():
            var results = result.value;
            // TODO(duncan): Does this need to be infinite scroll?
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: results.length,
              itemBuilder: (context, index) {
                var episode = results.elementAt(index);
                return EpisodeComponent(episode: episode);
              },
            );
          case ApiError():
            return Text('Error: ${result.error}');
        }
      },
    );
  }
}
