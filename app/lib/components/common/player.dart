import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/player.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/components/common/reordable_listview.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/services/player.dart';

Logger _log = Logger('components/common/player');

class PlaylistComponent extends StatelessWidget {
  const PlaylistComponent({super.key, required this.playerApi});

  final PlayerApi playerApi;

  @override
  Widget build(BuildContext context) {
    var playlistApi = playerApi.playlistApi;
    return FutureBuilder(
      future: playlistApi.list(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingSpinnerComponent();
        }
        var episodes = snapshot.requireData.toList();
        return ReordableListviewComponent(
          items: episodes,
          onReorder: (oldIndex, newIndex) async {
            await Future.delayed(Duration(seconds: 1));
          },
          builder:
              (episode) => ListTile(
                key: Key(episode.id),
                leading: Image.network(episode.imageUrl),
                title: Text(episode.title),
                trailing: Icon(Icons.play_arrow),
              ),
        );
        return ListView.builder(
          itemCount: episodes.length,
          itemBuilder: (context, index) {
            var episode = episodes.elementAt(index);
            var widget = ListTile(
              leading: Image.network(episode.imageUrl),
              title: Text(episode.title),
              trailing: Icon(Icons.play_arrow),
            );
            return widget;
          },
        );
      },
    );
  }

  static void show(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return PlaylistComponent(playerApi: context.read());
      },
    );
  }
}

class PlayerComponentPage extends StatelessWidget {
  const PlayerComponentPage({super.key, required this.playerApi});

  final PlayerApi playerApi;

  @override
  Widget build(BuildContext context) {
    _log.info('PlayerComponentPage::build');
    final controller = PageController();
    return PageView(
      controller: controller,
      children: [
        PlayerComponent(playerApi: playerApi),
        PlaylistComponent(playerApi: playerApi),
      ],
    );
  }

  static void show(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return PlayerComponentPage(playerApi: context.read());
      },
    );
  }
}

class PlayerComponent extends StatelessWidget {
  const PlayerComponent({super.key, required PlayerApi playerApi})
    : _playerApi = playerApi;

  final PlayerApi _playerApi;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _playerApi,
      builder: (context, _) {
        if (_playerApi.state == PlayerState.init) {
          return Text('Nothing Playing');
        }
        var episode = _playerApi.episode!;
        return Center(
          child: Column(
            children: [
              Image.network(episode.imageUrl, height: 150, width: 150),
              Text(episode.title),
              PlayButtonComponent(playerApi: _playerApi, size: 100),
              PlayerSliderComponent(playerApi: _playerApi),
            ],
          ),
        );
      },
    );
  }

  static void show(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return PlayerComponent(playerApi: context.read());
      },
    );
  }
}

/* PlayerSliderComponent 

  This tracks the audio duration & buffering and updates a 
  slider to enable seek. 
*/
class PlayerSliderComponent extends StatefulWidget {
  const PlayerSliderComponent({super.key, required PlayerApi playerApi})
    : _playerApi = playerApi;

  final PlayerApi _playerApi;

  @override
  State<PlayerSliderComponent> createState() => _PlayerSliderComponentState();
}

class _PlayerSliderComponentState extends State<PlayerSliderComponent> {
  PlayerProgress _playerProgress = PlayerProgress();
  double _value = 0.0;
  StreamSubscription<PlayerProgress>? _progressSubscription;

  @override
  void initState() {
    super.initState();
    _progressSubscription = widget._playerApi.progressStream.listen((progress) {
      setState(() {
        _playerProgress = progress;
        _value = progress.percentProgress;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _progressSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: _value,
          // Use this for buffering..
          secondaryTrackValue: _playerProgress.percentBuffered,
          onChangeStart: (_) {
            _progressSubscription?.pause();
          },
          onChangeEnd: (newValue) {
            setState(() {
              _value = newValue;
            });
            widget._playerApi.seekProportional(newValue).then((_) {
              _progressSubscription?.resume();
            });
          },
          onChanged: (newValue) {
            setState(() {
              _value = newValue;
            });
          },
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [Text(duration), Text(remainingDuration)],
        // ),
      ],
    );
  }
}

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
                      child: GestureDetector(
                        onTap: () {
                          PlayerComponentPage.show(context);
                        },
                        child: Center(
                          child: ListTile(
                            title: Text(episode.title),
                            leading: Image.network(episode.imageUrl),
                            trailing: PlayButtonComponent(
                              playerApi: _playerApi,
                            ),
                          ),
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
          icon: Icon(Icons.pause_circle_outline),
          onPressed: () {
            _playerApi.pause();
          },
        );
      case PlayerState.paused:
        return IconButton(
          iconSize: size,
          icon: Icon(Icons.play_arrow_outlined),
          onPressed: () {
            _playerApi.play();
          },
        );

      case PlayerState.loading:
        return LoadingSpinnerComponent(size: size);
      case PlayerState.init:
      case PlayerState.finished:
        return Icon(Icons.done, size: size);
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
