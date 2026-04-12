import 'dart:async';
import 'package:audio_session/audio_session.dart';
import 'package:resonate/api/listens.dart';
import 'package:resonate/services/player/playlist.dart';
import 'package:resonate/services/player/util.dart';

import 'package:audio_service/audio_service.dart';
import 'package:logging/logging.dart';
import 'package:resonate/models/models.dart';
import 'package:just_audio/just_audio.dart' hide PlayerState;

Logger _log = Logger('services/player/audio_service');

enum PlayerState { init, playing, loading, paused, finished }

class AudioHandlerServiceState {
  AudioHandlerServiceState({required this.playerState, this.episodeState});
  final PlayerState playerState;
  AudioHandlerServiceEpisodeState? episodeState;
}

class AudioHandlerServiceEpisodeState {
  AudioHandlerServiceEpisodeState({
    required this.bufferedDuration,
    required this.episodeDuration,
    required this.progressDuration,
    required this.episode,
    required this.queueIndex,
  });
  final Duration progressDuration;
  final Duration bufferedDuration;
  final Duration episodeDuration;
  final Episode episode;
  final int queueIndex;

  double get percentProgress {
    if (episodeDuration.inMilliseconds == 0) return 0.0;
    return progressDuration.inMilliseconds / episodeDuration.inMilliseconds;
  }

  double get percentBuffered {
    if (episodeDuration.inMilliseconds == 0) return 0.0;
    return bufferedDuration.inMilliseconds / episodeDuration.inMilliseconds;
  }

  Duration get remainingDuration {
    return episodeDuration - progressDuration;
  }

  // What does this do again?
  Duration calculateProgressDuration(double percent) {
    return Duration(
      milliseconds: (episodeDuration.inMilliseconds * percent).round(),
    );
  }

  // What does this do again?
  Duration calculateRemainingDuration(double percent) {
    return episodeDuration - calculateProgressDuration(percent);
  }
}

/* AudioHandlerService 

  Use `playbackState` to broadcast changes to the UI 
  Use `queue` to manage the queue of items 
  Use `mediaItem` to mange the mediaItem shown in the notification

  * SeekHandler 
  * QueueHandler -> Don't implement for now

  Needs two streams exposed 
  1) State stream for play, pause, new episodes, etc. 
  2) Progress stream for position events (incl state stream)
*/
class AudioHandlerService extends BaseAudioHandler
    with QueueHandler, SeekHandler
