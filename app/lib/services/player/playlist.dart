import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:resonate/mock_http.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/services/player/util.dart';

class AudioHandlerServicePlaylist extends ChangeNotifier {
  AudioHandlerServicePlaylist(this._player);
  final AudioPlayer _player;

  // Which episode is playing
  int get index => _player.currentIndex ?? 0;

  Episode? get episode => _episodes.isEmpty ? null : _episodes[index];

  final List<Episode> _episodes = [];
  List<Episode> get episodes => _episodes;

  Future<void> init() async {
    _episodes.addAll([
      // These would be loaded from the db.
      // Episode.fromMessage(mockEpisodeMessage(id: '0')),
      // Episode.fromMessage(mockEpisodeMessage(id: '1')),
      // Episode.fromMessage(mockEpisodeMessage(id: '2')),
    ]);
    await _player.setAudioSources(
      _episodes.map(toAudioSource).toList(),
      preload: false,
    );
    notifyListeners();
  }

  bool has(Episode episode) => _episodes.contains(episode);

  Future<void> add(Episode episode) async {
    // Should this reorder?
    if (_episodes.contains(episode)) return;
    _episodes.add(episode);
    await _player.addAudioSource(toAudioSource(episode));
    notifyListeners();
  }

  Future<void> remove(Episode episode) async {
    var index = _episodes.indexOf(episode);
    if (index == -1) return;
    _episodes.removeAt(index);
    await _player.removeAudioSourceAt(index);
    notifyListeners();
  }

  Future<void> play(Episode episode) async {
    var i = _episodes.indexOf(episode);
    if (i == -1) {
      // add to playlist
      _episodes.insert(index, episode);
      await _player.insertAudioSource(0, toAudioSource(episode));
    } else {
      await reorder(i, index);
    }
    await _player.play();
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
    notifyListeners();
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    if (oldIndex == newIndex) return;
    var episode = _episodes.removeAt(oldIndex);
    _episodes.insert(newIndex, episode);
    await _player.moveAudioSource(oldIndex, newIndex);
    notifyListeners();
  }
}
