/* Wrappers around Proto message 

*/
import 'dart:typed_data';

import 'package:protobuf/protobuf.dart';
import 'package:resonate/proto/api.pb.dart' as api;
import 'package:resonate/proto/common.pb.dart';
import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:resonate/proto/common.pbjson.dart';
import 'package:resonate/services/database.dart';
import 'package:logging/logging.dart';
import 'package:resonate/services/download.dart';
import 'package:resonate/utils/proto.dart';
import 'package:resonate/utils/time.dart';

final Logger _log = Logger('models');

// Helper functions to convert between DateTime and Int64
// Note: timestamps are in milliseconds since epoch, UTC time
DateTime? _int64ToDateTime($fixnum.Int64? timestamp) {
  if (timestamp == null) return null;
  return DateTime.fromMillisecondsSinceEpoch(timestamp.toInt(), isUtc: true);
}

$fixnum.Int64? _dateTimeToInt64(DateTime? dateTime) {
  if (dateTime == null) return null;
  return $fixnum.Int64(dateTime.millisecondsSinceEpoch);
}

// Define a base class for common functionality
class BaseModel<T extends GeneratedMessage> {
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

  Uint8List get descriptor =>
      throw UnimplementedError('descriptor must be implemented by subclasses');

  DatabaseProtoStoreUtils<T> get utils =>
      DatabaseProtoStoreUtils<T>(descriptor, _message);

  String toStringStore() => utils.messageToString(_message);

  void fromStringStore(String storeMessage) =>
      utils.messageFromString(storeMessage, _message);

  DatabaseStoreType toStore() => utils.toStore();

  void fromStore(DatabaseStoreType storeMap) => utils.fromStore(storeMap);

  String get id =>
      throw UnimplementedError('id must be implemented by subclasses');
  Uint8List writeToBuffer() => _message.writeToBuffer();

  @override
  bool operator ==(Object other) {
    var m = other as BaseModel<T>;
    return id == m.id;
  }

  @override
  // Is this right?
  int get hashCode => id.hashCode;

  @override
  String toString() => _message.toString();
}

class StorageMetadata extends BaseModel<StorageMetadataMessage> {
  StorageMetadata({
    bool? isDeleted,
    DateTime? updatedTimestamp,
    DateTime? createdTimestamp,
  }) : super(
         StorageMetadataMessage(
           isDeleted: isDeleted,
           updatedTimestamp: _dateTimeToInt64(updatedTimestamp),
           createdTimestamp: _dateTimeToInt64(createdTimestamp),
         ),
       );

  StorageMetadata.fromMessage(super.message);
  factory StorageMetadata.now() => StorageMetadata(
    updatedTimestamp: DateTime.now(),
    createdTimestamp: DateTime.now(),
  );

  @override
  Uint8List get descriptor => storageMetadataMessageDescriptor;

  bool get isDeleted => _message.isDeleted;
  DateTime? get updatedTimestamp => _int64ToDateTime(_message.updatedTimestamp);
  DateTime? get createdTimestamp => _int64ToDateTime(_message.createdTimestamp);

  void markDeleted() {
    _message.isDeleted = true;
    _message.updatedTimestamp = _dateTimeToInt64(DateTime.now())!;
  }
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
  String get description => _message.description;
  String get audioUrl => _message.audioUrl;
  String get imageUrl => _message.imageUrl;
  DateTime get publishDateTime => fromProtoTimestamp(_message.publishTimestamp);
  int get publishTimestamp => _message.publishTimestamp.toInt();
  int get durationSeconds => _message.durationSeconds.toInt();
  int get episodeNumber => _message.episodeNumber.toInt();
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
    String? phoneNumber,
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
           phoneNumber: phoneNumber,
           imageUrl: imageUrl,
           subscriptions: subscriptions?.map((s) => s.toMessage()).toList(),
           listens: listens?.map((l) => l.toMessage()).toList(),
           following: following?.map((f) => f.toMessage()).toList(),
           numFollowers:
               numFollowers != null ? $fixnum.Int64(numFollowers) : null,
         ),
       );

  User.fromMessage(super.message);
  User.copy(User model)
    : super(UserMessage()..mergeFromMessage(model.toMessage()));

  @override
  Uint8List get descriptor => userMessageDescriptor;

  @override
  String get id => _message.id;
  String get name => _message.name;
  String get email => _message.email;
  String get phoneNumber => _message.phoneNumber;
  String get imageUrl => _message.imageUrl;
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

class PublicUser extends BaseModel<PublicUserMessage> {
  PublicUser({String? id, String? name, String? imageUrl})
    : super(PublicUserMessage(id: id, name: name, imageUrl: imageUrl));

  PublicUser.fromMessage(super.message);

  @override
  String get id => _message.id;
  String get name => _message.name;
  String get imageUrl => _message.imageUrl;
}

class UserSubscription extends BaseModel<UserSubscriptionMessage> {
  UserSubscription({
    String? id,
    String? userId,
    String? podcastId,
    StorageMetadata? metadata,
  }) : super(
         UserSubscriptionMessage(
           id: id,
           userId: userId,
           podcastId: podcastId,
           metadata: metadata?.toMessage(),
         ),
       );

  UserSubscription.fromMessage(super.message);
  UserSubscription.copy(UserSubscription model)
    : super(UserSubscriptionMessage()..mergeFromMessage(model.toMessage()));

  @override
  Uint8List get descriptor => userSubscriptionMessageDescriptor;

  @override
  String get id => _message.id;
  String get userId => _message.userId;
  String get podcastId => _message.podcastId;
  StorageMetadata get metadata =>
      StorageMetadata.fromMessage(_message.metadata);

