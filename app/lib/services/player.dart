/* Wrapper around an audio player 

*/
import 'dart:async';

import 'package:just_audio_background/just_audio_background.dart';
import 'package:logging/logging.dart';
import 'package:resonate/models/models.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart' as justAudio;

Logger _log = Logger('services/player');

abstract class AbstractPlayerService {
  Future<bool> load(Episode episode, {Duration? startDuration});
  Future<void> pause();
  Future<void> play();
  Future<void> stop();
  Future<void> seek(Duration duration);
  PlayerProgress get progress;
  Stream<PlayerState> streamState();
  PlayerState get state;
  Stream<PlayerProgress> streamProgress();
  void dispose();
}

enum PlayerState { init, playing, loading, paused, finished }

class PlayerProgress {
  PlayerProgress({
    required this.bufferedDuration,
    this.duration,
    required this.progressDuration,
    required this.episodeId,
    required this.playerState,
    this.completed = false,
  });
  final Duration progressDuration;
  final Duration bufferedDuration;
  final Duration? duration;
  final bool completed;
  final String episodeId;
  final PlayerState playerState;

  double get percentProgress {
    if (progressDuration == null || duration == null) {
      return 0;
    }
    return progressDuration!.inMilliseconds / duration!.inMilliseconds;
  }

  double get percentBuffered {
    if (bufferedDuration == null || duration == null) {
      return 0;
    }
    return bufferedDuration!.inMilliseconds / duration!.inMilliseconds;
  }

  Duration get remainingDuration {
    if (progressDuration == null || duration == null) {
      return Duration.zero;
    }
    return duration! - progressDuration!;
  }

  Duration calculateProgressDuration(double percent) {
    if (duration == null) {
      return Duration.zero;
    }
    return Duration(milliseconds: (duration!.inMilliseconds * percent).round());
  }

  Duration calculateRemainingDuration(double percent) {
    if (duration == null || progressDuration == null) {
      return Duration.zero;
    }
    return duration! - calculateProgressDuration(percent);
  }

  @override
  String toString() {
    return 'progress::$percentProgress';
  }
}

class PlayerService implements AbstractPlayerService {
  PlayerService() {
    _player = justAudio.AudioPlayer();
    _stateStreamController = StreamController<PlayerState>.broadcast(
      onListen: () => state,
    );
    _persistentProgressStreamController =
        StreamController<PlayerProgress>.broadcast(onListen: () => progress);
    // _setupProgressStream();
    _player.playerStateStream.listen((_) => _onStateChange());
    _player.processingStateStream.listen((_) => _onStateChange());
  }

  late final StreamController<PlayerProgress>
  _persistentProgressStreamController;
  late final StreamController<PlayerState> _stateStreamController;
  // StreamController<PlayerProgress>? _progressStreamController;

  @override
  void dispose() {
    _player.dispose();
    _stateStreamController.close();
    _persistentProgressStreamController.close();
    // _progressStreamController?.close();
  }

  void _onStateChange() {
    var s = state;
    _log.info('onStateChange::$s');
    _timer?.cancel();
    switch (s) {
      case PlayerState.init:
      case PlayerState.paused:
      case PlayerState.finished:
        break;
      case PlayerState.playing:
      case PlayerState.loading:
        _timer = Timer.periodic(Duration(seconds: 1), _onTick);
        break;
    }
    _stateStreamController.add(s);
    _persistentProgressStreamController.add(progress);
  }

  Timer? _timer;
  void _onTick(_) {
    // _progressStreamController?.add(progress);
    _persistentProgressStreamController.add(progress);
  }

  // Future<bool> _setupProgressStream() async {
  //   await _progressStreamController?.close();
  //   _progressStreamController = StreamController<PlayerProgress>.broadcast(
  //     onListen: () => progress,
  //   );
  //   return true;
  // }

  late final justAudio.AudioPlayer _player;

  Duration? _episodeDuration;
  String? _currentEpisodeId;

  @override
  Future<bool> load(Episode episode, {Duration? startDuration}) async {
    _log.info('load::${episode.audioUrl}');
    // Set up the audio session speech category
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    // There seems to be a bug, where if the player is not
    // stopped before you call this, it will just play the
    // same episode regardless of the audioSource.
    if (_player.playing) {
      _persistentProgressStreamController.add(progress);
      await _player.stop();
    }
    _currentEpisodeId = episode.id;
    _episodeDuration = await _player.setAudioSource(
      justAudio.AudioSource.uri(
        Uri.parse(episode.audioUrl),
        tag: MediaItem(
          id: episode.id,
          title: episode.title,
          duration: episode.duration,
          // TODO(duncan): I need the podcast name here..
          artUri: episode.imageUrl != '' ? Uri.parse(episode.imageUrl) : null,
        ),
      ),
      initialPosition: startDuration,
    );
    // await _setupProgressStream();
    // _player.play();
    return true;
  }

  @override
  Future<void> pause() async {
    await _player.pause();
  }

  @override
  Future<void> play() async {
    await _player.play();
  }

  PlayerProgress _progress({bool switchingAudio = false}) {
    return PlayerProgress(
      episodeId: _currentEpisodeId ?? 'unknown',
      progressDuration: _player.position,
      bufferedDuration: _player.bufferedPosition,
      duration: _episodeDuration,
      playerState: state,
    );
  }

  @override
  PlayerProgress get progress {
    return _progress();
  }

  @override
  Future<void> seek(Duration duration) async {
    await _player.seek(duration);
  }

  @override
  Future<void> stop() async {
    await _player.stop();
  }

  @override
  PlayerState get state {
    switch (_player.processingState) {
      case justAudio.ProcessingState.completed:
        return PlayerState.finished;
      case justAudio.ProcessingState.ready:
        return _player.playerState.playing
            ? PlayerState.playing
            : PlayerState.paused;
      case justAudio.ProcessingState.buffering:
      case justAudio.ProcessingState.loading:
        return PlayerState.loading;
      case justAudio.ProcessingState.idle:
        return PlayerState.init;
    }
  }

  @override
  Stream<PlayerState> streamState() {
    return _stateStreamController.stream;
  }

  @override
  Stream<PlayerProgress> streamProgress() {
    // return _progressStreamController!.stream;
    return _persistentProgressStreamController.stream;
  }
}
