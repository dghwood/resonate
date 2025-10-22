import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/listens.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/api/subscription.dart';
import 'package:resonate/api/user.dart';
import 'package:resonate/components/common/downloads.dart';
import 'package:resonate/components/common/episode.dart';
import 'package:resonate/components/common/follow.dart';
import 'package:resonate/components/common/infinite_scroll.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/components/common/subscriptions.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/router/navigation.dart';

class PublicUserProfileAppBar extends StatefulWidget {
  const PublicUserProfileAppBar({
    super.key,
    required this.user,
    required this.controller,
  });

  final PublicUser user;
  final ScrollController controller;

  @override
  State<PublicUserProfileAppBar> createState() =>
      _PublicUserProfileAppBarState();
}

class _PublicUserProfileAppBarState extends State<PublicUserProfileAppBar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(onScroll);
  }

  @override
  void dispose() {
    widget.controller.removeListener(onScroll);
    super.dispose();
  }

  bool show = true;
  double opacity = 0.0;
  void onScroll() {
    var o = widget.controller.position.pixels / 120;
    setState(() {
      if (o > 1) {
        opacity = 1;
        return;
      }
      opacity = widget.controller.position.pixels / 120;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!show) {
      return SliverAppBar(pinned: true, floating: true);
    }

    return SliverAppBar(
      pinned: true,
      floating: true,
      title: Opacity(
        opacity: opacity,
        child: Row(
          children: [
            ImageComponent(widget.user.imageUrl, height: 32),
            Text(widget.user.name),
          ],
        ),
      ),
    );
  }
}

class ProfileMetricComponent extends StatelessWidget {
  const ProfileMetricComponent({
    super.key,
    required this.value,
    required this.metricName,
  });

  final int? value;
  final String metricName;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${value ?? 0}', style: Theme.of(context).textTheme.labelLarge),
          Text(metricName, style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }
}

class PublicUserProfileComponent extends StatelessWidget {
  const PublicUserProfileComponent({
    super.key,
    required this.userId,
    required this.publicUserApi,
    required this.authUser,
  });

  final String userId;

  final PublicUserApi publicUserApi;
  final AuthUser authUser;

