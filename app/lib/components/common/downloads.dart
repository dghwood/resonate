import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/download.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/models/models.dart';

Logger _log = Logger('components/common/downloads');

class DownloadsListComponent extends StatefulWidget {
  const DownloadsListComponent({super.key, required DownloadsApi downloadsApi})
    : _downloadsApi = downloadsApi;
  final DownloadsApi _downloadsApi;

  @override
  State<DownloadsListComponent> createState() => _DownloadsListComponentState();
}

class _DownloadsListComponentState extends State<DownloadsListComponent> {
  late Future<ApiResult<Iterable<Episode>>> _future;

  @override
  void initState() {
    super.initState();
    _future = widget._downloadsApi.get();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _future = widget._downloadsApi.get();
        });
      },
      child: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingSpinnerComponent();
          }
          var result = snapshot.requireData;
          switch (result) {
            case ApiOk():
              _log.info('result::ok::${result.value.length}');
              break;
            case ApiError():
              return Text('Error loading downloads: ${result.error}');
          }

          var episodes = result.value;
          return ListView.builder(
            itemCount: episodes.length,
            itemBuilder: (context, index) {
              var episode = episodes.elementAt(index);
              return ListTile(
                // onTap: () => Navigate(context).toPodcast(episodes.id),
                leading:
                    episode.imageUrl != ''
                        ? Image.network(episode.imageUrl)
                        : null,
                title: Text(episode.title),
                subtitle: Text(episode.description, maxLines: 2),
                trailing: DownloadDeleteIconComponent(
                  downloadsApi: widget._downloadsApi,
                  episode: episode,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DownloadDeleteIconComponent extends StatelessWidget {
  const DownloadDeleteIconComponent({
    super.key,
    required this.episode,
    required this.downloadsApi,
  });

  final Episode episode;
  final DownloadsApi downloadsApi;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        _log.info('delete');
        downloadsApi.delete(episode.id);
      },
    );
  }
}
