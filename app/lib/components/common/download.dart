import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/download.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/services/download.dart';

Logger _log = Logger('components/common/download');

enum DownloadIconStatus { queued, downloading, canceled, error, done, init }

class DownloadIconComponent extends StatefulWidget {
  const DownloadIconComponent({
    super.key,
    required this.downloadApi,
    required this.episode,
  });

  final DownloadApi downloadApi;
  final Episode episode;

  @override
  State<DownloadIconComponent> createState() => _DownloadIconComponentState();
}

class _DownloadIconComponentState extends State<DownloadIconComponent> {
  DownloadIconStatus _status = DownloadIconStatus.init;
  DownloadItem? __downloadItem;
  DownloadItem? get _downloadItem => __downloadItem;
  set _downloadItem(DownloadItem? value) {
    _downloadItem?.removeListener(_listener);
    __downloadItem = value;
    // This doesn't seem to fire
    _listener();
    _downloadItem?.addListener(_listener);
  }

  @override
  void initState() {
    super.initState();
    var download = widget.downloadApi.get(widget.episode.id);
    if (download == null) return;
    if (download.isDownloaded) {
      _status = DownloadIconStatus.done;
      return;
    }
    _downloadItem = download.downloadItem;
  }

  @override
  void dispose() {
    _downloadItem?.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    // _log.info(__downloadItem!.status);
    setState(() {
      switch (_downloadItem!.status) {
        case DownloadItemStatus.queued:
          _status = DownloadIconStatus.queued;
        case DownloadItemStatus.downloading:
          _status = DownloadIconStatus.downloading;
        case DownloadItemStatus.canceled:
          _status = DownloadIconStatus.canceled;
        case DownloadItemStatus.error:
          _status = DownloadIconStatus.error;
        case DownloadItemStatus.done:
          _status = DownloadIconStatus.done;
      }
    });
  }

  void initDownload() async {
    var result = await widget.downloadApi.download(widget.episode);
    switch (result) {
      case ApiOk():
        setState(() {
          _downloadItem = result.value;
        });
      case ApiError():
        break;
    }
  }

  void initCancel() async {
    _downloadItem?.cancel();
  }

  void initDelete() async {
    var result = await widget.downloadApi.delete(widget.episode.id);
    switch (result) {
      case ApiOk():
      case ApiError():
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_status) {
      case DownloadIconStatus.init:
        return IconButton(
          icon: Icon(Icons.download_for_offline_outlined),
          onPressed: initDownload,
        );
      case DownloadIconStatus.queued:
        return IconButton(icon: Icon(Icons.refresh), onPressed: initCancel);
      case DownloadIconStatus.canceled:
        return IconButton(icon: Icon(Icons.cancel), onPressed: initDownload);
      case DownloadIconStatus.done:
        return Icon(Icons.download_done);
      case DownloadIconStatus.error:
        return IconButton(icon: Icon(Icons.error), onPressed: initDownload);
      case DownloadIconStatus.downloading:
        return GestureDetector(
          onTap: initCancel,
          child: LoadingSpinnerComponent(
            size: 18,
            value: _downloadItem!.progress,
          ),
        );
    }
  }
}
