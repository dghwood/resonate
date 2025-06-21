/* Wrappers around Proto message 

*/
import 'dart:typed_data';

import 'package:protobuf/protobuf.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:fixnum/fixnum.dart' as $fixnum;

// Define a base class for common functionality
class BaseModel<T extends GeneratedMessage> {
  final T _message;

  BaseModel(this._message);

  T toMessage() => _message;

  fromBuffer(Uint8List buffer) {
    _message.mergeFromBuffer(buffer);
  }

  String get id =>
      throw UnimplementedError('id must be implemented by subclasses');
  Uint8List writeToBuffer() => _message.writeToBuffer();
}

class Podcast extends BaseModel<PodcastMessage> {
  Podcast({
    required String id,
    required String title,
    String? description,
    String? url,
    String? imageUrl,
    String? author,
    List<Episode>? episodes,
  }) : super(
         PodcastMessage(
           id: id,
           title: title,
           description: description,
           url: url,
           imageUrl: imageUrl,
           author: author,
           episodes: episodes?.map((e) => e.toMessage()).toList(),
         ),
       );

  Podcast.fromMessage(super.message);

  @override
  String get id => _message.id;
  String get title => _message.title;
  String? get description => _message.description;
  String? get url => _message.url;
  String? get imageUrl => _message.imageUrl;
  String? get author => _message.author;
  List<Episode> get episodes =>
      _message.episodes.map((e) => Episode.fromMessage(e)).toList();
}

class Episode extends BaseModel<EpisodeMessage> {
  Episode({
    required String id,
    required String podcastId,
    required String title,
    String? description,
    String? audioUrl,
    String? imageUrl,
    int? publishTimestamp,
    int? durationSeconds,
    int? episodeNumber,
    bool? explicit,
  }) : super(
         EpisodeMessage(
           id: id,
           podcastId: podcastId,
           title: title,
           description: description,
           audioUrl: audioUrl,
           imageUrl: imageUrl,
           publishTimestamp:
               publishTimestamp != null
                   ? $fixnum.Int64(publishTimestamp)
                   : null,
           durationSeconds:
               durationSeconds != null ? $fixnum.Int64(durationSeconds) : null,
           episodeNumber:
               episodeNumber != null ? $fixnum.Int64(episodeNumber) : null,
           explicit: explicit,
         ),
       );

  Episode.fromMessage(super.message);

  @override
  String get id => _message.id;
  String get podcastId => _message.podcastId;
  String get title => _message.title;
  String? get description => _message.description;
  String? get audioUrl => _message.audioUrl;
  String? get imageUrl => _message.imageUrl;
  int? get publishTimestamp => _message.publishTimestamp?.toInt();
  int? get durationSeconds => _message.durationSeconds?.toInt();
  int? get episodeNumber => _message.episodeNumber?.toInt();
  bool? get explicit => _message.explicit;
}

class User extends BaseModel<UserMessage> {
  User({
    required String id,
    required String name,
    required String email,
    String? imageUrl,
    List<UserSubscription>? subscriptions,
    List<UserListen>? listens,
    List<UserFollow>? following,
    int? numFollowers,
  }) : super(
         UserMessage(
           id: id,
           name: name,
           email: email,
           imageUrl: imageUrl,
           subscriptions: subscriptions?.map((s) => s.toMessage()).toList(),
           listens: listens?.map((l) => l.toMessage()).toList(),
           following: following?.map((f) => f.toMessage()).toList(),
           numFollowers:
               numFollowers != null ? $fixnum.Int64(numFollowers) : null,
         ),
       );

  User.fromMessage(super.message);

  @override
  String get id => _message.id;
  String get name => _message.name;
  String get email => _message.email;
  String? get imageUrl => _message.imageUrl;
  List<UserSubscription> get subscriptions =>
      _message.subscriptions
          .map((s) => UserSubscription.fromMessage(s))
          .toList();
  List<UserListen> get listens =>
      _message.listens.map((l) => UserListen.fromMessage(l)).toList();
  List<UserFollow> get following =>
      _message.following.map((f) => UserFollow.fromMessage(f)).toList();
  int? get numFollowers => _message.numFollowers?.toInt();
}

class UserSubscription extends BaseModel<UserSubscriptionMessage> {
  UserSubscription({required String userId, required String podcastId})
    : super(UserSubscriptionMessage(userId: userId, podcastId: podcastId));

  UserSubscription.fromMessage(super.message);

  @override
  String get id => '$userId-$podcastId';
  String get userId => _message.userId;
  String get podcastId => _message.podcastId;
}

class UserListen extends BaseModel<UserListenMessage> {
  UserListen({
    required String userId,
    required String episodeId,
    required int listenTimestamp,
    required int seconds,
    required bool completed,
    Episode? episode,
  }) : super(
         UserListenMessage(
           userId: userId,
           episodeId: episodeId,
           listenTimestamp: $fixnum.Int64(listenTimestamp),
           seconds: $fixnum.Int64(seconds),
           completed: completed,
           episode: episode?.toMessage(),
         ),
       );

  UserListen.fromMessage(super.message);

  @override
  String get id => '$userId-$episodeId';
  String get userId => _message.userId;
  String get episodeId => _message.episodeId;
  int get listenTimestamp => _message.listenTimestamp.toInt();
  int get seconds => _message.seconds.toInt();
  bool get completed => _message.completed;
  Episode? get episode =>
      _message.hasEpisode() ? Episode.fromMessage(_message.episode) : null;
}

class UserFollow extends BaseModel<UserFollowMessage> {
  UserFollow({required String userId, required String followedUserId})
    : super(UserFollowMessage(userId: userId, followedUserId: followedUserId));

  UserFollow.fromMessage(super.message);

  @override
  String get id => '$userId-$followedUserId';
  String get userId => _message.userId;
  String get followedUserId => _message.followedUserId;
}
