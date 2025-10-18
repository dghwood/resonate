import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/api/subscription.dart';
import 'package:resonate/components/common/infinite_scroll.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/components/common/subscribe.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/router/navigation.dart';

Logger _log = Logger('components/common/subscriptions');

class SubscriptionGridComponent extends StatefulWidget {
  const SubscriptionGridComponent({
    super.key,
    required this.subscriptionsApi,
    required this.user,
    required this.scrollController,
    this.height = 150,
  });

  final SubscriptionsApi subscriptionsApi;
  final PublicUser user;
  final ScrollController scrollController;
  final double height;

  @override
  State<SubscriptionGridComponent> createState() =>
      _SubscriptionGridComponentState();
}

class _SubscriptionGridComponentState extends State<SubscriptionGridComponent> {
  late Future<IterableApiResult<Iterable<UserSubscription>>> _future;
  @override
  void initState() {
    super.initState();
    _future = widget.subscriptionsApi.listForUser(widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('SUBSCRIPTIONS', style: Theme.of(context).textTheme.labelMedium),
          Expanded(
            child: FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingSpinnerComponent();
                }
                var result = snapshot.requireData;
                switch (result) {
                  case ApiOkIterable():
                    break;
                  case ApiErrorIterable():
                    return Text('Error loading subscriptions: ${result.error}');
                }

                return InfiniteScrollGridComponent(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  iterableApiResult: result,
                  scrollController: widget.scrollController,
                  itemBuilder: (BuildContext context, userSubscription) {
                    var podcast = userSubscription.podcast!;
                    return GridTile(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ImageComponent(podcast.imageUrl),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SubscriptionListComponent extends StatelessWidget {
  const SubscriptionListComponent({
    super.key,
    required SubscriptionsApi subscriptionsApi,
  }) : _subscriptionsApi = subscriptionsApi;
  final SubscriptionsApi _subscriptionsApi;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _subscriptionsApi.get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingSpinnerComponent();
        }
        var result = snapshot.requireData;
        switch (result) {
          case ApiOk():
            break;
          case ApiError():
            return Text('Error loading subscriptions: ${result.error}');
        }

        var podcasts = result.value;
        return ListView.builder(
          itemCount: podcasts.length,
          itemBuilder: (context, index) {
            var podcast = podcasts.elementAt(index);
            return ListTile(
              onTap: () => Navigate(context).toPodcast(podcast.id),
              leading: Image.network(podcast.imageUrl),
              title: Text(podcast.title),
              subtitle: Text(podcast.description, maxLines: 2),
              trailing: SubscribeIconCommponent(
                authUser: context.read(),
                podcast: podcast,
              ),
            );
          },
        );
      },
    );
  }
}
