import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/models/playlist.dart';
import 'package:resonate/storage/playlist_storage.dart';

import 'package:resonate/services/player.dart';

Logger _log = Logger('api/player');

// Should I move this to the player service directory?
class PlaylistApi {
  final PlaylistDatabase _playlistDb;
  late Playlist _playlist;
  final String _playlistId = 'default_playlist';
  bool _isInitialized = false;

  PlaylistApi(this._playlistDb);

  Future<void> init() async {
    if (_isInitialized) return;
    try {
      _playlist = Playlist(id: _playlistId);
      await _playlistDb.get(_playlist);
    } catch (e) {
      _playlist = Playlist(id: _playlistId);
      await _playlistDb.put(_playlist);
    }
    _isInitialized = true;
  }

  Future<void> _save() => _playlistDb.put(_playlist);

  Episode? get playingNow => _playlist.playingNow;

  Future<Iterable<Episode>> list() async {
    await init();
    return _playlist.upNext;
  }

  Future<void> setPlaying(Episode episode) async {
    await init();
    _playlist.toMessage().playingNow = episode.toMessage();
    // Remove the episode from the up next list if it exists
    _playlist.toMessage().upNext.removeWhere((e) => e.id == episode.id);
    await _save();
  }

  Future<void> add(Episode episode) async {
    await init();
    if (has(episode)) return;
    _playlist.toMessage().upNext.add(episode.toMessage());
    await _save();
  }

  Future<void> next(Episode episode) async {
    await init();
    _playlist.toMessage().upNext.removeWhere((e) => e.id == episode.id);
    _playlist.toMessage().upNext.insert(0, episode.toMessage());
    await _save();
  }

  Future<void> remove(Episode episode) async {
    await init();
    _playlist.toMessage().upNext.removeWhere((e) => e.id == episode.id);
    if (_playlist.playingNow?.id == episode.id) {
      _playlist.toMessage().clearPlayingNow();
    }
    await _save();
  }

  Future<void> clear() async {
    await init();
    _playlist.toMessage().upNext.clear();
    await _save();
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    await init();
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    var item = _playlist.toMessage().upNext.removeAt(oldIndex);
    _playlist.toMessage().upNext.insert(newIndex, item);
    await _save();
  }

  bool has(Episode episode) {
    return _playlist.upNext.any((e) => e.id == episode.id) ||
        _playlist.playingNow?.id == episode.id;
  }

  bool get hasNext => _playlist.upNext.isNotEmpty;

  Future<Episode?> get getNext async {
    await init();
    return _playlist.upNext.isNotEmpty ? _playlist.upNext.first : null;
  }
}

class PlayerApi extends ChangeNotifier {
  PlayerApi({
    required AbstractPlayerService playerService,
    required PlaylistApi playlistApi,
    required AuthUser authUser,
  })  : _playerService = playerService,
        _authUser = authUser,
        _playlistApi = playlistApi {
    _playerService.streamState().listen(_onStateChange);
  }

  void _onStateChange(PlayerState state) {
    _log.info('$state');
    switch (state) {
      case PlayerState.finished:
        // When the episode is finished load the next episode
        _playlistApi.getNext.then((episode) {
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

    await _playlistApi.setPlaying(episode);
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
