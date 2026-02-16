import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/playlist.dart';
import 'package:resonate/models/models.dart';

import 'package:resonate/services/player/player.dart';

Logger _log = Logger('api/player');

enum PlayerLoadingState { init, loading, complete }

// State of the player
enum PlayerApiState { init, resumable, playing, loading, paused, finished }

class PlayerApi extends ChangeNotifier {
  PlayerApi({
    required AbstractPlayerService playerService,
    required PlaylistApi playlistApi,
    required AuthUser authUser,
  }) : _playerService = playerService,
       _authUser = authUser,
       _playlistApi = playlistApi {
    _playerService.streamState().listen(_onStateChange);
  }

  void _onStateChange(PlayerState state) {
    switch (state) {
      case PlayerState.finished:
        // When the episode is finished load the next episode
        _playlistApi.pop.then((episode) {
          if (episode != null) {
            load(episode);
          }
        });
        break;
      default:
        break;
    }
    notifyListeners();
  }

  final AbstractPlayerService _playerService;
  final AuthUser? _authUser;
  final PlaylistApi _playlistApi;
  PlaylistApi get playlistApi => _playlistApi;

  PlayerApiState get state {
    switch (_playerService.state) {
      case PlayerState.init:
        if (getPlayingEpisode() != null) {
          return PlayerApiState.resumable;
        }
        return PlayerApiState.init;
      case PlayerState.playing:
        return PlayerApiState.playing;
      case PlayerState.loading:
        return PlayerApiState.loading;
      case PlayerState.paused:
        return PlayerApiState.paused;
      case PlayerState.finished:
        return PlayerApiState.finished;
    }
  }

  Episode? getPlayingEpisode() => _playlistApi.playing;
  // This is kinda special since it gets killed when i new episode plays.
  Stream<PlayerProgress> get progressStream => _playerService.streamProgress();
  Stream<PlayerProgress> subscribeToEpisodeProgress(String episodeId) {
    return _playerService.streamProgress().where(
      (e) => e.episodeId == episodeId,
    );
  }

  StreamSubscription<PlayerProgress>? _listenSubscription;
  void _setupListenLogging(Episode episode) {
    // Feels like i could do more more cleverly
    // like check if it not null || cancelled?
    _listenSubscription?.cancel();
    _listenSubscription = subscribeToEpisodeProgress(episode.id).listen((
      progress,
    ) {
      // _log.info('adding::listen::${episode.title}::${DateTime.now().second}');
      _authUser?.listenApi.add(episode, progress, server: false);
    });
  }

  PlayerLoadingState _loadingState = PlayerLoadingState.init;
  Future<bool> load(Episode episode) async {
    if (getPlayingEpisode() == episode &&
        _loadingState != PlayerLoadingState.init) {
      return _loadingState == PlayerLoadingState.complete;
    }
    _loadingState = PlayerLoadingState.loading;
    // Check for listens..
    var listen = _authUser?.listenApi.get(episode.id);
    var startDuration =
        listen != null ? Duration(seconds: listen.seconds) : null;

    // When should I do this?
    await _playlistApi.setPlaying(episode);
    _playlistApi.setPlaying(episode);

    await _playerService.load(episode, startDuration: startDuration);
    _loadingState = PlayerLoadingState.complete;
    // Don't wait..
    // _playerService.play();
    // _setupListenLogging(episode);

    return true;
  }

  void _logProgress() {
    if (getPlayingEpisode() == null) return;
    // This will hit the server
    _authUser?.listenApi.add(getPlayingEpisode()!, _playerService.progress);
  }

  Future<void> play() async {
    var episode = getPlayingEpisode();
    if (episode == null) return;
    _log.info('play::$_loadingState');
    if (!await load(episode)) return;
    // Don't await, since it holds until playback stops..
    _playerService.play();
    _logProgress();
    _setupListenLogging(episode);
  }

  Future<void> pause() async {
    _log.info('pause');
    await _playerService.pause();
    _logProgress();
  }

  Future<void> stop() async {
    _log.info('stop');
    await _playerService.stop();
    _logProgress();
  }

  Future<void> seek(Duration duration) async {
    _log.info('seek');
    await _playerService.seek(duration);
    _logProgress();
  }

  Future<void> forward(Duration duration) async {
    _log.info('forward');
    var currentDuration = _playerService.progress.progressDuration;
    await seek(currentDuration + duration);
  }

  Future<void> seekProportional(double percent) async {
    var duration = _playerService.progress.duration!;
    var newDurationMs = duration.inMilliseconds * percent;
    await _playerService.seek(Duration(milliseconds: newDurationMs.toInt()));
  }

  @override
  void dispose() {
    _playerService.dispose();
    super.dispose();
  }
}