  @override
  Widget build(BuildContext context) {
    final ScrollController controller = ScrollController();
    final isAuthUser = authUser.user?.id == userId;
    return FutureBuilder(
      future: publicUserApi.get(userId),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return LoadingSpinnerComponent();
        }
        var result = asyncSnapshot.requireData;
        switch (result) {
          case ApiOk():
            break;
          case ApiError():
            return Text('Error: ${result.error}');
        }
        var user = result.value;

        return DefaultTabController(
          length: 4 + (isAuthUser ? 1 : 0),
          child: NestedScrollView(
            controller: controller,
            headerSliverBuilder:
                (context, _) => <Widget>[
                  PublicUserProfileAppBar(controller: controller, user: user),
                  SliverToBoxAdapter(
                    child: PublicUserHeaderComponent(
                      user: user,
                      authUser: authUser,
                    ),
                  ),

                  PinnedHeaderSliver(
                    child: Container(
                      color: Theme.of(context).colorScheme.surface,
                      child: TabBar(
                        tabs: [
                          Tab(text: 'Listens'),
                          Tab(text: 'Subscriptions'),
                          if (isAuthUser) Tab(text: 'Downloads'),
                          Tab(text: 'Following'),
                          Tab(text: 'Followers'),
                        ],
                      ),
                    ),
                  ),
                ],
            body: TabBarView(
              // The content for each tab
              children: <Widget>[
                PublicUserListensComponent(
                  user: user,
                  scrollController: controller,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SubscriptionGridComponent(
                    subscriptionsApi: context.read(),
                    user: user,
                    showTitle: false,
                    crossAxisCount: 3,
                    axis: Axis.vertical,
                    scrollController: controller,
                  ),
                ),
                if (isAuthUser)
                  DownloadsListComponent(downloadsApi: context.read()),
                FollowListComponent(
                  user: user,
                  followApi: context.read(),
                  scrollController: controller,
                ),
                FollowListComponent(
                  user: user,
                  followApi: context.read(),
                  scrollController: controller,
                  isFollowed: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PublicUserHeaderComponent extends StatelessWidget {
  const PublicUserHeaderComponent({
    super.key,
    required this.user,
    required this.authUser,
  });

  final PublicUser user;
  final AuthUser authUser;

  @override
  Widget build(BuildContext context) {
    var isAuthUser = authUser.user?.id == user.id;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        spacing: 16,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(64),
            child: ImageComponent(user.imageUrl, height: 120, width: 120),
          ),
          Expanded(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Text(user.name, style: Theme.of(context).textTheme.titleLarge),
                Row(
                  spacing: 8,
                  children: [
                    ProfileMetricComponent(value: 72, metricName: 'listens'),
                    ProfileMetricComponent(value: 72, metricName: 'followers'),
                    ProfileMetricComponent(value: 72, metricName: 'following'),
                  ],
                ),
                SizedBox(height: 16),

                Row(
                  spacing: 8,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (!isAuthUser)
                      FollowIconComponent(
                        followApi: context.read(),
                        user: user,
                        icon: false,
                      ),
                    if (isAuthUser)
                      OutlinedButton(
                        onPressed: () => Navigate(context).editProfile(),
                        child: Text('Edit Profile'),
                      ),
                    if (isAuthUser)
                      OutlinedButton(
                        onPressed: () => authUser.signout(),
                        child: Text('Signout'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PublicUserListensComponent extends StatelessWidget {
  const PublicUserListensComponent({
    super.key,
    required this.user,
    required this.scrollController,
  });

  final PublicUser user;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    var listensApi = context.read<ListensApi>();
    var future = listensApi.listForUser(user.id);
    return Column(
      children: [
        // SubscriptionGridComponent(
        //   subscriptionsApi: context.read(),
        //   user: user,
        //   scrollController: scrollController,
        // ),
        Expanded(
          child: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingSpinnerComponent();
              }
              var result = snapshot.requireData;
              switch (result) {
                case ApiOkIterable():
                  break;
                case ApiErrorIterable():
                  return Text('Error: ${result.error}');
              }

              if (result.result.isEmpty) return Text('No listens');

              return InfiniteScrollComponent(
                // Needed to put this here, since
                // the stream would cache this component
                key: Key(result.hashCode.toString()),
                iterableApiResult: result,
                scrollController: scrollController,
                itemBuilder: (context, item) {
                  var episode = item.episode;
                  if (episode == null) {
                    return Text("No episode info found");
                  }
                  return EpisodeComponent(episode: item.episode!);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class PublicUserSubscriptionsComponent extends StatelessWidget {
  const PublicUserSubscriptionsComponent({
    super.key,
    required this.user,
    required this.scrollController,
  });

  final PublicUser user;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    var subscriptionsApi = context.read<SubscriptionsApi>();
    var future = subscriptionsApi.listForUser(user.id);
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingSpinnerComponent();
        }
        var result = snapshot.requireData;
        switch (result) {
          case ApiOkIterable():
            break;
          case ApiErrorIterable():
            return Text('Error: ${result.error}');
        }

        if (result.result.isEmpty) return Text('No listens');

        return InfiniteScrollComponent(
          // Needed to put this here, since
          // the stream would cache this component
          key: Key(result.hashCode.toString()),
          iterableApiResult: result,
          scrollController: scrollController,
          itemBuilder: (context, item) {
            var podcast = item.podcast;
            if (podcast == null) {
              return Text("No podcast info found");
            }
            return ListTile(
              leading: ImageComponent(podcast.imageUrl),
              title: Text(podcast.title),
              subtitle: Text(
                podcast.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                Navigate(context).toPodcast(podcast.id);
              },
            );
          },
        );
      },
    );
  }
}
