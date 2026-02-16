import 'package:flutter/material.dart';
import 'package:resonate/api/player.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/services/player/player.dart';

class PlayButtonComponent extends StatelessWidget {
  const PlayButtonComponent({
    super.key,
    required PlayerApi playerApi,
    this.size = 16,
  }) : _playerApi = playerApi;

  final PlayerApi _playerApi;
  final double size;

  @override
  Widget build(BuildContext context) {
    switch (_playerApi.state) {
      case PlayerApiState.playing:
        return IconButton(
          iconSize: size,
          icon: Icon(Icons.pause_rounded),
          onPressed: () {
            _playerApi.pause();
          },
        );
      case PlayerApiState.init:
      case PlayerApiState.resumable:
      case PlayerApiState.paused:
        return IconButton(
          iconSize: size,
          icon: Icon(Icons.play_arrow_rounded),
          onPressed: () {
            _playerApi.play();
          },
        );

      case PlayerApiState.loading:
        // TODO(duncan): Center this somehow?
        return LoadingSpinnerComponent(size: size);

      case PlayerApiState.finished:
        return Icon(Icons.done, size: size);
    }
  }
}
