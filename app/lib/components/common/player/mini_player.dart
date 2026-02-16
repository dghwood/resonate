import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/player.dart';
import 'package:resonate/components/common/player/play_icon.dart';
import 'package:resonate/components/common/player/player.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/services/player/player.dart';

final Logger _log = Logger('components/common/player/mini_player');

class BottomPlayerComponent extends StatelessWidget {
  const BottomPlayerComponent({super.key, required PlayerApi playerApi})
    : _playerApi = playerApi;

  final PlayerApi _playerApi;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      enableDrag: false,
      constraints: BoxConstraints(maxHeight: 80),
      onClosing: () {},
      builder: (context) {
        return ListenableBuilder(
          listenable: _playerApi,
          builder: (context, _) {
            _log.info(_playerApi.state);
            if (_playerApi.state == PlayerState.init &&
                _playerApi.getPlayingEpisode() == null) {
              return SizedBox();
            }

            var episode = _playerApi.getPlayingEpisode()!;
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
                      stream: _playerApi.subscribeToEpisodeProgress(episode.id),
                      builder: (context, asyncSnapshot) {
                        var value = 0.0;
                        if (asyncSnapshot.hasData) {
                          var data = asyncSnapshot.requireData;
                          value = data.percentProgress;
                        }
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
