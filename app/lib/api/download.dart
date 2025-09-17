import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/episode.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/services/download.dart';
import 'package:resonate/storage/download.dart';

Logger _log = Logger('api/download');

class DownloadApi {
  DownloadApi({
    required AuthUser authUser,
    required AbstractDatabaseService databaseService,
  }) : _authUser = authUser,
       _downloadManager = DownloadManager(),
       _downloadDatabase = DownloadDatabase(databaseService);

  final AuthUser _authUser;
  final DownloadManager _downloadManager;
  final DownloadDatabase _downloadDatabase;

  final Map<String, UserDownload> _downloads = {};

  Future<void> init() async {
    var result = await sync();
    switch (result) {
      case ApiOk():
        var downloads = result.value;
        _downloads.clear();

        for (final download in downloads) {
          _downloads[download.episodeId] = download;
        }
      case ApiError():
        _log.warning('Failed to load downloads: ${result.error}');
    }
  }

  UserDownload? get(String episodeId) => _downloads[episodeId];

  Future<ApiResult<Iterable<UserDownload>>> list() async {
    // I need to check with the server
    try {
      var result = await _downloadDatabase.list();
      return ApiResult.ok(result);
    } on Exception catch (e) {
      _log.info('Failed to initialize download database: $e');
      return ApiResult.error(e);
    }
  }

  Future<ApiResult<Iterable<UserDownload>>> sync() async {
    return await list();
  }

  UserDownload _createUserDownload(
    String episodeId,
    String filePath, {
    DownloadItem? downloadItem,
  }) {
    return UserDownload(
      id: episodeId,
      episodeId: episodeId,
      filePath: filePath,
      metadata: StorageMetadata.now(),
      downloadItem: downloadItem,
    );
  }

  // download
  //
  // I went back and forth on this..
  // basically until the episode is downloaded, it doesn't need to be in
  // the database .
  //
  // We can just hold it in memory i think
  // especially since the download can be cancelled
  Future<ApiResult<DownloadItem>> download(Episode episode) async {
    var episodeId = episode.id;
    if (_downloads.containsKey(episodeId)) {
      return ApiResult.error(Exception('Already downloading'));
    }
    var filePath = '/episode-downloads/${episode.id}';
    var download = _createUserDownload(episodeId, filePath);

    // Download & Sync to database
    var item = _downloadManager.add(
      url: Uri.parse(episode.audioUrl),
      filePath: 'someFilePath',
      onDone: () async {
        download.isDownloaded = true;
        await _downloadDatabase.put(download);
      },
      onCancel: () async {
        _downloads.remove(episodeId);
      },
    );
    download.downloadItem = item;
    _downloads[episodeId] = download;
    return ApiResult.ok(item);
  }

  Future<ApiResult<bool>> delete(String episodeId) async {
    if (!_downloads.containsKey(episodeId)) {
      return ApiResult.ok(true);
    }

    var download = UserDownload.copy(_downloads[episodeId]!);
    download.metadata.markDeleted();

    // Update the database
    try {
      await _downloadDatabase.put(download);
    } on Exception catch (e) {
      _log.severe('Failed to remove download from database: $e');
      return ApiResult.error(e);
    }

    // Update the local cache
    _downloads.remove(episodeId);
    return ApiResult.ok(true);
  }
}

class DownloadsApi {
  const DownloadsApi({
    required AuthUser authUser,
    required DownloadApi downloadApi,
    required GetEpisodeApi episodeApi,
  }) : _authUser = authUser,
       _downloadApi = downloadApi,
       _episodeApi = episodeApi;

  final AuthUser _authUser;
  final GetEpisodeApi _episodeApi;
  final DownloadApi _downloadApi;

  Future<ApiResult<Iterable<Episode>>> get() async {
    var result = await _downloadApi.list();

    switch (result) {
      case ApiOk():
        break;
      case ApiError():
        return ApiResult.error(result.error);
    }

    var downloads = result.value;
    var episodeIds = downloads.map((s) => s.episodeId);
    var episodeResult = await _episodeApi.getMany(episodeIds);

    switch (episodeResult) {
      case ApiOk():
        break;
      case ApiError():
        return ApiResult.error(episodeResult.error);
    }

    return ApiResult.ok(episodeResult.value);
  }
}
