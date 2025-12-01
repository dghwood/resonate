import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/services/file.dart';
import 'package:http/http.dart' as http;

Logger _log = Logger('services/download');

enum DownloadItemStatus { queued, downloading, canceled, error, done }

class DownloadItem extends ChangeNotifier {
  DownloadItem({
    required this.url,
    required this.filePath,
    required this.onDone,
    required this.onCancel,
    required AbstractDatabaseService databaseService,
  }) : _databaseService = databaseService;

  final Uri url;
  final String filePath;
  final AbstractDatabaseService _databaseService;
  final Future<void> Function() onDone;
  final Future<void> Function() onCancel;

  DownloadItemStatus _status = DownloadItemStatus.queued;
  DownloadItemStatus get status => _status;

  double _progress = 0;
  double get progress => _progress;

  ApiResult<bool>? _result;
  // Only call when done
  ApiResult<bool> get result => _result!;

  AbstractFile _file(String filePath) {
    if (kIsWeb) {
      return IndexDbFile(filePath, _databaseService);
    } else {
      return FilesystemFile(filePath);
    }
  }

  void download() async {
    _log.info('download');
    _status = DownloadItemStatus.downloading;
    try {
      final file = _file(filePath);
      _log.info('requesting $url');
      final request = http.Request('GET', url);
      // This seemed to be required for certain URLs
      // TODO(duncan): What?
      request.maxRedirects = 10;
      request.followRedirects = true;

      // TODO(issues/1): Here is the issue..
      // There are certain (spotify) CDNs which don't enable CORS
      // on their servers, so in Web the download won't work.
      // Which I guess means I need to proxy the request via the server...
      final response = await http.Client().send(request);
      final contentLength = response.contentLength ?? 1;

      if (response.statusCode != 200) {
        _log.info('url statusCode :: ${response.statusCode}');
        _status = DownloadItemStatus.error;
        _result = ApiResult.error(
          Exception('Failed to download file: ${response.statusCode}'),
        );
        notifyListeners();
        return;
      }
      _log.info('opening write');
      await file.openWrite();
      var bytesReceived = 0;
      await for (var chunk in response.stream) {
        _log.info('chunk');
        if (_status == DownloadItemStatus.canceled) {
          await file.cancelWrite();
          await onCancel();
          _result = ApiResult.error(Exception('cancelled download'));
          notifyListeners();
          return;
        }
        file.write(chunk);
        _log.info('wrote chunk');
        bytesReceived += chunk.length;
        _progress = bytesReceived / contentLength;
        // This is notifying the listeners too much

        notifyListeners();
      }
      await file.closeWrite();
    } on Exception catch (e) {
      _log.info(e);
      _status = DownloadItemStatus.error;
      _result = ApiResult.error(e);
      notifyListeners();
      return;
    }

    try {
      await onDone();
    } on Exception catch (e) {
      _result = ApiResult.error(e);
    }
    _status = DownloadItemStatus.done;
    _result = ApiResult.ok(true);
    notifyListeners();
  }

  void cancel() {
    _status = DownloadItemStatus.canceled;
  }
}

class DownloadManager {
  DownloadManager({required AbstractDatabaseService databaseService})
      : _databaseService = databaseService {
    // TODO(duncan): Cancel timer when nothing in queue
    Timer.periodic(Duration(seconds: 2), _handleQueue);
  }
  // TODO(duncan): This queue is in memory
  final List<DownloadItem> _queue = [];
  final AbstractDatabaseService _databaseService;

  DownloadItem add({
    required Uri url,
    required String filePath,
    required Future<void> Function() onDone,
    required Future<void> Function() onCancel,
  }) {
    // Check not already in queue?
    var item = DownloadItem(
      url: url,
      filePath: filePath,
      onDone: onDone,
      onCancel: onCancel,
      databaseService: _databaseService,
    );
    _queue.add(item);
    return item;
  }

  Future<void> delete(String filePath) async {
    // remove from queue
    for (var item in _queue.where((item) => item.filePath == filePath)) {
      switch (item.status) {
        case DownloadItemStatus.queued:
        case DownloadItemStatus.downloading:
          item.cancel();
          // Don't remove from queue, that will happen
          // after cancel
          continue;
        case DownloadItemStatus.canceled:
        case DownloadItemStatus.error:
        case DownloadItemStatus.done:
          // Don't think I need to do anything here..
          // The _handleQueue function will clean up the queue
          break;
      }
    }

    // Now for any downloads not in the queue I need to delete them
    AbstractFile _file(String filePath) {
      if (kIsWeb) {
        return IndexDbFile(filePath, _databaseService);
      } else {
        return FilesystemFile(filePath);
      }
    }

    final file = _file(filePath);
    _log.info('deleting file on disk: $filePath');
    await file.delete();
    _log.info('deleted file on disk');
  }

  void _handleQueue(_) {
    if (_queue.isEmpty) return;
    // Go through the queue and start the download of top N
    var queue = [];
    for (var i = 0; i < 5; i++) {
      if (i > _queue.length - 1) break;
      queue.add(_queue[i]);
    }

    for (var queueItem in queue) {
      switch (queueItem.status) {
        case DownloadItemStatus.queued:
          queueItem.download();
          break;
        case DownloadItemStatus.downloading:
          continue;
        case DownloadItemStatus.error:
          // should this stay in the queue?
          continue;
        case DownloadItemStatus.canceled:
        case DownloadItemStatus.done:
          _queue.remove(queueItem);
          break;
      }
    }
  }
}
