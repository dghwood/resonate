import 'package:flutter/material.dart';
import 'package:resonate/api/player.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/services/player.dart';

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
      case PlayerState.playing:
        return IconButton(
          iconSize: size,
          icon: Icon(Icons.pause_rounded),
          onPressed: () {
            _playerApi.pause();
          },
        );
      case PlayerState.init:
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
  }
}
