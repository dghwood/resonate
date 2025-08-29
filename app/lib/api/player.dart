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

  void _setupListenLogging(Episode episode) {
    var prevSeconds = 0;
    progressStream
        .where((progress) {
          var currentSeconds = progress.progressDuration!.inSeconds;
          // Every 5 seconds, which seems like a lot?
          // This is also going to bubble up a lot..
          if ((currentSeconds - prevSeconds).abs() > 5) {
            prevSeconds = currentSeconds;
            return true;
          }
          return false;
        })
        .listen((progress) {
          // This gets cancelled when the playback changes
          // TODO(duncanwood): This probably gets called too often
          _log.info('adding listen');
          _authUser?.listenApi.add(episode.id, progress);
        });
  }

  Future<bool> load(Episode episode) async {
    // Implements equals in Episode class
    if (_currentEpisode?.id == episode.id) {
      return true;
    }

    _currentEpisode = episode;
    await _playerService.load(episode);
    _playerService.play();
    _setupListenLogging(episode);
    return true;
  }

  PlayerState get state => _playerService.state;
  void play() => _playerService.play();
  void pause() => _playerService.pause();
  void stop() => _playerService.stop();
}
