import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/download.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/services/download.dart';

Logger _log = Logger('components/common/download');

class DownloadIcon extends StatefulWidget {
  const DownloadIcon({
    super.key,
    required this.downloadApi,
    required this.episode,
  });

  final DownloadApi downloadApi;
  final Episode episode;

  @override
  State<DownloadIcon> createState() => _DownloadIconState();
}

class _DownloadIconState extends State<DownloadIcon> {
  UserDownload? _userDownload;

  @override
  Widget build(BuildContext context) {
    _userDownload = widget.downloadApi.get(widget.episode.id);
    if (_userDownload != null) {
      if (_userDownload?.downloadItem == null) {
        // Need to remove the download on click?
        return Icon(Icons.download_done);
      }
      // Has download
      return DownloadingIcon(downloadItem: _userDownload!.downloadItem!);
    }
    return IconButton(
      icon: Icon(Icons.download),
      onPressed: () async {
        _log.info('download');
        var result = await widget.downloadApi.download(widget.episode);
        setState(() {});
      },
    );
  }
}

class DownloadingIcon extends StatelessWidget {
  const DownloadingIcon({super.key, required this.downloadItem});

  final DownloadItem downloadItem;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: downloadItem,
      builder: (context, _) {
        var item = downloadItem;
        switch (item.status) {
          case DownloadItemStatus.queued:
            return GestureDetector(
              onTap: () => item.cancel(),
              child: LoadingSpinnerComponent(size: 18),
            );
          case DownloadItemStatus.downloading:
            return GestureDetector(
              onTap: () => item.cancel(),
              child: LoadingSpinnerComponent(size: 18, value: item.progress),
            );
          case DownloadItemStatus.error:
            return Icon(Icons.error);
          case DownloadItemStatus.canceled:
            return Icon(Icons.cancel);
          case DownloadItemStatus.done:
            return Icon(Icons.download_done);
        }
      },
    );
  }
}
