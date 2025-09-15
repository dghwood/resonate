import 'dart:async';

import 'package:flutter/material.dart';
import 'package:resonate/api/result.dart';

enum DownloadItemStatus { queued, downloading, canceled, error, done }

class DownloadItem extends ChangeNotifier {
  DownloadItem({
    required this.url,
    required this.filePath,
    required this.onDone,
    required this.onCancel,
  });

  final Uri url;
  final String filePath;
  final Future<void> Function() onDone;
  final Future<void> Function() onCancel;

  DownloadItemStatus _status = DownloadItemStatus.queued;
  DownloadItemStatus get status => _status;

  double _progress = 0;
  double get progress => _progress;

  ApiResult<bool>? _result;
  // Only call when done
  ApiResult<bool> get result => _result!;

  void download() async {
    _status = DownloadItemStatus.downloading;
    for (var i = 0; i < 11; i++) {
      if (_status == DownloadItemStatus.canceled) {
        await onCancel();
        _result = ApiResult.error(Exception('cancelled download'));
        notifyListeners();
        return;
      }
      await Future.delayed(const Duration(seconds: 1));
      _progress = i / 10;
      notifyListeners();
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
  DownloadManager() {
    // TODO(duncan): Cancel timer when nothing in queue
    Timer.periodic(Duration(seconds: 2), _handleQueue);
  }
  // TODO(duncan): This queue is in memory
  final List<DownloadItem> _queue = [];

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
    );
    _queue.add(item);
    return item;
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
