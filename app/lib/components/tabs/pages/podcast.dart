import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/podcast.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/api/subscription.dart';
import 'package:resonate/components/common/infinite_scroll2.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/components/common/subscribe.dart';
import 'package:resonate/components/tabs/pages/base.dart';

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
    return StreamBuilder(
      stream: _podcastApi.get(podcastId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoadingSpinnerComponent();
        }
        var result = snapshot.requireData;
        switch (result) {
          case ApiOk():
            var podcast = result.value;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Image.network(podcast.imageUrl),
                      Text('Podcast: ${podcast.title}'),

                      SubscribeIconCommponent(
                        authUser: _authUser,
                        podcastId: podcast.id,
                      ),
                    ],
                  ),
                  StreamBuilder(
                    stream: _podcastApi.list(podcastId),
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
                              return ListTile(
                                title: Text(episode.title),
                                subtitle: Text(episode.description ?? ''),
                              );
                            },
                          );
                        case ApiError():
                          return Text('Error: ${result.error}');
                      }
                    },
                  ),
                ],
              ),
            );
          case ApiError():
            return Text('error: ${result.error}');
        }
      },
    );
  }
}