/* implements AbstractPlayerService */ {
  final _player = AudioPlayer();
  final ListenApi listenApi;
  late final AudioHandlerServicePlaylist playlist;

  // This fires when the general state of the player changes
  late final StreamController<AudioHandlerServiceState> _stateStreamController;
  Stream<AudioHandlerServiceState> get stateStream =>
      _stateStreamController.stream;

  // This fires when the player position is updated
  late final StreamController<AudioHandlerServiceState>
  _positionStreamController;
  Stream<AudioHandlerServiceState> get positionStream =>
      _positionStreamController.stream;

  // This fires when the episode changes
  late final StreamController<AudioHandlerServiceState>
  _episodeChangeStreamController;
  Stream<AudioHandlerServiceState> get episodeChangeStream =>
      _episodeChangeStreamController.stream;

  AudioHandlerService({required this.listenApi}) {
    playlist = AudioHandlerServicePlaylist(_player);
    _stateStreamController =
        StreamController<AudioHandlerServiceState>.broadcast(
          // onListen: () {
          //   _stateStreamController.add(state);
          // },
        );
    _positionStreamController =
        StreamController<AudioHandlerServiceState>.broadcast(
          // onListen: () {
          //   _positionStreamController.add(state);
          // },
        );
    _episodeChangeStreamController =
        StreamController<AudioHandlerServiceState>.broadcast(
          // onListen: () {
          //   _log.info('onListenEvent::episodeChangeStream');
          //   _episodeChangeStreamController.add(state);
          // },
        );
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
    _player.playbackEventStream.listen((_) {
      // For general playback state changes
      _stateStreamController.add(state);
    });
    _player.sequenceStateStream.listen(onSequenceStream);
    _player.currentIndexStream.distinct().listen(onIndexChange);
  }

  Future<void> init() async {
    await playlist.init();
    AudioService.position.listen(onPositionChange);
  }

  AudioHandlerServiceState get state {
    var index = _player.currentIndex;
    if (index == null) {
      return AudioHandlerServiceState(playerState: _playerState);
    }
    var audioSource = _player.sequence[index];
    // In case the Duration is null
    // which it shouldn't be
    var episodeDuration = audioSource.duration ?? _player.position;
    if (_player.bufferedPosition > episodeDuration) {
      episodeDuration = _player.bufferedPosition;
    }
    return AudioHandlerServiceState(
      playerState: _playerState,
      episodeState: AudioHandlerServiceEpisodeState(
        episode: audioSource.tag as Episode,
        progressDuration: _player.position,
        bufferedDuration: _player.bufferedPosition,
        episodeDuration: episodeDuration,
        queueIndex: index,
      ),
    );
  }

  PlayerState get _playerState {
    switch (_player.processingState) {
      case ProcessingState.completed:
        return PlayerState.finished;
      case ProcessingState.ready:
        return _player.playerState.playing
            ? PlayerState.playing
            : PlayerState.paused;
      case ProcessingState.buffering:
      case ProcessingState.loading:
        return PlayerState.loading;
      case ProcessingState.idle:
        return PlayerState.init;
    }
  }

  // Fired when the episode changes.
  // TODO(duncan): Watch out for the bubble
  void onIndexChange(int? index) async {
    _log.info('onIndexChange::$index');
    _episodeChangeStreamController.add(state);
    if (index == null) return;
    var episode = fromAudioSource(_player.sequence[index]);
    _log.info('Playing Episode Id: ${episode.id}');

    // Load the listen if it exists, set the vol low
    // otherwise the player will 'skip'
    await _player.setVolume(0);
    // var result = listenApi.get(episode.id);
    // var duration = result?.seconds;
    var duration = null;
    if (duration != null) {
      await _player.seek(Duration(seconds: duration), index: index);
    }
    await _player.setVolume(1);
  }

  // Fired when the position of the playing episode changes.
  void onPositionChange(Duration duration) {
    _positionStreamController.add(state);
  }

  void onSequenceStream(SequenceState sequenceState) async {
    // Update the queue
    queue.add(
      sequenceState.sequence.map(fromAudioSource).map(toMediaItem).toList(),
    );
    // Update the media item
    var audioSource = sequenceState.currentSource;
    if (audioSource == null) return;
    mediaItem.add(toMediaItem(fromAudioSource(audioSource)));
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    _log.info('skipToQueueItem::$index');
    var numAudioSources = _player.audioSources.length;
    if (index < 0 || index >= numAudioSources) return;
    // This should fire the sequence listener I think
    _player.seek(Duration.zero, index: index);
    await super.skipToQueueItem(index);
  }

  @override
  Future<void> play() {
    _log.info('play');
    // This holds whilst playing
    var p = _player.play();
    // onListenEvent();
    return p;
  }

  @override
  Future<void> pause() async {
    _log.info('pause');
    await _player.pause();
    // onListenEvent();
  }

  @override
  Future<void> seek(Duration position) async {
    _log.info('seek::$position');
    await _player.seek(position);
    // onListenEvent();
  }

  Future<void> seekRelative(Duration position) async {
    _player.seek(_player.position + position);
  }

  @override
  Future<void> stop() async {
    _log.info('stop');
    await _player.stop();
    // onListenEvent();
    await super.stop();
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    // This also includes the duration of the episode
    _log.info(event);
    var episode = _player.sequenceState.currentSource?.tag as Episode?;
    // _log.info('episodeId::${episode?.id}');
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
      processingState:
          const {
            ProcessingState.idle: AudioProcessingState.idle,
            ProcessingState.loading: AudioProcessingState.loading,
            ProcessingState.buffering: AudioProcessingState.buffering,
            ProcessingState.ready: AudioProcessingState.ready,
            ProcessingState.completed: AudioProcessingState.completed,
          }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }

  void dispose() {
    _player.dispose();
    // _stateStreamController.close();
    // _persistentProgressStreamController.close();
  }

  static AudioHandlerService? _audioHandler;
  static AudioHandlerService get instance => _audioHandler!;

  static Future<AudioHandlerService> create() async {
    if (_audioHandler != null) return _audioHandler!;
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    var audioHandler = await AudioService.init(
      builder: () => AudioHandlerService(listenApi: ListenApi.instance),
      config: AudioServiceConfig(
        androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
        androidNotificationChannelName: 'Audio playback',
        androidNotificationOngoing: true,
      ),
    );
    await audioHandler.init();
    _audioHandler = audioHandler;
    return audioHandler;
  }
}
