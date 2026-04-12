import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/services/player/audio_handler.dart';

Logger _log = Logger('components/common/player/play_icon');

class PlayButtonComponent extends StatelessWidget {
  const PlayButtonComponent({
    super.key,
    required AudioHandlerService playerApi,
    this.size = 16,
  }) : _playerApi = playerApi;

  final AudioHandlerService _playerApi;
  final double size;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // Is this the right stream to listen to?
      stream: _playerApi.stateStream,
      initialData: _playerApi.state,
      builder: (context, _) {
        _log.info("stateStream::${_playerApi.state.playerState}");
        switch (_playerApi.state.playerState) {
          case PlayerState.playing:
            return IconButton(
              iconSize: size,
              icon: Icon(Icons.pause_rounded),
              onPressed: () {
                _playerApi.pause();
              },
            );
          case PlayerState.init:
          // case PlayerState.resumable:
          case PlayerState.paused:
            return IconButton(
              iconSize: size,
              icon: Icon(Icons.play_arrow_rounded),
              onPressed: () {
                _playerApi.play();
              },
            );

          case PlayerState.loading:
            // TODO(duncan): Center this somehow?
            return LoadingSpinnerComponent(size: size);

          case PlayerState.finished:
            return Icon(Icons.done, size: size);
        }
      },
    );
  }
}
