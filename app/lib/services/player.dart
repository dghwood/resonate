/* Wrapper around an audio player 

*/
import 'dart:async';

import 'package:audio_service/audio_service.dart';
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
    if (progressDuration == null || duration == null || duration == Duration.zero) {
      return 0;
    }
    return progressDuration.inMilliseconds / duration!.inMilliseconds;
  }

  double get percentBuffered {
    if (bufferedDuration == null || duration == null || duration == Duration.zero) {
      return 0;
    }
    return bufferedDuration.inMilliseconds / duration!.inMilliseconds;
  }

  Duration get remainingDuration {
    if (progressDuration == null || duration == null) {
      return Duration.zero;
    }
    return duration! - progressDuration;
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
    _stateStreamController = StreamController<PlayerState>.broadcast(
      onListen: () => state,
    );
    _persistentProgressStreamController =
        StreamController<PlayerProgress>.broadcast(onListen: () => progress);

    _init();
  }

  final Completer<ResonateAudioHandler> _handlerCompleter = Completer();
  ResonateAudioHandler? _handler;

  StreamSubscription? _playbackSubscription;
  StreamSubscription? _progressSubscription;

  Future<void> _init() async {
    final handler = await AudioService.init(
      builder: () => ResonateAudioHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.resonate.audio',
        androidNotificationChannelName: 'Resonate Audio Playback',
        androidNotificationOngoing: true,
      ),
    );

    _playbackSubscription = handler.playbackState.listen((_) => _onStateChange());
    _progressSubscription = handler.progress.listen((p) {
      _persistentProgressStreamController.add(p);
    });

    _handler = handler;
    _handlerCompleter.complete(handler);
  }

  late final StreamController<PlayerProgress> _persistentProgressStreamController;
  late final StreamController<PlayerState> _stateStreamController;

  @override
  void dispose() {
    _playbackSubscription?.cancel();
    _progressSubscription?.cancel();
    _stateStreamController.close();
    _persistentProgressStreamController.close();
  }

  void _onStateChange() {
    var s = state;
    _log.info('onStateChange::$s');
    _stateStreamController.add(s);
  }

  @override
  Future<bool> load(Episode episode, {Duration? startDuration}) async {
    _log.info('load::${episode.audioUrl}');
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    final handler = await _handlerCompleter.future;
    await handler.loadEpisode(episode, startDuration: startDuration);
    return true;
  }

  @override
  Future<void> pause() async {
    final handler = await _handlerCompleter.future;
    await handler.pause();
  }

  @override
  Future<void> play() async {
    final handler = await _handlerCompleter.future;
    await handler.play();
  }

  @override
  PlayerProgress get progress {
    if (_handler == null) {
       return PlayerProgress(
         bufferedDuration: Duration.zero,
         progressDuration: Duration.zero,
         episodeId: 'unknown',
         playerState: PlayerState.init,
       );
    }
    return _handler!.currentProgress;
  }

  @override
  Future<void> seek(Duration duration) async {
    final handler = await _handlerCompleter.future;
    await handler.seek(duration);
  }

  @override
  Future<void> stop() async {
    final handler = await _handlerCompleter.future;
    await handler.stop();
  }

  @override
  PlayerState get state {
    if (_handler == null) return PlayerState.init;
    final playing = _handler!.playbackState.value.playing;
    final processingState = _handler!.playbackState.value.processingState;

    switch (processingState) {
      case AudioProcessingState.completed:
        return PlayerState.finished;
      case AudioProcessingState.ready:
        return playing ? PlayerState.playing : PlayerState.paused;
      case AudioProcessingState.buffering:
      case AudioProcessingState.loading:
        return PlayerState.loading;
      case AudioProcessingState.idle:
        return PlayerState.init;
      default:
        return PlayerState.init;
    }
  }

  @override
  Stream<PlayerState> streamState() {
    return _stateStreamController.stream;
  }

  @override
  Stream<PlayerProgress> streamProgress() {
    return _persistentProgressStreamController.stream;
  }
}

class ResonateAudioHandler extends BaseAudioHandler with SeekHandler {
  final _player = justAudio.AudioPlayer();
  final _progressController = StreamController<PlayerProgress>.broadcast();

  Stream<PlayerProgress> get progress => _progressController.stream;

  ResonateAudioHandler() {
    _player.playbackEventStream.listen((event) {
      playbackState.add(_transformEvent(event));
    });

    _player.processingStateStream.listen((state) {
       if (state == justAudio.ProcessingState.completed) {
         playbackState.add(playbackState.value.copyWith(
           processingState: AudioProcessingState.completed,
         ));
       }
    });

    _player.positionStream.listen((position) {
      _progressController.add(currentProgress);
    });
  }

  PlayerProgress get currentProgress {
    return PlayerProgress(
      episodeId: mediaItem.value?.id ?? 'unknown',
      progressDuration: _player.position,
      bufferedDuration: _player.bufferedPosition,
      duration: _player.duration,
      playerState: _state,
    );
  }

  PlayerState get _state {
    switch (_player.processingState) {
      case justAudio.ProcessingState.completed:
        return PlayerState.finished;
      case justAudio.ProcessingState.ready:
        return _player.playing ? PlayerState.playing : PlayerState.paused;
      case justAudio.ProcessingState.buffering:
      case justAudio.ProcessingState.loading:
        return PlayerState.loading;
      case justAudio.ProcessingState.idle:
        return PlayerState.init;
    }
  }

  Future<void> loadEpisode(Episode episode, {Duration? startDuration}) async {
    final item = MediaItem(
      id: episode.id,
      album: episode.podcastId,
      title: episode.title,
      duration: episode.duration,
      artUri: episode.imageUrl.isNotEmpty ? Uri.parse(episode.imageUrl) : null,
      extras: {'audioUrl': episode.audioUrl},
    );
    mediaItem.add(item);

    await _player.setAudioSource(
      justAudio.AudioSource.uri(
        Uri.parse(episode.audioUrl),
      ),
      initialPosition: startDuration,
    );
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() async {
    await _player.stop();
    await super.stop();
  }

  PlaybackState _transformEvent(justAudio.PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.rewind,
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.fastForward,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        justAudio.ProcessingState.idle: AudioProcessingState.idle,
        justAudio.ProcessingState.loading: AudioProcessingState.loading,
        justAudio.ProcessingState.buffering: AudioProcessingState.buffering,
        justAudio.ProcessingState.ready: AudioProcessingState.ready,
        justAudio.ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }
}
