import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/podcast.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/components/tabs/pages/base.dart';

Logger _log = Logger('components/tabs/pages/podcast');

class PodcastPage extends PageComponent {
  const PodcastPage({
    super.key,
    required this.podcastId,
    required PodcastApi podcastApi,
  }) : _podcastApi = podcastApi,
       super(title: 'Podcast');

  final String podcastId;
  final PodcastApi _podcastApi;

  @override
  Widget buildChild(BuildContext context) {
    return StreamBuilder(
      stream: _podcastApi.get(podcastId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoadingSpinnerComponent();
        }
        return Text('test');
      },
    );
  }
}
