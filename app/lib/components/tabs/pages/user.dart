import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/listens.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/api/subscription.dart';
import 'package:resonate/api/user.dart';
import 'package:resonate/components/common/episode.dart';
import 'package:resonate/components/common/follow.dart';
import 'package:resonate/components/common/infinite_scroll.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/router/navigation.dart';

class PublicUserProfileComponent extends StatelessWidget {
  const PublicUserProfileComponent({
    super.key,
    required this.userId,
    required this.publicUserApi,
  });

  final String userId;
  final PublicUserApi publicUserApi;

  @override
  Widget build(BuildContext context) {
    final ScrollController controller = ScrollController();
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
          length: 2,
          child: NestedScrollView(
            controller: controller,
            headerSliverBuilder: (context, someBool) {
              return [
                SliverAppBar(
                  actions: [],
                  leading: ImageComponent(user.imageUrl),
                  pinned: true,
                  floating: true,
                  flexibleSpace: FlexibleSpaceBar(),
                  expandedHeight: 200.0,
                  title: Text(user.name),
                  bottom: TabBar(
                    tabs: [Tab(text: 'Listens'), Tab(text: 'Subscriptions')],
                  ),
                ),
                SliverToBoxAdapter(
                  child: FollowIconComponent(
                    followApi: context.read(),
                    user: user,
                  ),
                ),
              ];
            },
            body: TabBarView(
              // The content for each tab
              children: <Widget>[
                PublicUserListensComponent(
                  user: user,
                  scrollController: controller,
                ),
                PublicUserSubscriptionsComponent(
                  user: user,
                  scrollController: controller,
                ),
              ],
            ),
          ),
        );
      },
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
            var episode = item.episode;
            if (episode == null) {
              return Text("No episode info found");
            }
            return EpisodeComponent(episode: item.episode!);
          },
        );
      },
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
