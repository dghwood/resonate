import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/listens.dart';
import 'package:resonate/api/settings.dart';
import 'package:resonate/components/common/player/play_icon.dart';
import 'package:resonate/components/common/player/playlist.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/services/player/audio_handler.dart';
import 'package:resonate/utils/constants.dart';
import 'package:resonate/utils/time.dart';

Logger _log = Logger('components/common/player');

class PlayerComponentAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  const PlayerComponentAppBar({super.key, required this.controller});

  final PageController controller;
  // Mandatory for PreferredSizeWidget
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<PlayerComponentAppBar> createState() => _PlayerComponentAppBarState();
}

class _PlayerComponentAppBarState extends State<PlayerComponentAppBar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(onPageController);
  }

  @override
  void dispose() {
    widget.controller.removeListener(onPageController);
    super.dispose();
  }

  int _pageIndex = 0;
  void onPageController() {
    setState(() {
      var page = widget.controller.page;
      if (page != null) {
        _pageIndex = page.round();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        _pageIndex == 0 ? 'NOW PLAYING' : 'PLAYLIST',
        style: Theme.of(context).textTheme.labelMedium,
      ),
      leading: SizedBox(),
      actions: [
        IconButton(
          icon: Icon(Icons.play_circle),
          onPressed:
              _pageIndex == 0
                  ? null
                  : () {
                    widget.controller.animateToPage(
                      0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.linear,
                    );
                  },
        ),
        if (ENABLE_PLAYLIST)
          IconButton(
            icon: Icon(Icons.playlist_play),
            onPressed:
                _pageIndex == 1
                    ? null
                    : () {
                      widget.controller.animateToPage(
                        1,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.linear,
                      );
                    },
          ),
      ],
    );
  }
}

class PlayerComponentPage extends StatelessWidget {
  const PlayerComponentPage({super.key, required this.playerApi});

  final AudioHandlerService playerApi;

  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    return Scaffold(
      appBar: PlayerComponentAppBar(controller: controller),
      // body: PlayerComponent(playerApi: playerApi),
      body: PageView(
        controller: controller,
        onPageChanged: (newIndex) {},
        children: [
          PlayerComponent(playerApi: playerApi),
          if (ENABLE_PLAYLIST) PlaylistComponent(playerApi: playerApi),
        ],
      ),
    );
  }

  static void show(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return PlayerComponentPage(playerApi: AudioHandlerService.instance);
      },
    );
  }
}

class PlayerComponent extends StatelessWidget {
  const PlayerComponent({
    super.key,
    // required this.controller,
    required AudioHandlerService playerApi,
  }) : _playerApi = playerApi;

  final AudioHandlerService _playerApi;
  // final PageController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      // This needs to rebuild when the episode changes
      listenable: _playerApi.playlist,
      builder: (context, _) {
        var episode = _playerApi.playlist.episode;
        if (episode == null) {
          return Text('No Episode');
        }
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
                        _playerApi.seekRelative(Duration(seconds: -10));
                      },
                    ),
                    PlayButtonComponent(playerApi: _playerApi, size: 64),
                    IconButton(
                      iconSize: 32,
                      icon: Icon(Icons.forward_30),
                      onPressed: () {
                        _playerApi.seekRelative(Duration(seconds: 30));
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

  // static void show(BuildContext context) {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     showDragHandle: true,
  //     context: context,
  //     builder: (context) {
  //       return PlayerComponent(playerApi: AudioHandlerService.instance);
  //     },
  //   );
  // }
}

/* PlayerSliderComponent 

  This tracks the audio duration & buffering and updates a 
  slider to enable seek. 
*/
class PlayerSliderComponent extends StatefulWidget {
  const PlayerSliderComponent({
    super.key,
    required AudioHandlerService playerApi,
    required this.episode,
  }) : _playerApi = playerApi;

  final AudioHandlerService _playerApi;
  final Episode episode;

  @override
  State<PlayerSliderComponent> createState() => _PlayerSliderComponentState();
}

class _PlayerSliderComponentState extends State<PlayerSliderComponent> {
  late AudioHandlerServiceState _playerProgress;
  StreamSubscription<AudioHandlerServiceState>? _progressSubscription;
  // Value displayed to the user
  double _value = 0.0;

  @override
  void initState() {
    super.initState();
    _playerProgress = widget._playerApi.state;
    _progressSubscription = widget._playerApi.positionStream.listen((state) {
      setState(() {
        _playerProgress = state;
        _value = state.episodeState?.percentProgress ?? 0.0;
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
    var progress = _playerProgress.episodeState;
    if (progress == null) return Container();
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
                var newDuration = progress.calculateProgressDuration(_value);
                widget._playerApi.seek(newDuration).then((_) {
                  _progressSubscription?.resume();
                });
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
    required this.listenApi,
    required this.authUser,
  }) {
    _duration = episode.duration;
    var userListen = listenApi.get(episode.id);
    if (userListen == null) return;
    _log.info('found user listen ${episode.title}');
    _duration = episode.duration - Duration(seconds: userListen.seconds);
    _status = PlayIconNotifierStatus.listened;
    if (userListen.completed) {
      _status = PlayIconNotifierStatus.finished;
    }

    if (playerApi.playlist.episode == episode) {
      listen();
    }
    // playerApi.addListener(listener)
  }
  final AudioHandlerService playerApi;
  final Episode episode;
  final ListenApi listenApi;
  final AuthUser authUser;
  PlayIconNotifierStatus _status = PlayIconNotifierStatus.init;
  PlayIconNotifierStatus get status => _status;
  Duration _duration = Duration.zero;
  Duration get duration => _duration;
  StreamSubscription<AudioHandlerServiceState>? _progressStream;
  PlayerState _playerState = PlayerState.init;
  PlayerState get playerState => _playerState;

  void _onProgress(AudioHandlerServiceState state) {
    var progress = state.episodeState;
    if (progress == null) return;
    _playerState = state.playerState;
    _status = PlayIconNotifierStatus.listening;
    _duration = progress.remainingDuration;
    if (state.playerState == PlayerState.finished) {
      _status = PlayIconNotifierStatus.finished;
    }
    notifyListeners();
  }

  void listen() {
    _progressStream = playerApi.positionStream.listen(_onProgress);
  }

  @override
  void dispose() {
    _progressStream?.cancel();
    super.dispose();
  }
}

/* PlayIconComponent 

  Mainly used on EpisodeComponent to play the episode
*/
class PlayIconComponent extends StatelessWidget {
  PlayIconComponent({
    super.key,
    required this.playerApi,
    required this.episode,
    required this.listenApi,
    required this.authUser,
  }) {
    notifier = PlayIconNotifier(
      playerApi: playerApi,
      episode: episode,
      authUser: authUser,
      listenApi: listenApi,
    );
  }

  final ListenApi listenApi;
  final AudioHandlerService playerApi;
  final Episode episode;
  final AuthUser authUser;
  late final PlayIconNotifier notifier;

  void _onPressed() async {
    await playerApi.playlist.play(episode);
    notifier.listen();
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
