import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/player.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/services/player.dart';

Logger _log = Logger('components/common/player');

class BottomPlayerComponent extends StatelessWidget {
  const BottomPlayerComponent({super.key, required PlayerApi playerApi})
    : _playerApi = playerApi;

  final PlayerApi _playerApi;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      // showDragHandle: true,
      enableDrag: false,
      constraints: BoxConstraints(maxHeight: 80),
      onClosing: () {},
      builder: (context) {
        return ListenableBuilder(
          listenable: _playerApi,
          builder: (context, _) {
            _log.info(_playerApi.state);
            if (_playerApi.state == PlayerState.init) return SizedBox();

            var episode = _playerApi.episode!;
            return Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: ListTile(
                          title: Text(episode.title),
                          leading: Image.network(episode.imageUrl),
                          trailing: PlayButtonComponent(playerApi: _playerApi),
                        ),
                      ),
                    ),
                    StreamBuilder(
                      stream: _playerApi.progressStream,
                      builder: (context, asyncSnapshot) {
                        var value = 0.0;
                        if (asyncSnapshot.hasData) {
                          var data = asyncSnapshot.requireData;
                          value = data.progressDuration!.inSeconds / 30;
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

class PlayButtonComponent extends StatelessWidget {
  const PlayButtonComponent({super.key, required PlayerApi playerApi})
    : _playerApi = playerApi;

  final PlayerApi _playerApi;

  @override
  Widget build(BuildContext context) {
    switch (_playerApi.state) {
      case PlayerState.playing:
        return IconButton(
          icon: Icon(Icons.pause_circle_outline),
          onPressed: () {
            _playerApi.pause();
          },
        );
      case PlayerState.paused:
        return IconButton(
          icon: Icon(Icons.play_arrow_outlined),
          onPressed: () {
            _playerApi.play();
          },
        );

      case PlayerState.loading:
        return LoadingSpinnerComponent(size: 16);
      case PlayerState.init:
      case PlayerState.finished:
        return Icon(Icons.done);
    }
  }
}

class PlayIconComponent extends StatefulWidget {
  const PlayIconComponent({
    super.key,
    required PlayerApi playerApi,
    required Episode episode,
  }) : _playerApi = playerApi,
       _episode = episode;

  final PlayerApi _playerApi;
  final Episode _episode;

  @override
  State<PlayIconComponent> createState() => _PlayIconComponentState();
}

class _PlayIconComponentState extends State<PlayIconComponent> {
  double _value = 100;
  StreamSubscription<PlayerProgress>? _stream;

  @override
  void dispose() {
    _stream?.cancel();
    super.dispose();
  }

  void _onData(PlayerProgress process) {
    setState(() {
      _value = process.percentProgress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircularProgressIndicator(value: _value),
        IconButton(
          icon: Icon(Icons.play_arrow),
          onPressed: () async {
            await widget._playerApi.load(widget._episode);
            _stream = widget._playerApi.progressStream.listen(_onData);
          },
        ),
      ],
    );
  }
}
