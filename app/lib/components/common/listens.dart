import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/listens.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/models/models.dart';

Logger _log = Logger('components/common/listens');

class ListensListComponent extends StatelessWidget {
  const ListensListComponent({super.key, required ListensApi listensApi})
    : _listensApi = listensApi;
  final ListensApi _listensApi;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _listensApi.get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingSpinnerComponent();
        }
        var result = snapshot.requireData;
        switch (result) {
          case ApiOk():
            _log.info('result::ok::${result.value.length}');
            break;
          case ApiError():
            return Text('Error loading subscriptions: ${result.error}');
        }

        var episodes = result.value;
        return ListView.builder(
          itemCount: episodes.length,
          itemBuilder: (context, index) {
            var episode = episodes.elementAt(index).episode;
            if (episode == null) {
              return Text('episode not found');
            }
            return ListTile(
              // onTap: () => Navigate(context).toPodcast(episodes.id),
              leading: ImageComponent(episode.imageUrl),
              title: Text(episode.title),
              subtitle: Text(episode.description, maxLines: 2),
            );
          },
        );
      },
    );
  }
}
