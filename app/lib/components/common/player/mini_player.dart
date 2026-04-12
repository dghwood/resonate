import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/components/common/player/play_icon.dart';
import 'package:resonate/components/common/player/player.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/services/player/audio_handler.dart';

final Logger _log = Logger('components/common/player/mini_player');

class BottomPlayerComponent extends StatelessWidget {
  const BottomPlayerComponent({
    super.key,
    required AudioHandlerService playerApi,
  }) : _playerApi = playerApi;

  final AudioHandlerService _playerApi;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      enableDrag: false,
      constraints: BoxConstraints(maxHeight: 80),
      onClosing: () {},
      builder: (context) {
        return ListenableBuilder(
          // This needs to rebuild when the episode changes
          listenable: _playerApi.playlist,
          builder: (context, _) {
            _log.info(_playerApi.state);

            var episode = _playerApi.playlist.episode;
            if (episode == null) {
              return SizedBox();
            }

            return Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: ListTile(
                          onTap: () {
                            PlayerComponentPage.show(context);
                          },
                          title: Text(
                            episode.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          leading: ImageComponent(episode.imageUrl, radius: 10),
                          trailing: PlayButtonComponent(
                            playerApi: _playerApi,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                    StreamBuilder(
                      stream: _playerApi.positionStream,
                      builder: (context, snapshot) {
                        var value =
                            snapshot.data?.episodeState?.percentProgress ?? 0.0;
                        return LinearProgressIndicator(value: value);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
