import 'dart:typed_data';

import 'package:resonate/models/models.dart';
import 'package:resonate/proto/common.pb.dart';

// TODO: Replace with generated protobuf classes
class PlaylistMessage {
  String id = '';
  StorageMetadataMessage metadata = StorageMetadataMessage();
  EpisodeMessage? playingNow;
  List<EpisodeMessage> upNext = [];
}

class Playlist extends StorageModel<PlaylistMessage> {
  Playlist({required String id}) : super(PlaylistMessage()..id = id);

  Playlist.fromMessage(super.message);

  @override
  String get id => _message.id;

  @override
  StorageMetadata get metadata =>
      StorageMetadata.fromMessage(_message.metadata);

  Episode? get playingNow => _message.playingNow != null
      ? Episode.fromMessage(_message.playingNow!)
      : null;

  List<Episode> get upNext =>
      _message.upNext.map((e) => Episode.fromMessage(e)).toList();
}