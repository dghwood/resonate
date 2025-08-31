import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/models/models.dart';

import 'package:resonate/services/player.dart';

Logger _log = Logger('api/player');

class PlayerApi extends ChangeNotifier {
  PlayerApi({
    required AbstractPlayerService playerService,
    required AuthUser authUser,
  }) : _playerService = playerService,
       _authUser = authUser {
    _playerService.streamState().listen((state) {
      // Update when the state stream changes..
      _log.info('$state');
      notifyListeners();
    });
  }

  final AbstractPlayerService _playerService;
  final AuthUser? _authUser;

  Episode? _currentEpisode;

  Episode? get episode => _currentEpisode;
  Stream<PlayerProgress> get progressStream => _playerService.streamProgress();

  // Implement a queue for adding listens..
  Map<String, List<PlayerProgress>> _addQueue = {};
  void _queueAdd(String episodeId, PlayerProgress progress) {
    if (!_addQueue.containsKey(episodeId)) {
      _addQueue[episodeId] = [];
    }
    _addQueue[episodeId]?.add(progress);
  }

  void _queuePop(String episodeId) async {
    if (!_addQueue.containsKey(episodeId)) return;
    var queue = _addQueue[episodeId]!;
    var progress = queue.last;
    _addQueue.remove(episodeId);
    await _authUser?.listenApi.add(episodeId, progress);
  }

  void _setupListenLogging(Episode episode) {
    progressStream.listen((progress) {
      _authUser?.listenApi.add(episode.id, progress, server: false);
    });
  }

  Future<bool> load(Episode episode) async {
    // Implements equals in Episode class
    if (_currentEpisode?.id == episode.id) {
      return true;
    }

    _currentEpisode = episode;
    await _playerService.load(episode);

    // Check for listens..
    var listen = _authUser?.listenApi.get(episode.id);
    if (listen != null) {
      seek(Duration(seconds: listen.seconds));
    }

    await _playerService.play();
    _setupListenLogging(episode);
    return true;
  }

  PlayerState get state => _playerService.state;

  void _logProgress() {
    if (_currentEpisode == null) return;
    // This will hit the server
    _authUser?.listenApi.add(_currentEpisode!.id, _playerService.progress);
  }

  Future<void> play() async {
    await _playerService.play();
    _logProgress();
  }

  Future<void> pause() async {
    await _playerService.pause();
    _logProgress();
  }

  Future<void> stop() async {
    await _playerService.stop();
    _logProgress();
  }

  Future<void> seek(Duration duration) async {
    await _playerService.seek(duration);
    _logProgress();
  }
}
