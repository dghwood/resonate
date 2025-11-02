import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/player.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/components/common/reordable_listview.dart';

class PlaylistComponent extends StatelessWidget {
  const PlaylistComponent({super.key, required this.playerApi});

  final PlayerApi playerApi;

  @override
  Widget build(BuildContext context) {
    var playlistApi = playerApi.playlistApi;
    return FutureBuilder(
      future: playlistApi.list(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingSpinnerComponent();
        }
        var episodes = snapshot.requireData.toList();
        return ReordableListviewComponent(
          items: episodes,
          onReorder: (oldIndex, newIndex) async {
            await Future.delayed(Duration(seconds: 1));
          },
          builder:
              (episode) => ListTile(
                key: Key(episode.id),
                leading: Image.network(episode.imageUrl),
                title: Text(episode.title),
                trailing: Icon(Icons.play_arrow),
              ),
        );
        return ListView.builder(
          itemCount: episodes.length,
          itemBuilder: (context, index) {
            var episode = episodes.elementAt(index);
            var widget = ListTile(
              leading: Image.network(episode.imageUrl),
              title: Text(episode.title),
              trailing: Icon(Icons.play_arrow),
            );
            return widget;
          },
        );
      },
    );
  }

  static void show(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return PlaylistComponent(playerApi: context.read());
      },
    );
  }
}
