import 'package:flutter/material.dart';

import 'package:resonate/mock_http.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/services/player/audio_handler.dart';

class TestingComponent extends StatefulWidget {
  const TestingComponent({super.key});

  @override
  State<TestingComponent> createState() => _TestingComponentState();
}

class _TestingComponentState extends State<TestingComponent> {
  AudioHandlerService? _audioHandler;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Future<AudioHandlerService> init() async {
  //   if (_audioHandler != null) return _audioHandler!;
  //   _audioHandler = await AudioHandlerService.create();
  //   return _audioHandler!;
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.value(AudioHandlerService.instance),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return CircularProgressIndicator();
        }
        var audioHandler = snapshot.requireData;
        return Column(
          children: [
            IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () {
                audioHandler.play();
              },
            ),
            IconButton(
              icon: Icon(Icons.pause),
              onPressed: () {
                audioHandler.pause();
              },
            ),
            IconButton(
              icon: Icon(Icons.skip_next),
              onPressed: () {
                audioHandler.skipToNext();
              },
            ),
            IconButton(
              icon: Icon(Icons.skip_next),
              onPressed: () {
                audioHandler.skipToPrevious();
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                audioHandler.playlist.add(
                  Episode.fromMessage(
                    mockEpisodeMessage(
                      id: '${DateTime.now().millisecondsSinceEpoch}',
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.next_plan),
              onPressed: () {
                audioHandler.playlist.addNext(
                  Episode.fromMessage(
                    mockEpisodeMessage(
                      id: '${DateTime.now().millisecondsSinceEpoch}',
                    ),
                  ),
                );
              },
            ),
            StreamBuilder(
              stream: audioHandler.positionStream,
              initialData: audioHandler.state,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting &&
                    snapshot.data == null) {
                  return CircularProgressIndicator();
                }
                var state = snapshot.requireData;
                print('positionStreamState $state');
                var episodeState = state.episodeState;
                if (episodeState == null) return Container();
                return LinearProgressIndicator(
                  value: episodeState.percentProgress,
                );
              },
            ),
            Expanded(
              child: ListenableBuilder(
                listenable: audioHandler.playlist,
                builder: (context, _) {
                  var playlist = audioHandler.playlist;
                  var episodes = playlist.episodes;
                  return ListView.builder(
                    itemCount: episodes.length,
                    itemBuilder: (context, index) {
                      var episode = episodes[index];
                      return StreamBuilder(
                        stream: audioHandler.episodeChangeStream,
                        initialData: audioHandler.state,
                        builder: (context, snapshot) {
                          print('episode changed');
                          // Check the episode is playing and if not do default behavior
                          var episodeChangeResult = snapshot.requireData;
                          var episodeState = episodeChangeResult.episodeState;
                          if (episodeState != null &&
                              episodeState.episode != episode) {
                            // Not the episode playing.. do something default.
                            return ListTile(title: Text(episode.id));
                          }
                          // Otherwise listen to the stream
                          return StreamBuilder(
                            stream: audioHandler.positionStream,
                            builder: (context, snapshot) {
                              Widget? subtitle = null;
                              Widget? leading = null;
                              if (snapshot.connectionState !=
                                  ConnectionState.waiting) {
                                var state = snapshot.requireData;
                                // subtitle = Text('${state.playerState}');
                                switch (state.playerState) {
                                  case PlayerState.playing:
                                    leading = Icon(Icons.play_arrow);
                                  case PlayerState.paused:
                                    leading = Icon(Icons.pause);
                                  default:
                                    leading = Icon(Icons.ac_unit);
                                }
                                var episodeState = state.episodeState;
                                if (episodeState != null) {
                                  subtitle = Text(
                                    '${episodeState.progressDuration.inMilliseconds}',
                                  );
                                }
                              }
                              return ListTile(
                                leading: leading,
                                title: Text(episode.id),
                                subtitle: subtitle,
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
