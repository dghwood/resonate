import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
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
    // Optional?
    required AuthUser authUser,
  }) : _playerApi = playerApi,
       _episode = episode,
       _authUser = authUser;

  final PlayerApi _playerApi;
  final Episode _episode;
  final AuthUser _authUser;

  @override
  State<PlayIconComponent> createState() => _PlayIconComponentState();
}

class _PlayIconComponentState extends State<PlayIconComponent> {
  double _value = 100;
  StreamSubscription<PlayerProgress>? _stream;

  @override
  void initState() {
    var listen = widget._authUser.listenApi.get(widget._episode.id);
    if (listen != null) {
      _value = listen.seconds.toInt() / widget._episode.durationSeconds.toInt();
    }

    super.initState();
  }

  @override
  void dispose() {
    _stream?.cancel();
    super.dispose();
  }

  void _onData(PlayerProgress progress) {
    _log.info('_onData::$progress');
    setState(() {
      _value = progress.percentProgress;
    });
  }

  void _onPressed() async {
    _log.info('onPressed');
    var currentEpisode = widget._playerApi.episode;
    if (currentEpisode != null && widget._episode.id == currentEpisode.id) {
      _log.info('current episode playing');
      return;
    }
    await widget._playerApi.load(widget._episode);
    _log.info('listening to stream');
    _stream = widget._playerApi.progressStream.listen(_onData);
    _log.info('listened to stream');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircularProgressIndicator(value: _value),
        IconButton(icon: Icon(Icons.play_arrow), onPressed: _onPressed),
      ],
    );
  }
}
