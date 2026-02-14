import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/player.dart';
import 'package:resonate/api/settings.dart';
import 'package:resonate/components/common/player/play_icon.dart';
import 'package:resonate/components/common/player/playlist.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/services/player.dart';
import 'package:resonate/utils/time.dart';

Logger _log = Logger('components/common/player');

class PlayerComponentPage extends StatelessWidget {
  const PlayerComponentPage({super.key, required this.playerApi});

  final PlayerApi playerApi;

  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    return PageView(
      controller: controller,
      children: [
        PlayerComponent(playerApi: playerApi),
        if (context.read<SettingsApi>().settings.enablePlaylist)
          PlaylistComponent(playerApi: playerApi, controller: controller),
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
        if (_playerApi.state == PlayerApiState.init) {
          return Text('Nothing Playing');
        }
        var episode = _playerApi.getPlayingEpisode()!;
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageComponent(
                  episode.imageUrl,
                  height: 250,
                  width: 250,
                  radius: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          episode.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      // Text(
                      //   episode.publishDateTime.toString(),
                      //   style: Theme.of(context).textTheme.titleMedium,
                      // ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 32,
                  children: [
                    IconButton(
                      icon: Icon(Icons.replay_10),
                      iconSize: 32,
                      onPressed: () {
                        _playerApi.forward(Duration(seconds: -10));
                      },
                    ),
                    PlayButtonComponent(playerApi: _playerApi, size: 64),
                    IconButton(
                      iconSize: 32,
                      icon: Icon(Icons.forward_30),
                      onPressed: () {
                        _playerApi.forward(Duration(seconds: 30));
                      },
                    ),
                  ],
                ),
                PlayerSliderComponent(playerApi: _playerApi, episode: episode),
              ],
            ),
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
  const PlayerSliderComponent({
    super.key,
    required PlayerApi playerApi,
    required this.episode,
  }) : _playerApi = playerApi;

  final PlayerApi _playerApi;
  final Episode episode;

  @override
  State<PlayerSliderComponent> createState() => _PlayerSliderComponentState();
}

class _PlayerSliderComponentState extends State<PlayerSliderComponent> {
  PlayerProgress? _playerProgress;
  double _value = 0.0;
  StreamSubscription<PlayerProgress>? _progressSubscription;

  @override
  void initState() {
    super.initState();
    _progressSubscription = widget._playerApi
        .subscribeToEpisodeProgress(widget.episode.id)
        .listen((progress) {
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
    var progress =
        _playerProgress ??
        PlayerProgress(
          bufferedDuration: Duration.zero,
          progressDuration: Duration.zero,
          episodeId: widget.episode.id,
          playerState: PlayerState.init,
        );
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Slider(
            value: _value,
            // Use this for buffering..
            secondaryTrackValue: progress.percentBuffered,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatDurationHHMMSS(
                  progress.calculateProgressDuration(_value),
                ),
              ),
              Text(
                formatDurationHHMMSS(
                  progress.calculateRemainingDuration(_value),
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
    var userListen = authUser.listenApi.get(episode.id);
    if (userListen == null) return;
    _log.info('found user listen ${episode.title}');
    _duration = episode.duration - Duration(seconds: userListen.seconds);
    _status = PlayIconNotifierStatus.listened;
    if (userListen.completed) {
      _status = PlayIconNotifierStatus.finished;
    }

    if (playerApi.getPlayingEpisode() == episode) {
      listen();
    }
    // playerApi.addListener(listener)
  }
  final PlayerApi playerApi;
  final Episode episode;
  final AuthUser authUser;
  PlayIconNotifierStatus _status = PlayIconNotifierStatus.init;
  PlayIconNotifierStatus get status => _status;
  Duration _duration = Duration.zero;
  Duration get duration => _duration;
  StreamSubscription<PlayerProgress>? _progressStream;
  PlayerState _playerState = PlayerState.init;
  PlayerState get playerState => _playerState;

  void _onProgress(PlayerProgress progress) {
    if (progress.duration == null) return;
    _playerState = progress.playerState;
    _status = PlayIconNotifierStatus.listening;
    _duration =
        progress.duration != null
            ? progress.duration! - (progress.progressDuration)
            : Duration.zero;
    if (progress.completed) {
      _status = PlayIconNotifierStatus.finished;
    }
    notifyListeners();
  }

  void listen() {
    _progressStream = playerApi
        .subscribeToEpisodeProgress(episode.id)
        .listen(_onProgress);
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
    // var currentEpisode = playerApi.getPlayingEpisode();
    // if (currentEpisode != null && episode.id == currentEpisode.id) {
    //   return;
    // }
    if (await playerApi.load(episode)) {
      await playerApi.play();
      notifier.listen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: notifier,
      builder: (context, _) {
        return InkWell(
          onTap: _onPressed,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Theme.of(context).dividerColor,
                // color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: BorderRadius.circular(50.0),
            ),
            // width: 100,
            constraints: BoxConstraints(minWidth: 100),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Bit lazy, but icon button here just keep the
                  // sizing and padding equal with the other buttons
                  Icon(
                    Icons.play_circle_outline,
                    color: Theme.of(context).colorScheme.primary,
                  ),

                  Text(_durationText()),
                  // Text('${notifier.status}'),
                  // Text('${notifier.playerState}'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _durationText() {
    String postfix = '';
    String duration = formatDuration(notifier.duration);
    switch (notifier.status) {
      case PlayIconNotifierStatus.init:
        break;
      case PlayIconNotifierStatus.listened:
      case PlayIconNotifierStatus.listening:
        postfix = ' left';
      case PlayIconNotifierStatus.finished:
        duration = 'completed';
    }
    return '$duration$postfix';
  }
}
