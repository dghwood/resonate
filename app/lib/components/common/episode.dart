import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/components/common/player.dart';
import 'package:resonate/models/models.dart';

Logger _log = Logger('components/common/episode');

class EpisodeComponent extends StatelessWidget {
  const EpisodeComponent({super.key, required this.episode});

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Image.network(episode.imageUrl),
          title: Text(episode.title),
          subtitle: Text(episode.description ?? ''),
        ),
        Row(
          children: [
            PlayIconComponent(
              key: Key('play-icon-component-${episode.id}'),
              playerApi: context.read(),
              episode: episode,
            ),
            IconButton(icon: Icon(Icons.star), onPressed: () {}),
            IconButton(icon: Icon(Icons.playlist_add), onPressed: () {}),
          ],
        ),
      ],
    );
  }
}
