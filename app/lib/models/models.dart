/* Wrappers around Proto message 

*/
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:protobuf/protobuf.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:resonate/proto/common.pbjson.dart';
import 'package:resonate/services/database.dart';
import 'package:logging/logging.dart';
import 'package:resonate/utils/proto.dart';

final Logger _log = Logger('models');

// Define a base class for common functionality
class BaseModel<T extends GeneratedMessage> extends ChangeNotifier {
  final T _message;

  BaseModel(this._message);

  T toMessage() => _message;

  void fromMessage(T message) {
    _message.mergeFromMessage(message);
  }

  void reset() {
    _message.clear();
  }

  void fromBuffer(Uint8List buffer) {
    _message.mergeFromBuffer(buffer);
  }

  String toStringStore() {
    // Should this be hex?
    return latin1.decode(_message.writeToBuffer());
  }

  void fromStringStore(String storeMessage) {
    _message.mergeFromBuffer(latin1.encode(storeMessage));
  }

  Uint8List get descriptor =>
      throw UnimplementedError('descriptor must be implemented by subclasses');

  DatabaseStoreType toStore() =>
      DatabaseProtoStoreUtils<T>(descriptor, _message).toStore();

  void fromStore(DatabaseStoreType storeMap) =>
      DatabaseProtoStoreUtils<T>(descriptor, _message).fromStore(storeMap);

  String get id =>
      throw UnimplementedError('id must be implemented by subclasses');
  Uint8List writeToBuffer() => _message.writeToBuffer();
}

class StorageMetadata extends BaseModel<StorageMetadataMessage> {
  StorageMetadata({
    bool? isDeleted,
    int? updatedTimestamp,
    int? createdTimestamp,
  }) : super(
         StorageMetadataMessage(
           isDeleted: isDeleted ?? false,
           updatedTimestamp:
               updatedTimestamp != null
                   ? $fixnum.Int64(updatedTimestamp)
                   : null,
           createdTimestamp:
               createdTimestamp != null
                   ? $fixnum.Int64(createdTimestamp)
                   : null,
         ),
       );

  StorageMetadata.fromMessage(super.message);

  @override
  Uint8List get descriptor => storageMetadataMessageDescriptor;

  bool get isDeleted => _message.isDeleted;
  int? get updatedTimestamp => _message.updatedTimestamp?.toInt();
  int? get createdTimestamp => _message.createdTimestamp?.toInt();
}

class Podcast extends BaseModel<PodcastMessage> {
  Podcast({
    required String id,
    String? title,
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
  Uint8List get descriptor => podcastMessageDescriptor;

  @override
  String get id => _message.id;
  String get title => _message.title;
  String get description => _message.description;
  String get url => _message.url;
  String get imageUrl => _message.imageUrl;
  String get author => _message.author;
  List<Episode> get episodes =>
      _message.episodes.map((e) => Episode.fromMessage(e)).toList();

  setEpisodes(Iterable<Episode> episodes) {
    _message.episodes.clear();
    _message.episodes.addAll(episodes.map((e) => e.toMessage()));
  }
}

class Episode extends BaseModel<EpisodeMessage> {
  Episode({
    required String id,
    String? podcastId,
    String? title,
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
  Uint8List get descriptor => episodeMessageDescriptor;

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

class Token extends BaseModel<TokenMessage> {
  Token({String? token, int? expiry})
    : super(
        TokenMessage(
          token: token,
          expiryUtcTimestamp: expiry != null ? $fixnum.Int64(expiry) : null,
        ),
      );

  Token.fromMessage(super.message);

  @override
  Uint8List get descriptor => tokenMessageDescriptor;

  String? get token => _message.token;
  int? get expiryUtcTimestamp => _message.expiryUtcTimestamp.toInt();
}

class UserStorage extends BaseModel<UserStorageMessage> {
  UserStorage({
    User? user,
    Token? accessToken,
    Token? refreshToken,
    int? tokenExpiry,
  }) : super(
         UserStorageMessage(
           user: user?.toMessage(),
           accessToken: accessToken?.toMessage(),
           refreshToken: refreshToken?.toMessage(),
         ),
       );

  UserStorage.fromMessage(super.message);

  @override
  Uint8List get descriptor => userStorageMessageDescriptor;

  @override
  String get id => _message.user.id;
  User get user => User.fromMessage(_message.user);
  Token? get accessToken => Token.fromMessage(_message.accessToken);
  Token? get refreshToken => Token.fromMessage(_message.refreshToken);
}

enum UserLoginStatus { signedOut, loading, signedIn }

class User extends BaseModel<UserMessage> {
  User({
    String? id,
    String? name,
    String? email,
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
  Uint8List get descriptor => userMessageDescriptor;

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
  int? get numFollowers => _message.numFollowers.toInt();
}

class UserSubscription extends BaseModel<UserSubscriptionMessage> {
  UserSubscription({String? id, String? userId, String? podcastId})
    : super(
        UserSubscriptionMessage(id: id, userId: userId, podcastId: podcastId),
      );

  UserSubscription.fromMessage(super.message);

  @override
  Uint8List get descriptor => userSubscriptionMessageDescriptor;

  @override
  String get id => _message.id;
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

  @override
  Uint8List get descriptor => userListenMessageDescriptor;
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
  Uint8List get descriptor => userFollowMessageDescriptor;

  @override
  String get id => '$userId-$followedUserId';
  String get userId => _message.userId;
  String get followedUserId => _message.followedUserId;
}

// Search Results
class SearchResults extends BaseModel<SearchResultsMessage> {
  SearchResults() : super(SearchResultsMessage());

  SearchResults.fromMessage(super.message);

  @override
  Uint8List get descriptor => searchResultsMessageDescriptor;
  List<SearchResult> get results =>
      _message.results.map((r) => SearchResult.fromMessage(r)).toList();
}

class SearchResult extends BaseModel<SearchResultMessage> {
  SearchResult() : super(SearchResultMessage());

  SearchResult.fromMessage(super.message);

  @override
  Uint8List get descriptor => searchResultMessageDescriptor;

  Podcast? get podcast =>
      _message.hasPodcast() ? Podcast.fromMessage(_message.podcast) : null;
  Episode? get episode =>
      _message.hasEpisode() ? Episode.fromMessage(_message.episode) : null;
  User? get user => _message.hasUser() ? User.fromMessage(_message.user) : null;
}
