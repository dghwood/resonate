import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/feed.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/components/common/models/episode.dart';
import 'package:resonate/components/common/refresh.dart';
import 'package:resonate/components/common/models/subscriptions.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/mock_http.dart';
import 'package:resonate/models/models.dart';

final Logger _log = Logger('components/tabs/home');

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ValueNotifier<bool> socialEnabledListener = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    var authUser = context.read<AuthUser>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            SliverAppBar(
              title: Text('RESONATES'),
              floating: true,
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: Icon(Icons.refresh),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: SubscriptionGridComponent(
                height: 120,
                subscriptionsApi: context.read(),
                user: PublicUser.fromUser(authUser.user!),
                scrollController: ScrollController(),
              ),
            ),
            SliverToBoxAdapter(child: Divider()),
          ];
        },
        body: Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Row(
              children: [
                Text("FEED", style: Theme.of(context).textTheme.labelMedium),
                Spacer(),
                SwitchComponent(
                  enabled: socialEnabledListener.value,
                  icon: Icon(Icons.person),
                  onChanged: (enabled) {
                    socialEnabledListener.value = enabled;
                  },
                ),
              ],
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: socialEnabledListener,
                builder: (context, value, child) {
                  return FeedComponent(
                    includeFollowers: value,
                    feedApi: authUser.feedApi,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedComponent extends StatelessWidget {
  const FeedComponent({
    super.key,
    required this.feedApi,
    this.includeFollowers = false,
  });

  final bool includeFollowers;
  final GetFeedApi feedApi;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: feedApi,
      builder: (context, _) {
        _log.info('includeFollowers::$includeFollowers');
        return StreamBuilder(
          stream: feedApi.get(includeFollowers: includeFollowers),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SkeletonLoadingComponent(
                enabled: true,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return EpisodeComponent(
                      episode: Episode.fromMessage(mockEpisodeMessage()),
                    );
                  },
                ),
              );
            }
            var result = snapshot.requireData;
            switch (result) {
              case ApiOk():
                break;
              case ApiError():
                return Text('error::${result.error}');
            }
            var items = result.value.items;
            if (items.isEmpty) {
              return Icon(Icons.spoke);
            }
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                var item = items.elementAt(index);
                if (item.episodeItem == null) {
                  return Text('Recommendations not implemented');
                }
                var episodeItem = item.episodeItem!;
                return EpisodeComponent(
                  episode: episodeItem.episode,
                  listens: episodeItem.listens,
                  feedItemType: episodeItem.feedItemType,
                );
              },
            );
          },
        );
      },
    );
  }
}
