import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/models/models.dart';

import 'package:resonate/services/player.dart';

Logger _log = Logger('api/player');

// Should I move this to the player service directory?
class PlaylistApi {
  PlaylistApi();

  final List<Episode> _episodes = [];

  Future<Iterable<Episode>> list() async {
    return _episodes;
  }

  // For recommended episodes..
  // TODO(duncan): Implement this..
  final List<Episode> _autoEpisodes = [];

  Future<void> next(Episode episode) async {
    _episodes.insert(0, episode);
  }

  Future<void> add(Episode episode) async {
    _episodes.add(episode);
  }

  Future<void> remove(Episode episode) async {
    _episodes.remove(episode);
  }

  Future<void> clear() async {
    _episodes.clear();
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    var item = _episodes.removeAt(oldIndex);
    _episodes.insert(newIndex, item);
  }

  bool has(Episode episode) {
    return _episodes.any((e) => e == episode);
  }

  bool get hasNext => _episodes.isNotEmpty;
  Future<Episode> get pop async {
    return _episodes.removeAt(0);
  }
}

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
    _log.info('$state');
    switch (state) {
      case PlayerState.finished:
        // When the episode is finished load the next episode
        if (!_playlistApi.hasNext) break;
        _playlistApi.pop.then((e) => load(e));
      default:
        break;
    }
    notifyListeners();
  }

  final AbstractPlayerService _playerService;
  final AuthUser? _authUser;
  final PlaylistApi _playlistApi;
  PlaylistApi get playlistApi => _playlistApi;

  Episode? _currentEpisode;

  Episode? get episode => _currentEpisode;
  Stream<PlayerProgress> get progressStream => _playerService.streamProgress();

  void _setupListenLogging(Episode episode) {
    progressStream.listen((progress) {
      _authUser?.listenApi.add(episode, progress, server: false);
    });
  }

  Future<bool> load(Episode episode) async {
    _log.info('load::${episode.id}::${episode.audioUrl}');
    // Implements equals in Episode class
    if (_currentEpisode?.id == episode.id) {
      return true;
    }

    _currentEpisode = episode;
    // Check for listens..
    var listen = _authUser?.listenApi.get(episode.id);
    var startDuration =
        listen != null ? Duration(seconds: listen.seconds) : null;

    await _playerService.load(episode, startDuration: startDuration);
    // Don't wait..
    _playerService.play();
    _setupListenLogging(episode);
    return true;
  }

  PlayerState get state => _playerService.state;

  void _logProgress() {
    if (_currentEpisode == null) return;
    // This will hit the server
    _authUser?.listenApi.add(_currentEpisode!, _playerService.progress);
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
