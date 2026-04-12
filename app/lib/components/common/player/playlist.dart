import 'package:flutter/material.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/components/common/reordable_listview.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/services/player/audio_handler.dart';

class PlaylistComponent extends StatefulWidget {
  const PlaylistComponent({
    super.key,
    required this.playerApi,
    required this.controller,
  });

  final AudioHandlerService playerApi;
  final PageController controller;

  @override
  State<PlaylistComponent> createState() => _PlaylistComponentState();
}

class _PlaylistComponentState extends State<PlaylistComponent> {
  @override
  Widget build(BuildContext context) {
    var playlistApi = widget.playerApi.playlist;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            'NOW PLAYING',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        ListenableBuilder(
          listenable: playlistApi,
          builder: (context, _) {
            var episode = playlistApi.episode;
            if (episode == null) {
              return Text('Nothing playing');
            }
            return ListTile(
              leading: ImageComponent(episode.imageUrl, radius: 10),
              title: Text(episode.title),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            'PLAYLIST',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: Future.value(playlistApi.episodes),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingSpinnerComponent();
              }
              var episodes = snapshot.requireData.toList();
              return ReordableListviewComponent(
                items: episodes,
                onReorder: (oldIndex, newIndex) async {
                  await playlistApi.reorder(oldIndex, newIndex);
                },
                builder:
                    (episode) => ListTile(
                      onTap: () async {
                        // Add playing Episode (if any to playlist)
                        // playlistApi.replace(
                        //   episode,
                        //   widget.playerApi.getPlayingEpisode(),
                        // );
                        // Start playing it
                        await playlistApi.play(episode);
                        setState(() {});
                      },
                      key: Key(episode.id),
                      leading: ImageComponent(episode.imageUrl, radius: 10),
                      title: Text(episode.title),
                    ),
              );
            },
          ),
        ),
      ],
    );
  }
}
