// Should I move this to the player service directory?
import 'package:logging/logging.dart';
import 'package:resonate/api/episode.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/errors/errors.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/storage/playlist.dart';

final Logger _log = Logger('/api/playlist');

class PlaylistApi {
  PlaylistApi({
    required AbstractDatabaseService databaseService,
    required GetEpisodeApi episodeApi,
  }) : _episodeApi = episodeApi,
       _playlistDatabase = PlaylistDatabase(databaseService);

  final PlaylistDatabase _playlistDatabase;
  final GetEpisodeApi _episodeApi;

  late Playlist _playlist;
  final String _playlistId = 'default';

  final Map<String, Episode> _episodeCache = {};

  // For recommended episodes..
  // TODO(duncan): Implement this..
  final List<Episode> _autoEpisodes = [];

  Future<ApiResult<bool>> init() async {
    _playlist = Playlist(id: _playlistId);
    try {
      await _playlistDatabase.get(_playlist);
    } on DatabaseNotFoundException catch (_) {
      return ApiResult.ok(true);
    } on Exception catch (e) {
      return ApiResult.error(e);
    }

    // Get the episodes into memory
    if (_playlist.upNextEpisodeIds.isEmpty &&
        _playlist.playingEpisodeId == null) {
      // Empty playlist
      return ApiResult.ok(true);
    }

    var episodeIds =
        _playlist.upNextEpisodeIds.toList() +
        (_playlist.playingEpisodeId != null
            ? [_playlist.playingEpisodeId!]
            : []);

    var result = await _episodeApi.getMany(episodeIds);
    switch (result) {
      case ApiOk():
        break;
      case ApiError():
        return ApiResult.error(result.error);
    }
    var episodes = result.value;
    for (var episode in episodes) {
      _episodeCache[episode.id] = episode;
    }
    return ApiResult.ok(true);
  }

  Episode? get playing =>
      _playlist.playingEpisodeId != null
          ? _episodeCache[_playlist.playingEpisodeId]
          : null;

  Future<void> setPlaying(Episode episode) async {
    _log.info('setting playlist ${episode.title}');
    // add to cache
    _episodeCache[episode.id] = episode;
    _playlist.setPlayingEpisodeId(episode.id);
    _save();
  }

  Future<void> _save() async {
    try {
      _playlistDatabase.put(_playlist);
    } on Exception catch (e) {
      _log.warning(e);
    }
  }

  Future<Iterable<Episode>> list() async {
    // Note: this just assumes the cache is complete.
    return _playlist.upNextEpisodeIds.map(
      (id) => _episodeCache[id] ?? Episode(id: id),
    );
  }

  Future<void> next(Episode episode) async {
    _playlist.addNext(episode);
    await _save();
  }

  Future<void> add(Episode episode) async {
    _playlist.add(episode);
    await _save();
  }

  Future<void> remove(Episode episode) async {
    _playlist.remove(episode);
  }

  Future<void> replace(Episode fromEpisode, Episode? toEpisode) async {
    await remove(fromEpisode);
    if (toEpisode == null) return;
    await next(toEpisode);
  }

  Future<void> clear() async {
    _playlist.clear();
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    _playlist.reorder(oldIndex, newIndex);
    await _save();
  }

  bool has(Episode episode) {
    return _playlist.has(episode);
  }

  bool get hasNext => _playlist.upNextEpisodeIds.isNotEmpty;
  Future<Episode?> get pop async {
    var episodeId = _playlist.pop;
    await _save();
    return _episodeCache[episodeId];
  }
}
