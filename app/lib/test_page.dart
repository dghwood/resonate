import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class TestingComponent extends StatefulWidget {
  const TestingComponent({super.key});

  @override
  State<TestingComponent> createState() => _TestingComponentState();
}

class _TestingComponentState extends State<TestingComponent> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _player.playerStateStream.listen(listen);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void listen(PlayerState state) {
    print(state);
  }

  Future<void> _play(String url) async {
    if (_player.playing) {
      await _player.stop();
    }
    // _player.removeAudioSourceAt(0);
    await _player.setAudioSource(AudioSource.uri(Uri.parse(url)));
    // await _player.setUrl(url);
    _player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: Icon(Icons.play_arrow),
          onPressed: () {
            var url =
                'https://dts.podtrac.com/redirect.mp3/pdst.fm/e/pfx.vpixl.com/6qj4J/pscrb.fm/rss/p/nyt.simplecastaudio.com/03d8b493-87fc-4bd1-931f-8a8e9b945d8a/episodes/1b2fd543-70c0-4649-876b-0444decbfd90/audio/128/default.mp3?aid=rss_feed&awCollectionId=03d8b493-87fc-4bd1-931f-8a8e9b945d8a&awEpisodeId=1b2fd543-70c0-4649-876b-0444decbfd90&feed=54nAGcIl';
            _play(url);
          },
        ),
        IconButton(
          icon: Icon(Icons.play_arrow),
          onPressed: () {
            var url =
                'https://dts.podtrac.com/redirect.mp3/pdst.fm/e/pfx.vpixl.com/6qj4J/pscrb.fm/rss/p/nyt.simplecastaudio.com/03d8b493-87fc-4bd1-931f-8a8e9b945d8a/episodes/9549afca-c024-484d-9c23-b371640366af/audio/128/default.mp3?aid=rss_feed&awCollectionId=03d8b493-87fc-4bd1-931f-8a8e9b945d8a&awEpisodeId=9549afca-c024-484d-9c23-b371640366af&feed=54nAGcIl';
            _play(url);
          },
        ),
        IconButton(
          icon: Icon(Icons.pause_rounded),
          onPressed: () {
            _player.pause();
          },
        ),
      ],
    );
  }
}