  Podcast? get podcast =>
      _message.hasPodcast() ? Podcast.fromMessage(_message.podcast) : null;
}

class UserListen extends BaseModel<UserListenMessage> {
  UserListen({
    String? id,
    String? userId,
    String? episodeId,
    DateTime? listenTimestamp,
    Duration? seconds,
    bool? completed,
    Episode? episode,
  }) : super(
         UserListenMessage(
           id: id,
           userId: userId,
           episodeId: episodeId,
           listenTimestamp:
               listenTimestamp != null
                   ? $fixnum.Int64(
                     listenTimestamp.toUtc().millisecondsSinceEpoch,
                   )
                   : null,
           seconds: seconds != null ? $fixnum.Int64(seconds.inSeconds) : null,
           completed: completed,
           episode: episode?.toMessage(),
         ),
       );

  @override
  Uint8List get descriptor => userListenMessageDescriptor;
  UserListen.fromMessage(super.message);

  @override
  String get id => _message.id;
  String get userId => _message.userId;
  String get episodeId => _message.episodeId;
  int get listenTimestamp => _message.listenTimestamp.toInt();
  int get seconds => _message.seconds.toInt();
  bool get completed => _message.completed;
  Episode? get episode =>
      _message.hasEpisode() ? Episode.fromMessage(_message.episode) : null;

  UserListen copyWithEpisode(Episode episode) {
    var message = UserListenMessage()..mergeFromMessage(_message);
    message.episode = episode.toMessage();
    return UserListen.fromMessage(message);
  }
}

class UserFollow extends BaseModel<UserFollowMessage> {
  UserFollow({
    required String userId,
    required String followedUserId,
    StorageMetadata? metadata,
  }) : super(
         UserFollowMessage(
           id: '$userId-$followedUserId',
           userId: userId,
           followedUserId: followedUserId,
           metadata: metadata?.toMessage(),
         ),
       );

  UserFollow.fromMessage(super.message);

  UserFollow.copy(UserFollow model)
    : super(UserFollowMessage()..mergeFromMessage(model.toMessage()));

  @override
  Uint8List get descriptor => userFollowMessageDescriptor;

  @override
  String get id => _message.id;
  String get userId => _message.userId;
  String get followedUserId => _message.followedUserId;
  StorageMetadata get metadata =>
      StorageMetadata.fromMessage(_message.metadata);
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

class UserFeed extends BaseModel<UserFeedMessage> {
  UserFeed({String? userId}) : super(UserFeedMessage(userId: userId));

  UserFeed.fromMessage(super.message);

  @override
  Uint8List get descriptor => userFeedMessageDescriptor;

  @override
  String get id => _message.userId;

  Iterable<UserFeedItem> get items =>
      _message.items.map((i) => UserFeedItem.fromMessage(i));
}

class UserFeedItem extends BaseModel<UserFeedItemMessage> {
  UserFeedItem() : super(UserFeedItemMessage());

  UserFeedItem.fromMessage(super.message);

  @override
  Uint8List get descriptor => userFeedItemMessageDescriptor;

  UserFeedItemEpisode? get episodeItem =>
      _message.hasEpisodeItem()
          ? UserFeedItemEpisode.fromMessage(_message.episodeItem)
          : null;

  Iterable<UserFeedItemRecommendation>? get recommendationItems =>
      _message.recommendedItems.isNotEmpty
          ? _message.recommendedItems.map(
            (i) => UserFeedItemRecommendation.fromMessage(i),
          )
          : null;
}

class UserFeedItemEpisode extends BaseModel<UserFeedItemEpisodeMessage> {
  UserFeedItemEpisode() : super(UserFeedItemEpisodeMessage());

  UserFeedItemEpisode.fromMessage(super.message);

  @override
  Uint8List get descriptor => userFeedItemEpisodeMessageDescriptor;

  Episode get episode => Episode.fromMessage(_message.episode);
}

class UserFeedItemRecommendation
    extends BaseModel<UserFeedItemRecommendationMessage> {
  UserFeedItemRecommendation() : super(UserFeedItemRecommendationMessage());

  UserFeedItemRecommendation.fromMessage(super.message);

  @override
  Uint8List get descriptor => userFeedItemRecommendationMessageDescriptor;
}

class UserDownload extends BaseModel<UserDownloadMessage> {
  UserDownload({
    String? id,
    String? episodeId,
    String? filePath,
    bool? isDownloaded,
    StorageMetadata? metadata,
    this.downloadItem,
  }) : super(
         UserDownloadMessage(
           id: id,
           filePath: filePath,
           isDownloaded: isDownloaded,
           episodeId: episodeId,
           metadata: metadata?.toMessage(),
         ),
       );

  UserDownload.fromMessage(super.message, {this.downloadItem});

  UserDownload.copy(UserDownload model, {this.downloadItem})
    : super(UserDownloadMessage()..mergeFromMessage(model.toMessage()));

  @override
  Uint8List get descriptor => userDownloadMessageDescriptor;

  @override
  String get id => _message.id;
  bool get isDownloaded => _message.isDownloaded;
  set isDownloaded(bool value) {
    _message.isDownloaded = true;
    // TODO(duncan): update metadata timestamp
  }

  String get episodeId => _message.episodeId;
  String get filePath => _message.filePath;

  StorageMetadata get metadata =>
      StorageMetadata.fromMessage(_message.metadata);

  // Used for download
  DownloadItem? downloadItem;
}

class QueryCursor extends BaseModel<api.QueryCursor> {
  QueryCursor() : super(api.QueryCursor());

  QueryCursor.fromMessage(super.message);
}
