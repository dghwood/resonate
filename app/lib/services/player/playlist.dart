import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/episode.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/errors/errors.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/services/player/util.dart';
import 'package:resonate/storage/playlist.dart';

Logger _log = Logger('services/player/playlist');

class AudioHandlerServicePlaylist extends ChangeNotifier {
  AudioHandlerServicePlaylist({
    required AudioPlayer player,
    required AbstractDatabaseService databaseService,
    required GetEpisodeApi episodeApi,
  }) : _player = player,
       _episodeApi = episodeApi,
       _playlistDatabase = Playlist2Database(databaseService) {
    _player.currentIndexStream.distinct().listen(onIndexChange);
  }
  final AudioPlayer _player;
  final Playlist2Database _playlistDatabase;
  final GetEpisodeApi _episodeApi;

  // I need to notify when the episode changes
  void onIndexChange(_) {
    notifyListeners();
  }

  // Which episode is playing
  int get index => _player.currentIndex ?? 0;

  Episode? get episode => _episodes.isEmpty ? null : _episodes[index];

  final List<Episode> _episodes = [];
  List<Episode> get episodes => _episodes;

  final String _playlistId = 'default';
  Future<void> init() async {
    var playlist = Playlist2(id: _playlistId);
    try {
      await _playlistDatabase.get(playlist);
    } on DatabaseNotFoundException catch (_) {
      // All good
    } on Exception catch (e) {
      // Not great
      rethrow;
    }
    if (playlist.episodeIds.isNotEmpty) {
      var result = await _episodeApi.getMany(playlist.episodeIds);
      switch (result) {
        case ApiOk():
          _episodes.addAll(result.value);
        case ApiError():
          _log.warning(result.error);
          break;
      }
    }
    await _player.setAudioSources(
      _episodes.map(toAudioSource).toList(),
      preload: false,
    );
    notifyListeners();
  }

  Future<void> _save(Episode? addedEpisode) async {
    var playlist = Playlist2(
      id: _playlistId,
      episodeIds: episodes.skip(index).map((e) => e.id),
      episodeIndex: 0,
    );
    if (addedEpisode != null) {
      if (!await _episodeApi.put(addedEpisode)) {
        _log.warning("Episode not saved, skipping playlist save");
        return;
      }
    }
    try {
      await _playlistDatabase.put(playlist);
    } on Exception catch (e) {
      _log.warning(e);
    }
  }

  bool has(Episode episode) => _episodes.contains(episode);

  Future<void> add(Episode episode) async {
    // Should this reorder?
    if (_episodes.contains(episode)) return;
    _episodes.add(episode);
    await _player.addAudioSource(toAudioSource(episode));
    await _save(episode);
    notifyListeners();
  }

  Future<void> remove(Episode episode) async {
    var index = _episodes.indexOf(episode);
    if (index == -1) return;
    _episodes.removeAt(index);
    await _player.removeAudioSourceAt(index);
    await _save(null);
    notifyListeners();
  }

  Future<void> play(Episode episode) async {
    var i = _episodes.indexOf(episode);
    var currentIndex = index;
    if (i == currentIndex) {
      // Episode currently playing
      return;
    }
    if (i == -1) {
      // add to playlist
      _episodes.insert(currentIndex, episode);
      await _player.insertAudioSource(0, toAudioSource(episode));
    } else {
      await reorder(i, currentIndex);
    }
    if (_player.playing) {
      // If the player is already playing you need to seek
      await _player.seek(Duration.zero, index: currentIndex);
    } else {
      // But that doesn't work if the player is not playing
      await _player.play();
    }
    await _save(episode);
    notifyListeners();
  }

  Future<void> addNext(Episode episode) async {
    var currentIndex = _episodes.indexOf(episode);
    if (currentIndex != -1) {
      await reorder(currentIndex, index);
    }
    var i = _episodes.isEmpty ? 0 : index + 1;
    _episodes.insert(i, episode);
    await _player.insertAudioSource(i, toAudioSource(episode));
    await _save(episode);
    notifyListeners();
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    if (oldIndex == newIndex) return;
    var episode = _episodes.removeAt(oldIndex);
    _episodes.insert(newIndex, episode);
    await _player.moveAudioSource(oldIndex, newIndex);
    await _save(null);
    notifyListeners();
  }
}
