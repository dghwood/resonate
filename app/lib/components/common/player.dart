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
import 'package:resonate/utils/time.dart';

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

enum PlayIconNotifierStatus { init, listening, listened, finished }

class PlayIconNotifier extends ChangeNotifier {
  PlayIconNotifier({
    required this.playerApi,
    required this.episode,
    required this.authUser,
  }) {
    _duration = episode.duration;
    var listen = authUser.listenApi.get(episode.id);
    if (listen == null) return;

    _duration = episode.duration - Duration(seconds: listen.seconds);
    _status = PlayIconNotifierStatus.listened;
    if (listen.completed) {
      _status = PlayIconNotifierStatus.finished;
    }
  }

  final PlayerApi playerApi;
  final Episode episode;
  final AuthUser authUser;
  PlayIconNotifierStatus _status = PlayIconNotifierStatus.init;
  PlayIconNotifierStatus get status => _status;
  Duration _duration = Duration.zero;
  Duration get duration => _duration;
  StreamSubscription<PlayerProgress>? _progressStream;

  void _onProgress(PlayerProgress progress) {
    if (progress.duration == null) return;

    _duration =
        progress.duration! - (progress.progressDuration ?? Duration.zero);
    if (progress.completed) {
      _status = PlayIconNotifierStatus.finished;
    }
    notifyListeners();
  }

  void listen() {
    _status = PlayIconNotifierStatus.listening;
    _progressStream = playerApi.progressStream.listen(_onProgress);
  }

  @override
  void dispose() {
    _progressStream?.cancel();
    super.dispose();
  }
}

class PlayIconComponent extends StatelessWidget {
  PlayIconComponent({
    super.key,
    required this.playerApi,
    required this.episode,
    required this.authUser,
  }) {
    notifier = PlayIconNotifier(
      playerApi: playerApi,
      episode: episode,
      authUser: authUser,
    );
  }

  final PlayerApi playerApi;
  final Episode episode;
  final AuthUser authUser;
  late final PlayIconNotifier notifier;

  void _onPressed() async {
    var currentEpisode = playerApi.episode;
    if (currentEpisode != null && episode.id == currentEpisode.id) {
      return;
    }
    await playerApi.load(episode);
    notifier.listen();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: notifier,
      builder: (context, _) {
        return GestureDetector(
          onTap: _onPressed,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Theme.of(context).dividerColor,
              ),
              borderRadius: BorderRadius.circular(50.0),
            ),
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Bit lazy, but icon button here just keep the
                // sizing and padding equal with the other buttons
                IconButton(
                  icon: Icon(Icons.play_circle_outline),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {},
                ),
                Text(formatDuration(notifier.duration)),
                SizedBox(width: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}

// class PlayIconComponent extends StatefulWidget {
//   const PlayIconComponent({
//     super.key,
//     required this.playerApi,
//     required this.episode,
//     // Optional?
//     required this.authUser,
//   });

//   final PlayerApi playerApi;
//   final Episode episode;
//   final AuthUser authUser;

//   @override
//   State<PlayIconComponent> createState() => _PlayIconComponentState();
// }

// class _PlayIconComponentState extends State<PlayIconComponent> {
//   double _value = 100;
//   Duration _duration = Duration.zero;
//   StreamSubscription<PlayerProgress>? _stream;

//   @override
//   void initState() {
//     _duration = widget.episode.duration;
//     var listen = widget.authUser.listenApi.get(widget.episode.id);
//     if (listen != null) {
//       _duration = widget.episode.duration - Duration(seconds: listen.seconds);
//       _value = listen.seconds.toInt() / widget.episode.durationSeconds.toInt();
//     }

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _stream?.cancel();
//     super.dispose();
//   }

//   void _onData(PlayerProgress progress) {
//     setState(() {
//       if (progress.duration != null) {
//         _duration =
//             progress.duration! - (progress.progressDuration ?? Duration.zero);
//       }
//       _value = progress.percentProgress;
//     });
//   }

//   void _onPressed() async {
//     var currentEpisode = widget.playerApi.episode;
//     if (currentEpisode != null && widget.episode.id == currentEpisode.id) {
//       return;
//     }
//     await widget.playerApi.load(widget.episode);
//     _stream = widget.playerApi.progressStream.listen(_onData);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(width: 1.0, color: Theme.of(context).dividerColor),
//         borderRadius: BorderRadius.circular(50.0),
//       ),
//       width: 100,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           IconButton(
//             icon: Icon(Icons.play_circle_outline),
//             onPressed: _onPressed,
//           ),
//           Text(formatDuration(_duration)),
//           SizedBox(width: 8),
//         ],
//       ),
//     );
//   }
// }
