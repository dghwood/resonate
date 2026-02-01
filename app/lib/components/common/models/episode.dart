import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/player.dart';
import 'package:resonate/api/settings.dart';
import 'package:resonate/components/common/models/download.dart';
import 'package:resonate/components/common/player/player.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/router/navigation.dart';
import 'package:resonate/utils/time.dart';

Logger _log = Logger('components/common/episode');

class SocialHeaderEpisodeComponent extends StatelessWidget {
  const SocialHeaderEpisodeComponent({super.key, required this.listens});

  final Iterable<UserListen> listens;

  final double width = 28;
  final double height = 28;

  @override
  Widget build(BuildContext context) {
    if (listens.isEmpty) return Container();
    var listen = listens.elementAt(0);
    var user = listen.publicUser;
    if (user == null) return Container();
    var text = user.name;
    if (listens.length > 1) {
      text += ' and ${listens.length - 1} others';
    }
    text += ' listened';
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: 8,
      children: [
        StackedProfileImageComponent(
          borderWidth: 1.5,
          radius: width > height ? width : height,
          users: listens.take(3).map((l) => l.publicUser),
        ),
        Text(text, style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }
}

class EpisodeComponent extends StatelessWidget {
  const EpisodeComponent({
    super.key,
    required this.episode,
    this.feedItemType = FeedItemType.FEED_ITEM_SUBSCRIPTION,
    this.listens = const [],
  });

  final Episode episode;
  final FeedItemType feedItemType;
  final Iterable<UserListen> listens;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
          ),
        ),
      ),
      // color: Theme.of(context).colorScheme.surfaceContainer,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
      // margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Row(
            spacing: 8,
            children: [
              InkWell(
                onTap: () => Navigate(context).toPodcast(episode.podcastId),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ImageComponent(episode.imageUrl, height: 70),
                ),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      episode.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      formatTimeAgo(episode.publishDateTime),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            episode.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            spacing: 8,
            children: [
              PlayIconComponent(
                key: Key('play-icon-component-${episode.id}'),
                playerApi: context.read(),
                authUser: context.read(),
                episode: episode,
              ),
              if (context.read<SettingsApi>().settings.enablePlaylist)
                PlaylistAddIcon(episode: episode, playerApi: context.read()),
              if (!kIsWeb || false)
                DownloadIconComponent(
                  downloadApi: context.read<AuthUser>().downloadApi,
                  episode: episode,
                ),
              Expanded(child: SocialHeaderEpisodeComponent(listens: listens)),
            ],
          ),
          // Text(episode.audioUrl),
          // Divider(),
        ],
      ),
    );
    return Column(
      children: [
        ListTile(
          leading: GestureDetector(
            onTap: () {
              Navigate(context).toPodcast(episode.podcastId);
            },
            child: ImageComponent(episode.imageUrl),
          ),
          title: Text(episode.title),
          subtitle: Text(
            episode.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(formatTimeAgo(episode.publishDateTime)),
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
