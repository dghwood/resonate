import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/feed.dart';
import 'package:resonate/api/player.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/components/common/infinite_scroll2.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/components/tabs/base.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/router/navigation.dart';
import 'package:resonate/api/errors.dart';

final Logger _log = Logger('HomePage');

class HomePage extends TabComponent {
  const HomePage({super.key}) : super(title: 'Home');

  @override
  Widget buildChild(BuildContext context) {
    return Column(
      children: [
        Text('home'),

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
        FeedComponent(feedApi: context.read()),
      ],
    );
  }
}

class FeedComponent extends StatelessWidget {
  const FeedComponent({super.key, required GetFeedApi feedApi})
    : _feedApi = feedApi;

  final GetFeedApi _feedApi;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _feedApi.get(),
      builder: (context, snapshot) {
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
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            var item = items.elementAt(index);
            if (item.episodeItem == null) {
              return Text('Recommendations not implemented');
            }
            var episodeItem = item.episodeItem!;
            return ListTile(
              title: Text(episodeItem.episode.title),
              leading: Image.network(episodeItem.episode.imageUrl),
            );
          },
        );
      },
    );
  }
}
