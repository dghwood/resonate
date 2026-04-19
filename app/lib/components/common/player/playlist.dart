import 'package:flutter/material.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/components/common/reordable_listview.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/services/player/audio_handler.dart';

class PlaylistComponent extends StatefulWidget {
  const PlaylistComponent({
    super.key,
    required this.playerApi,
    // required this.controller,
  });

  final AudioHandlerService playerApi;
  // final PageController controller;

  @override
  State<PlaylistComponent> createState() => _PlaylistComponentState();

  static void show(BuildContext context) {
    showBottomSheet(
      // isScrollControlled: true,
      showDragHandle: true,
      constraints: BoxConstraints(maxHeight: 320),
      enableDrag: true,
      context: context,
      builder: (context) {
        return PlaylistComponent(playerApi: AudioHandlerService.instance);
      },
    );
  }
}

class _PlaylistComponentState extends State<PlaylistComponent> {
  @override
  Widget build(BuildContext context) {
    var playlistApi = widget.playerApi.playlist;
    return ListenableBuilder(
      listenable: playlistApi,
      builder: (context, _) {
        var episodes = playlistApi.episodes;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ReordableListviewComponent(
                items: episodes,
                onReorder: (oldIndex, newIndex) async {
                  await playlistApi.reorder(oldIndex, newIndex);
                },
                builder:
                    (episode) => ListTile(
                      onTap: () async {
                        await playlistApi.play(episode);
                        // setState(() {});
                      },
                      selected: episode == playlistApi.episode,
                      key: Key(episode.id),
                      leading: ImageComponent(episode.imageUrl, radius: 10),
                      title: Text(episode.title),
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}
