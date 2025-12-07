import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/playlist.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/storage/playlist.dart';

import 'package:resonate/services/player.dart';

Logger _log = Logger('api/player');

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

  Episode? getPlayingEpisode() => _playlistApi.playing;
  Stream<PlayerProgress> get progressStream => _playerService.streamProgress();

  void _setupListenLogging(Episode episode) {
    progressStream.listen((progress) {
      _authUser?.listenApi.add(episode, progress, server: false);
    });
  }

  Future<bool> load(Episode episode) async {
    if (getPlayingEpisode() == episode) {
      return true;
    }

    // Check for listens..
    var listen = _authUser?.listenApi.get(episode.id);
    var startDuration =
        listen != null ? Duration(seconds: listen.seconds) : null;

    // When should I do this?
    await _playlistApi.setPlaying(episode);
    _playlistApi.setPlaying(episode);

    await _playerService.load(episode, startDuration: startDuration);
    // Don't wait..
    _playerService.play();
    _setupListenLogging(episode);

    return true;
  }

  PlayerState get state => _playerService.state;

  void _logProgress() {
    if (getPlayingEpisode() == null) return;
    // This will hit the server
    _authUser?.listenApi.add(getPlayingEpisode()!, _playerService.progress);
  }

  Future<void> play() async {
    _log.info('play');
    // Don't await, since it holds until playback stops..
    _playerService.play();
    _logProgress();
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
    if (currentDuration == null) return;
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
