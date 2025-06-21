//
//  Generated code. Do not modify.
//  source: proto/common.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class PodcastMessage extends $pb.GeneratedMessage {
  factory PodcastMessage({
    $core.String? id,
    $core.String? title,
    $core.String? description,
    $core.String? url,
    $core.String? imageUrl,
    $core.String? author,
    $core.Iterable<EpisodeMessage>? episodes,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (title != null) {
      $result.title = title;
    }
    if (description != null) {
      $result.description = description;
    }
    if (url != null) {
      $result.url = url;
    }
    if (imageUrl != null) {
      $result.imageUrl = imageUrl;
    }
    if (author != null) {
      $result.author = author;
    }
    if (episodes != null) {
      $result.episodes.addAll(episodes);
    }
    return $result;
  }
  PodcastMessage._() : super();
  factory PodcastMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PodcastMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PodcastMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'url')
    ..aOS(5, _omitFieldNames ? '' : 'imageUrl')
    ..aOS(6, _omitFieldNames ? '' : 'author')
    ..pc<EpisodeMessage>(7, _omitFieldNames ? '' : 'episodes', $pb.PbFieldType.PM, subBuilder: EpisodeMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PodcastMessage clone() => PodcastMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PodcastMessage copyWith(void Function(PodcastMessage) updates) => super.copyWith((message) => updates(message as PodcastMessage)) as PodcastMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PodcastMessage create() => PodcastMessage._();
  PodcastMessage createEmptyInstance() => create();
  static $pb.PbList<PodcastMessage> createRepeated() => $pb.PbList<PodcastMessage>();
  @$core.pragma('dart2js:noInline')
  static PodcastMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PodcastMessage>(create);
  static PodcastMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get url => $_getSZ(3);
  @$pb.TagNumber(4)
  set url($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get imageUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set imageUrl($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasImageUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearImageUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get author => $_getSZ(5);
  @$pb.TagNumber(6)
  set author($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAuthor() => $_has(5);
  @$pb.TagNumber(6)
  void clearAuthor() => $_clearField(6);

  /// this is optional
  @$pb.TagNumber(7)
  $pb.PbList<EpisodeMessage> get episodes => $_getList(6);
}

class EpisodeMessage extends $pb.GeneratedMessage {
  factory EpisodeMessage({
    $core.String? id,
    $core.String? podcastId,
    $core.String? title,
    $core.String? description,
    $core.String? audioUrl,
    $core.String? imageUrl,
    $fixnum.Int64? publishTimestamp,
    $fixnum.Int64? durationSeconds,
    $fixnum.Int64? episodeNumber,
    $core.bool? explicit,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (podcastId != null) {
      $result.podcastId = podcastId;
    }
    if (title != null) {
      $result.title = title;
    }
    if (description != null) {
      $result.description = description;
    }
    if (audioUrl != null) {
      $result.audioUrl = audioUrl;
    }
    if (imageUrl != null) {
      $result.imageUrl = imageUrl;
    }
    if (publishTimestamp != null) {
      $result.publishTimestamp = publishTimestamp;
    }
    if (durationSeconds != null) {
      $result.durationSeconds = durationSeconds;
    }
    if (episodeNumber != null) {
      $result.episodeNumber = episodeNumber;
    }
    if (explicit != null) {
      $result.explicit = explicit;
    }
    return $result;
  }
  EpisodeMessage._() : super();
  factory EpisodeMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EpisodeMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EpisodeMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'podcastId')
    ..aOS(3, _omitFieldNames ? '' : 'title')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOS(5, _omitFieldNames ? '' : 'audioUrl')
    ..aOS(6, _omitFieldNames ? '' : 'imageUrl')
    ..aInt64(8, _omitFieldNames ? '' : 'publishTimestamp')
    ..aInt64(9, _omitFieldNames ? '' : 'durationSeconds')
    ..aInt64(10, _omitFieldNames ? '' : 'episodeNumber')
    ..aOB(11, _omitFieldNames ? '' : 'explicit')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EpisodeMessage clone() => EpisodeMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EpisodeMessage copyWith(void Function(EpisodeMessage) updates) => super.copyWith((message) => updates(message as EpisodeMessage)) as EpisodeMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EpisodeMessage create() => EpisodeMessage._();
  EpisodeMessage createEmptyInstance() => create();
  static $pb.PbList<EpisodeMessage> createRepeated() => $pb.PbList<EpisodeMessage>();
  @$core.pragma('dart2js:noInline')
  static EpisodeMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EpisodeMessage>(create);
  static EpisodeMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get podcastId => $_getSZ(1);
  @$pb.TagNumber(2)
  set podcastId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPodcastId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPodcastId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get audioUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set audioUrl($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAudioUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearAudioUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get imageUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set imageUrl($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasImageUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearImageUrl() => $_clearField(6);

  @$pb.TagNumber(8)
  $fixnum.Int64 get publishTimestamp => $_getI64(6);
  @$pb.TagNumber(8)
  set publishTimestamp($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasPublishTimestamp() => $_has(6);
  @$pb.TagNumber(8)
  void clearPublishTimestamp() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get durationSeconds => $_getI64(7);
  @$pb.TagNumber(9)
  set durationSeconds($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasDurationSeconds() => $_has(7);
  @$pb.TagNumber(9)
  void clearDurationSeconds() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get episodeNumber => $_getI64(8);
  @$pb.TagNumber(10)
  set episodeNumber($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(10)
  $core.bool hasEpisodeNumber() => $_has(8);
  @$pb.TagNumber(10)
  void clearEpisodeNumber() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get explicit => $_getBF(9);
  @$pb.TagNumber(11)
  set explicit($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(11)
  $core.bool hasExplicit() => $_has(9);
  @$pb.TagNumber(11)
  void clearExplicit() => $_clearField(11);
}

class UserMessage extends $pb.GeneratedMessage {
  factory UserMessage({
    $core.String? id,
    $core.String? name,
    $core.String? email,
    $core.String? imageUrl,
    $core.Iterable<UserSubscriptionMessage>? subscriptions,
    $core.Iterable<UserListenMessage>? listens,
    $core.Iterable<UserFollowMessage>? following,
    $fixnum.Int64? numFollowers,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (email != null) {
      $result.email = email;
    }
    if (imageUrl != null) {
      $result.imageUrl = imageUrl;
    }
    if (subscriptions != null) {
      $result.subscriptions.addAll(subscriptions);
    }
    if (listens != null) {
      $result.listens.addAll(listens);
    }
    if (following != null) {
      $result.following.addAll(following);
    }
    if (numFollowers != null) {
      $result.numFollowers = numFollowers;
    }
    return $result;
  }
  UserMessage._() : super();
  factory UserMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'email')
    ..aOS(4, _omitFieldNames ? '' : 'imageUrl')
    ..pc<UserSubscriptionMessage>(5, _omitFieldNames ? '' : 'subscriptions', $pb.PbFieldType.PM, subBuilder: UserSubscriptionMessage.create)
    ..pc<UserListenMessage>(6, _omitFieldNames ? '' : 'listens', $pb.PbFieldType.PM, subBuilder: UserListenMessage.create)
    ..pc<UserFollowMessage>(7, _omitFieldNames ? '' : 'following', $pb.PbFieldType.PM, subBuilder: UserFollowMessage.create)
    ..aInt64(8, _omitFieldNames ? '' : 'numFollowers')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserMessage clone() => UserMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserMessage copyWith(void Function(UserMessage) updates) => super.copyWith((message) => updates(message as UserMessage)) as UserMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserMessage create() => UserMessage._();
  UserMessage createEmptyInstance() => create();
  static $pb.PbList<UserMessage> createRepeated() => $pb.PbList<UserMessage>();
  @$core.pragma('dart2js:noInline')
  static UserMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserMessage>(create);
  static UserMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get imageUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set imageUrl($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasImageUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearImageUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<UserSubscriptionMessage> get subscriptions => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbList<UserListenMessage> get listens => $_getList(5);

  @$pb.TagNumber(7)
  $pb.PbList<UserFollowMessage> get following => $_getList(6);

  @$pb.TagNumber(8)
  $fixnum.Int64 get numFollowers => $_getI64(7);
  @$pb.TagNumber(8)
  set numFollowers($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasNumFollowers() => $_has(7);
  @$pb.TagNumber(8)
  void clearNumFollowers() => $_clearField(8);
}

class UserFollowMessage extends $pb.GeneratedMessage {
  factory UserFollowMessage({
    $core.String? userId,
    $core.String? followedUserId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (followedUserId != null) {
      $result.followedUserId = followedUserId;
    }
    return $result;
  }
  UserFollowMessage._() : super();
  factory UserFollowMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserFollowMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserFollowMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'followedUserId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserFollowMessage clone() => UserFollowMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserFollowMessage copyWith(void Function(UserFollowMessage) updates) => super.copyWith((message) => updates(message as UserFollowMessage)) as UserFollowMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserFollowMessage create() => UserFollowMessage._();
  UserFollowMessage createEmptyInstance() => create();
  static $pb.PbList<UserFollowMessage> createRepeated() => $pb.PbList<UserFollowMessage>();
  @$core.pragma('dart2js:noInline')
  static UserFollowMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserFollowMessage>(create);
  static UserFollowMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get followedUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set followedUserId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFollowedUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFollowedUserId() => $_clearField(2);
}

class UserSubscriptionMessage extends $pb.GeneratedMessage {
  factory UserSubscriptionMessage({
    $core.String? userId,
    $core.String? podcastId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (podcastId != null) {
      $result.podcastId = podcastId;
    }
    return $result;
  }
  UserSubscriptionMessage._() : super();
  factory UserSubscriptionMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserSubscriptionMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserSubscriptionMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'podcastId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserSubscriptionMessage clone() => UserSubscriptionMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserSubscriptionMessage copyWith(void Function(UserSubscriptionMessage) updates) => super.copyWith((message) => updates(message as UserSubscriptionMessage)) as UserSubscriptionMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserSubscriptionMessage create() => UserSubscriptionMessage._();
  UserSubscriptionMessage createEmptyInstance() => create();
  static $pb.PbList<UserSubscriptionMessage> createRepeated() => $pb.PbList<UserSubscriptionMessage>();
  @$core.pragma('dart2js:noInline')
  static UserSubscriptionMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserSubscriptionMessage>(create);
  static UserSubscriptionMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get podcastId => $_getSZ(1);
  @$pb.TagNumber(2)
  set podcastId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPodcastId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPodcastId() => $_clearField(2);
}

class UserListenMessage extends $pb.GeneratedMessage {
  factory UserListenMessage({
    $core.String? userId,
    $core.String? episodeId,
    $fixnum.Int64? listenTimestamp,
    $fixnum.Int64? seconds,
    $core.bool? completed,
    EpisodeMessage? episode,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (episodeId != null) {
      $result.episodeId = episodeId;
    }
    if (listenTimestamp != null) {
      $result.listenTimestamp = listenTimestamp;
    }
    if (seconds != null) {
      $result.seconds = seconds;
    }
    if (completed != null) {
      $result.completed = completed;
    }
    if (episode != null) {
      $result.episode = episode;
    }
    return $result;
  }
  UserListenMessage._() : super();
  factory UserListenMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserListenMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserListenMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'episodeId')
    ..aInt64(3, _omitFieldNames ? '' : 'listenTimestamp')
    ..aInt64(4, _omitFieldNames ? '' : 'seconds')
    ..aOB(5, _omitFieldNames ? '' : 'completed')
    ..aOM<EpisodeMessage>(6, _omitFieldNames ? '' : 'episode', subBuilder: EpisodeMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserListenMessage clone() => UserListenMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserListenMessage copyWith(void Function(UserListenMessage) updates) => super.copyWith((message) => updates(message as UserListenMessage)) as UserListenMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserListenMessage create() => UserListenMessage._();
  UserListenMessage createEmptyInstance() => create();
  static $pb.PbList<UserListenMessage> createRepeated() => $pb.PbList<UserListenMessage>();
  @$core.pragma('dart2js:noInline')
  static UserListenMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserListenMessage>(create);
  static UserListenMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get episodeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set episodeId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEpisodeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearEpisodeId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get listenTimestamp => $_getI64(2);
  @$pb.TagNumber(3)
  set listenTimestamp($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasListenTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearListenTimestamp() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get seconds => $_getI64(3);
  @$pb.TagNumber(4)
  set seconds($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSeconds() => $_has(3);
  @$pb.TagNumber(4)
  void clearSeconds() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get completed => $_getBF(4);
  @$pb.TagNumber(5)
  set completed($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCompleted() => $_has(4);
  @$pb.TagNumber(5)
  void clearCompleted() => $_clearField(5);

  @$pb.TagNumber(6)
  EpisodeMessage get episode => $_getN(5);
  @$pb.TagNumber(6)
  set episode(EpisodeMessage v) { $_setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasEpisode() => $_has(5);
  @$pb.TagNumber(6)
  void clearEpisode() => $_clearField(6);
  @$pb.TagNumber(6)
  EpisodeMessage ensureEpisode() => $_ensure(5);
}

class UserFeedItemMessage extends $pb.GeneratedMessage {
  factory UserFeedItemMessage({
    EpisodeMessage? episode,
    UserListenMessage? listen,
  }) {
    final $result = create();
    if (episode != null) {
      $result.episode = episode;
    }
    if (listen != null) {
      $result.listen = listen;
    }
    return $result;
  }
  UserFeedItemMessage._() : super();
  factory UserFeedItemMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserFeedItemMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserFeedItemMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'), createEmptyInstance: create)
    ..aOM<EpisodeMessage>(1, _omitFieldNames ? '' : 'episode', subBuilder: EpisodeMessage.create)
    ..aOM<UserListenMessage>(2, _omitFieldNames ? '' : 'listen', subBuilder: UserListenMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserFeedItemMessage clone() => UserFeedItemMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserFeedItemMessage copyWith(void Function(UserFeedItemMessage) updates) => super.copyWith((message) => updates(message as UserFeedItemMessage)) as UserFeedItemMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserFeedItemMessage create() => UserFeedItemMessage._();
  UserFeedItemMessage createEmptyInstance() => create();
  static $pb.PbList<UserFeedItemMessage> createRepeated() => $pb.PbList<UserFeedItemMessage>();
  @$core.pragma('dart2js:noInline')
  static UserFeedItemMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserFeedItemMessage>(create);
  static UserFeedItemMessage? _defaultInstance;

  @$pb.TagNumber(1)
  EpisodeMessage get episode => $_getN(0);
  @$pb.TagNumber(1)
  set episode(EpisodeMessage v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasEpisode() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpisode() => $_clearField(1);
  @$pb.TagNumber(1)
  EpisodeMessage ensureEpisode() => $_ensure(0);

  @$pb.TagNumber(2)
  UserListenMessage get listen => $_getN(1);
  @$pb.TagNumber(2)
  set listen(UserListenMessage v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasListen() => $_has(1);
  @$pb.TagNumber(2)
  void clearListen() => $_clearField(2);
  @$pb.TagNumber(2)
  UserListenMessage ensureListen() => $_ensure(1);
}

class UserFeedMessage extends $pb.GeneratedMessage {
  factory UserFeedMessage({
    $core.String? userId,
    $core.Iterable<UserFeedItemMessage>? items,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (items != null) {
      $result.items.addAll(items);
    }
    return $result;
  }
  UserFeedMessage._() : super();
  factory UserFeedMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserFeedMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserFeedMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..pc<UserFeedItemMessage>(2, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM, subBuilder: UserFeedItemMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserFeedMessage clone() => UserFeedMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserFeedMessage copyWith(void Function(UserFeedMessage) updates) => super.copyWith((message) => updates(message as UserFeedMessage)) as UserFeedMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserFeedMessage create() => UserFeedMessage._();
  UserFeedMessage createEmptyInstance() => create();
  static $pb.PbList<UserFeedMessage> createRepeated() => $pb.PbList<UserFeedMessage>();
  @$core.pragma('dart2js:noInline')
  static UserFeedMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserFeedMessage>(create);
  static UserFeedMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<UserFeedItemMessage> get items => $_getList(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
