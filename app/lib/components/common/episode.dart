import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/player.dart';
import 'package:resonate/components/common/download.dart';
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
          subtitle: Text(episode.description),
        ),
        Row(
          children: [
            PlayIconComponent(
              key: Key('play-icon-component-${episode.id}'),
              playerApi: context.read(),
              authUser: context.read(),
              episode: episode,
            ),
            IconButton(icon: Icon(Icons.star), onPressed: () {}),
            PlaylistAddIcon(episode: episode, playerApi: context.read()),
            DownloadIconComponent(
              downloadApi: context.read<AuthUser>().downloadApi,
              episode: episode,
            ),
          ],
        ),
      ],
    );
  }
}

/* PlaylistAddIcon 

  States: 
   * Episode not in list => add to list 
   * Episode in list => make next up
*/
class PlaylistAddIcon extends StatefulWidget {
  const PlaylistAddIcon({
    super.key,
    required this.episode,
    required this.playerApi,
  });

  final Episode episode;
  final PlayerApi playerApi;

  @override
  State<PlaylistAddIcon> createState() => _PlaylistAddIconState();
}

class _PlaylistAddIconState extends State<PlaylistAddIcon> {
  @override
  Widget build(BuildContext context) {
    var playlistApi = widget.playerApi.playlistApi;
    if (playlistApi.has(widget.episode)) {
      return IconButton(
        icon: Icon(Icons.playlist_remove),
        onPressed: () async {
          await playlistApi.remove(widget.episode);
          setState(() {});
        },
      );
    }
    return IconButton(
      icon: Icon(Icons.playlist_add),
      onPressed: () async {
        await playlistApi.add(widget.episode);
        setState(() {});
      },
    );
    ;
  }
}
