/* Wrapper around an audio player 

*/
import 'dart:async';

import 'package:logging/logging.dart';
import 'package:resonate/models/models.dart';

Logger _log = Logger('services/player');

abstract class AbstractPlayerService {
  Future<bool> load(Episode episode);
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
}

class PlayerServiceMock implements AbstractPlayerService {
  PlayerServiceMock() {
    _setupStateStream();
    _setupProgressStream();
  }
  late final StreamController<PlayerState> _stateStreamController;
  StreamController<PlayerProgress>? _progressStreamController;
  int _progressSeconds = 0;
  int _bufferedSeconds = 1;

  Future<bool> _setupProgressStream() async {
    var d = await _progressStreamController?.close();
    _log.info('close::$d');
    _progressStreamController = StreamController<PlayerProgress>.broadcast(
      onListen: _onProgressListen,
      onCancel: () => _log.info('cancelled'),
    );
    _log.info('_setupProgressStream');
    return true;
  }

  void _setupStateStream() {
    _stateStreamController = StreamController<PlayerState>.broadcast(
      onListen: _onStateListen,
    );
  }

  @override
  PlayerProgress get progress {
    return PlayerProgress(
      progressDuration: Duration(seconds: _progressSeconds),
      bufferedDuration: Duration(seconds: _bufferedSeconds),
      duration: Duration(seconds: 30),
    );
  }

  @override
  Future<bool> load(Episode episode) async {
    _state = PlayerState.loading;
    // Reset these
    _progressSeconds = 0;
    _bufferedSeconds = 1;
    await _setupProgressStream();
    _log.info('this should be after _setupProgressStream');
    await Future.delayed(Duration(seconds: 1));
    _state = PlayerState.playing;
    return true;
  }

  @override
  Future<void> pause() async {
    _state = PlayerState.paused;
    _timer?.cancel();
  }

  Timer? _timer;

  void _onTick(Timer timer) {
    _log.info('tick::$_progressSeconds');
    _progressSeconds += 1;
    if (_progressSeconds > 30) {
      _timer?.cancel();
    }
    _progressStreamController?.add(progress);
  }

  @override
  Future<void> play() async {
    await Future.delayed(Duration(milliseconds: 500));
    _timer?.cancel();
    _state = PlayerState.playing;
    _timer = Timer.periodic(Duration(seconds: 1), _onTick);
  }

  @override
  Future<void> stop() async {
    await Future.delayed(Duration(milliseconds: 500));
    _state = PlayerState.finished;
    _timer?.cancel();
  }

  @override
  Future<void> seek(Duration duration) async {
    await Future.delayed(Duration(milliseconds: 500));
    _log.info('seek::${duration.inSeconds}');
    _progressSeconds = duration.inSeconds;
  }

  PlayerState __state = PlayerState.init;
  @override
  PlayerState get state => __state;
  set _state(PlayerState newState) {
    if (__state == newState) return;
    __state = newState;
    _stateStreamController.add(newState);
  }

  void _onStateListen() => _stateStreamController.add(state);
  void _onProgressListen() {
    _log.info('_onProgressListen::${_progressStreamController?.isClosed}');
    _progressStreamController?.add(progress);
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
