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

class SubscriptionComponent extends StatelessWidget {
  const SubscriptionComponent({super.key, required this.subscription});

  final UserSubscription subscription;

  static Widget mock = ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: AspectRatio(
      aspectRatio: 1,
      child: Container(width: 100, height: 100, color: Colors.red),
    ),
  );

  @override
  Widget build(BuildContext context) {
    if (subscription.podcast == null) {
      return Text('Podcast not found');
    }
    var podcast = subscription.podcast!;
    return GestureDetector(
      onTap: () {
        Navigate(context).toPodcast(podcast.id);
      },
      child: GridTile(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ImageComponent(podcast.imageUrl),
        ),
      ),
    );
  }
}

class SubscriptionGridComponent extends StatefulWidget {
  const SubscriptionGridComponent({
    super.key,
    required this.subscriptionsApi,
    required this.user,
    required this.scrollController,
    this.showTitle = true,
    this.axis = Axis.horizontal,
    this.crossAxisCount = 1,
    this.height = 150,
  });

  final SubscriptionsApi subscriptionsApi;
  final PublicUser user;
  final ScrollController scrollController;
  final bool showTitle;
  final Axis axis;
  final double height;
  final int crossAxisCount;

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
    var gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: widget.crossAxisCount,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    );
    return SizedBox(
      height: widget.height,
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.showTitle)
            Text(
              'SUBSCRIPTIONS',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          Expanded(
            child: FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SkeletonLoadingComponent(
                    child: GridView.builder(
                      scrollDirection: widget.axis,
                      itemCount: 10,
                      gridDelegate: gridDelegate,
                      itemBuilder: (context, _) {
                        return SubscriptionComponent.mock;
                      },
                    ),
                  );
                }
                ;
                var result = snapshot.requireData;
                switch (result) {
                  case ApiOkIterable():
                    break;
                  case ApiErrorIterable():
                    return Text('Error loading subscriptions: ${result.error}');
                }

                return InfiniteScrollGridComponent(
                  axis: widget.axis,
                  gridDelegate: gridDelegate,
                  iterableApiResult: result,
                  scrollController: widget.scrollController,
                  itemBuilder: (BuildContext context, userSubscription) {
                    return SubscriptionComponent(
                      subscription: userSubscription,
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
