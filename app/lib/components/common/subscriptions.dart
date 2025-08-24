import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/api/subscription.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/components/common/subscribe.dart';
import 'package:resonate/router/navigation.dart';

Logger _log = Logger('components/common/subscriptions');

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
