/* Wrapper around an audio player 

*/
import 'dart:async';

import 'package:logging/logging.dart';
import 'package:resonate/models/models.dart';
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
}

enum PlayerState { init, playing, loading, paused, finished }

class PlayerProgress {
  PlayerProgress({
    this.bufferedDuration,
    this.duration,
    this.progressDuration,
    this.completed = false,
  });
  Duration? progressDuration;
  Duration? bufferedDuration;
  Duration? duration;
  bool completed;

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

  @override
  String toString() {
    return 'progress::$percentProgress';
  }
}

class PlayerService implements AbstractPlayerService {
  PlayerService() {
    _stateStreamController = StreamController<PlayerState>.broadcast(
      onListen: () => state,
    );
    _setupProgressStream();
    _player.playerStateStream.listen((_) => _onStateChange());
    _player.processingStateStream.listen((_) => _onStateChange());
  }

  late final StreamController<PlayerState> _stateStreamController;
  StreamController<PlayerProgress>? _progressStreamController;

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
  }

  Timer? _timer;
  void _onTick(_) {
    _progressStreamController?.add(progress);
  }

  Future<bool> _setupProgressStream() async {
    await _progressStreamController?.close();
    _progressStreamController = StreamController<PlayerProgress>.broadcast(
      onListen: () => progress,
    );
    return true;
  }

  final justAudio.AudioPlayer _player = justAudio.AudioPlayer();

  Duration? _episodeDuration;

  @override
  Future<bool> load(Episode episode, {Duration? startDuration}) async {
    _episodeDuration = await _player.setAudioSource(
      justAudio.AudioSource.uri(Uri.parse(episode.audioUrl)),
      initialPosition: startDuration,
    );
    await _setupProgressStream();
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

  @override
  PlayerProgress get progress {
    return PlayerProgress(
      progressDuration: _player.position,
      bufferedDuration: _player.bufferedPosition,
      duration: _episodeDuration,
    );
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
    return _progressStreamController!.stream;
  }
}

// class PlayerServiceMock implements AbstractPlayerService {
//   PlayerServiceMock() {
//     _setupStateStream();
//     _setupProgressStream();
//   }
//   late final StreamController<PlayerState> _stateStreamController;
//   StreamController<PlayerProgress>? _progressStreamController;
//   int _progressSeconds = 0;
//   int _bufferedSeconds = 1;

//   Future<bool> _setupProgressStream() async {
//     var d = await _progressStreamController?.close();
//     _progressStreamController = StreamController<PlayerProgress>.broadcast(
//       onListen: _onProgressListen,
//       onCancel: () => _log.info('cancelled'),
//     );
//     return true;
//   }

//   void _setupStateStream() {
//     _stateStreamController = StreamController<PlayerState>.broadcast(
//       onListen: _onStateListen,
//     );
//   }

//   @override
//   PlayerProgress get progress {
//     return PlayerProgress(
//       progressDuration: Duration(seconds: _progressSeconds),
//       bufferedDuration: Duration(seconds: _bufferedSeconds),
//       duration: Duration(seconds: 30),
//     );
//   }

//   @override
//   Future<bool> load(Episode episode, {Duration? startDuration}) async {
//     _state = PlayerState.loading;
//     // Reset these
//     _progressSeconds = 0;
//     _bufferedSeconds = 1;
//     await _setupProgressStream();
//     _log.info('this should be after _setupProgressStream');
//     await Future.delayed(Duration(seconds: 1));
//     _state = PlayerState.playing;
//     return true;
//   }

//   @override
//   Future<void> pause() async {
//     _state = PlayerState.paused;
//     _timer?.cancel();
//   }

//   Timer? _timer;

//   void _onTick(Timer timer) {
//     _log.info('tick::$_progressSeconds');
//     _progressSeconds += 1;
//     if (_progressSeconds > 30) {
//       _timer?.cancel();
//     }
//     _progressStreamController?.add(progress);
//   }

//   @override
//   Future<void> play() async {
//     await Future.delayed(Duration(milliseconds: 500));
//     _timer?.cancel();
//     _state = PlayerState.playing;
//     _timer = Timer.periodic(Duration(seconds: 1), _onTick);
//   }

//   @override
//   Future<void> stop() async {
//     await Future.delayed(Duration(milliseconds: 500));
//     _state = PlayerState.finished;
//     _timer?.cancel();
//   }

//   @override
//   Future<void> seek(Duration duration) async {
//     await Future.delayed(Duration(milliseconds: 500));
//     _log.info('seek::${duration.inSeconds}');
//     _progressSeconds = duration.inSeconds;
//   }

//   PlayerState __state = PlayerState.init;
//   @override
//   PlayerState get state => __state;
//   set _state(PlayerState newState) {
//     if (__state == newState) return;
//     __state = newState;
//     _stateStreamController.add(newState);
//   }

//   void _onStateListen() => _stateStreamController.add(state);
//   void _onProgressListen() {
//     _log.info('_onProgressListen::${_progressStreamController?.isClosed}');
//     _progressStreamController?.add(progress);
//   }

//   @override
//   Stream<PlayerState> streamState() {
//     return _stateStreamController.stream;
//   }

//   @override
//   Stream<PlayerProgress> streamProgress() {
//     return _progressStreamController!.stream;
//   }
// }
