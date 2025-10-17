import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/feed.dart';
import 'package:resonate/api/player.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/components/common/episode.dart';
import 'package:resonate/components/common/infinite_scroll2.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/components/common/player.dart';
import 'package:resonate/components/common/refresh.dart';
import 'package:resonate/components/common/subscriptions.dart';
import 'package:resonate/components/tabs/base.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/router/navigation.dart';
import 'package:resonate/api/errors.dart';

final Logger _log = Logger('components/tabs/home');

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('home'),
        TextButton(
          child: Text('show playlist'),
          onPressed: () {
            PlaylistComponent.show(context);
          },
        ),
        TextButton(
          child: Text('show error'),
          onPressed: () {
            var errorService = context.read<ErrorService>();
            errorService.report(context, Exception('This is an error'));
          },
        ),
        TextButton(
          child: Text('Go to podcast'),
          onPressed: () {
            Navigate(context).toPodcast('123');
          },
        ),
        TextButton(
          child: Text("Go to user"),
          onPressed: () {
            Navigate(context).toPublicProfile(
              '3f2b211a4333b7c1a7a5df915549d262a25207290e8063ae7a4edee36094b109',
            );
          },
        ),
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 150,
                child: SubscriptionGridComponent(
                  subscriptionsApi: context.read(),
                  user: PublicUser.fromUser(context.read<AuthUser>().user!),
                  scrollController: ScrollController(),
                ),
              ),
              Expanded(child: FeedComponent(feedApi: context.read())),
            ],
          ),
        ),
      ],
    );
  }
}

class FeedComponent
    extends RefreshIndicatorComponent<Stream<ApiResult<UserFeed>>> {
  FeedComponent({super.key, required GetFeedApi feedApi})
    : super(value: () => feedApi.get());

  // final GetFeedApi _feedApi;

  @override
  Widget build(BuildContext context, Stream<ApiResult<UserFeed>> value) {
    _log.info("FeedComponent::build");
    return StreamBuilder(
      stream: value,
      builder: (context, snapshot) {
        _log.info("FeedComponent::stream::${snapshot.connectionState}");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingSpinnerComponent();
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
            return EpisodeComponent(episode: episodeItem.episode);
          },
        );
      },
    );
  }
}
