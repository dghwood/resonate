import 'package:flutter/material.dart';
import 'package:resonate/models/models.dart';

class EpisodeComponent extends StatelessWidget {
  const EpisodeComponent({super.key, required this.episode});

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(episode.title),
          subtitle: Text(episode.description ?? ''),
        ),
        Row(
          children: [
            IconButton(icon: Icon(Icons.play_arrow_outlined), onPressed: () {}),
            IconButton(icon: Icon(Icons.star), onPressed: () {}),
            IconButton(icon: Icon(Icons.playlist_add), onPressed: () {}),
          ],
        ),
      ],
    );
  }
}
