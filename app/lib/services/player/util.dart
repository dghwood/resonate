import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:resonate/models/models.dart';

// Episode to Media Item
MediaItem toMediaItem(Episode episode) {
  return MediaItem(
    id: episode.id,
    album: episode.podcastId,
    title: episode.title,
    duration: episode.duration,
    artUri: episode.imageUrl.isNotEmpty ? Uri.parse(episode.imageUrl) : null,
  );
}

// audioSource (from sequence) to Episode
Episode fromAudioSource(IndexedAudioSource audioSource) {
  return audioSource.tag as Episode;
}

// Episode to Audio Source
AudioSource toAudioSource(Episode episode) {
  return AudioSource.uri(
    Uri.parse(episode.audioUrl),
    // You only need this to be a media item for just_audio_background
    tag: episode,
  );
}
