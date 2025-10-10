// This is a generated file - do not edit.
//
// Generated from proto/common.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class StorageMetadataMessage extends $pb.GeneratedMessage {
  factory StorageMetadataMessage({
    $core.bool? isDeleted,
    $fixnum.Int64? updatedTimestamp,
    $fixnum.Int64? createdTimestamp,
  }) {
    final result = create();
    if (isDeleted != null) result.isDeleted = isDeleted;
    if (updatedTimestamp != null) result.updatedTimestamp = updatedTimestamp;
    if (createdTimestamp != null) result.createdTimestamp = createdTimestamp;
    return result;
  }

  StorageMetadataMessage._();

  factory StorageMetadataMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StorageMetadataMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StorageMetadataMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isDeleted')
    ..aInt64(2, _omitFieldNames ? '' : 'updatedTimestamp')
    ..aInt64(3, _omitFieldNames ? '' : 'createdTimestamp')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StorageMetadataMessage clone() =>
      StorageMetadataMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StorageMetadataMessage copyWith(
          void Function(StorageMetadataMessage) updates) =>
      super.copyWith((message) => updates(message as StorageMetadataMessage))
          as StorageMetadataMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StorageMetadataMessage create() => StorageMetadataMessage._();
  @$core.override
  StorageMetadataMessage createEmptyInstance() => create();
  static $pb.PbList<StorageMetadataMessage> createRepeated() =>
      $pb.PbList<StorageMetadataMessage>();
  @$core.pragma('dart2js:noInline')
  static StorageMetadataMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StorageMetadataMessage>(create);
  static StorageMetadataMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isDeleted => $_getBF(0);
  @$pb.TagNumber(1)
  set isDeleted($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIsDeleted() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsDeleted() => $_clearField(1);

  /// In milliseconds since epoch, UTC time
  @$pb.TagNumber(2)
  $fixnum.Int64 get updatedTimestamp => $_getI64(1);
  @$pb.TagNumber(2)
  set updatedTimestamp($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUpdatedTimestamp() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdatedTimestamp() => $_clearField(2);

  /// In milliseconds since epoch, UTC time
  @$pb.TagNumber(3)
  $fixnum.Int64 get createdTimestamp => $_getI64(2);
  @$pb.TagNumber(3)
  set createdTimestamp($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCreatedTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreatedTimestamp() => $_clearField(3);
}

class PodcastMessage extends $pb.GeneratedMessage {
  factory PodcastMessage({
    $core.String? id,
    $core.String? title,
    $core.String? description,
    $core.String? url,
    $core.String? imageUrl,
    $core.String? author,
    $core.Iterable<EpisodeMessage>? episodes,
    StorageMetadataMessage? metadata,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (url != null) result.url = url;
    if (imageUrl != null) result.imageUrl = imageUrl;
    if (author != null) result.author = author;
    if (episodes != null) result.episodes.addAll(episodes);
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  PodcastMessage._();

  factory PodcastMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PodcastMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PodcastMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'url')
    ..aOS(5, _omitFieldNames ? '' : 'imageUrl')
    ..aOS(6, _omitFieldNames ? '' : 'author')
    ..pc<EpisodeMessage>(
        7, _omitFieldNames ? '' : 'episodes', $pb.PbFieldType.PM,
        subBuilder: EpisodeMessage.create)
    ..aOM<StorageMetadataMessage>(8, _omitFieldNames ? '' : 'metadata',
        subBuilder: StorageMetadataMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PodcastMessage clone() => PodcastMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PodcastMessage copyWith(void Function(PodcastMessage) updates) =>
      super.copyWith((message) => updates(message as PodcastMessage))
          as PodcastMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PodcastMessage create() => PodcastMessage._();
  @$core.override
  PodcastMessage createEmptyInstance() => create();
  static $pb.PbList<PodcastMessage> createRepeated() =>
      $pb.PbList<PodcastMessage>();
  @$core.pragma('dart2js:noInline')
  static PodcastMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PodcastMessage>(create);
  static PodcastMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get url => $_getSZ(3);
  @$pb.TagNumber(4)
  set url($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get imageUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set imageUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasImageUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearImageUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get author => $_getSZ(5);
  @$pb.TagNumber(6)
  set author($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAuthor() => $_has(5);
  @$pb.TagNumber(6)
  void clearAuthor() => $_clearField(6);

  /// this is optional
  @$pb.TagNumber(7)
  $pb.PbList<EpisodeMessage> get episodes => $_getList(6);

  @$pb.TagNumber(8)
  StorageMetadataMessage get metadata => $_getN(7);
  @$pb.TagNumber(8)
  set metadata(StorageMetadataMessage value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasMetadata() => $_has(7);
  @$pb.TagNumber(8)
  void clearMetadata() => $_clearField(8);
  @$pb.TagNumber(8)
  StorageMetadataMessage ensureMetadata() => $_ensure(7);
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
    StorageMetadataMessage? metadata,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (podcastId != null) result.podcastId = podcastId;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (audioUrl != null) result.audioUrl = audioUrl;
    if (imageUrl != null) result.imageUrl = imageUrl;
    if (publishTimestamp != null) result.publishTimestamp = publishTimestamp;
    if (durationSeconds != null) result.durationSeconds = durationSeconds;
    if (episodeNumber != null) result.episodeNumber = episodeNumber;
    if (explicit != null) result.explicit = explicit;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  EpisodeMessage._();

  factory EpisodeMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EpisodeMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EpisodeMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'),
      createEmptyInstance: create)
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
    ..aOM<StorageMetadataMessage>(12, _omitFieldNames ? '' : 'metadata',
        subBuilder: StorageMetadataMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EpisodeMessage clone() => EpisodeMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EpisodeMessage copyWith(void Function(EpisodeMessage) updates) =>
      super.copyWith((message) => updates(message as EpisodeMessage))
          as EpisodeMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EpisodeMessage create() => EpisodeMessage._();
  @$core.override
  EpisodeMessage createEmptyInstance() => create();
  static $pb.PbList<EpisodeMessage> createRepeated() =>
      $pb.PbList<EpisodeMessage>();
  @$core.pragma('dart2js:noInline')
  static EpisodeMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EpisodeMessage>(create);
  static EpisodeMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get podcastId => $_getSZ(1);
  @$pb.TagNumber(2)
  set podcastId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPodcastId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPodcastId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get audioUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set audioUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAudioUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearAudioUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get imageUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set imageUrl($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasImageUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearImageUrl() => $_clearField(6);

  @$pb.TagNumber(8)
  $fixnum.Int64 get publishTimestamp => $_getI64(6);
  @$pb.TagNumber(8)
  set publishTimestamp($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(8)
  $core.bool hasPublishTimestamp() => $_has(6);
  @$pb.TagNumber(8)
  void clearPublishTimestamp() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get durationSeconds => $_getI64(7);
  @$pb.TagNumber(9)
  set durationSeconds($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(9)
  $core.bool hasDurationSeconds() => $_has(7);
  @$pb.TagNumber(9)
  void clearDurationSeconds() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get episodeNumber => $_getI64(8);
  @$pb.TagNumber(10)
  set episodeNumber($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(10)
  $core.bool hasEpisodeNumber() => $_has(8);
  @$pb.TagNumber(10)
  void clearEpisodeNumber() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get explicit => $_getBF(9);
  @$pb.TagNumber(11)
  set explicit($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(11)
  $core.bool hasExplicit() => $_has(9);
  @$pb.TagNumber(11)
  void clearExplicit() => $_clearField(11);

  @$pb.TagNumber(12)
  StorageMetadataMessage get metadata => $_getN(10);
  @$pb.TagNumber(12)
  set metadata(StorageMetadataMessage value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasMetadata() => $_has(10);
  @$pb.TagNumber(12)
  void clearMetadata() => $_clearField(12);
  @$pb.TagNumber(12)
  StorageMetadataMessage ensureMetadata() => $_ensure(10);
}

class TokenMessage extends $pb.GeneratedMessage {
  factory TokenMessage({
    $core.String? token,
    $fixnum.Int64? expiryUtcTimestamp,
  }) {
    final result = create();
    if (token != null) result.token = token;
    if (expiryUtcTimestamp != null)
      result.expiryUtcTimestamp = expiryUtcTimestamp;
    return result;
  }

  TokenMessage._();

  factory TokenMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TokenMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TokenMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aInt64(2, _omitFieldNames ? '' : 'expiryUtcTimestamp')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TokenMessage clone() => TokenMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TokenMessage copyWith(void Function(TokenMessage) updates) =>
      super.copyWith((message) => updates(message as TokenMessage))
          as TokenMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TokenMessage create() => TokenMessage._();
  @$core.override
  TokenMessage createEmptyInstance() => create();
  static $pb.PbList<TokenMessage> createRepeated() =>
      $pb.PbList<TokenMessage>();
  @$core.pragma('dart2js:noInline')
  static TokenMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TokenMessage>(create);
  static TokenMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  /// timestamp in seconds, UTC time
  @$pb.TagNumber(2)
  $fixnum.Int64 get expiryUtcTimestamp => $_getI64(1);
  @$pb.TagNumber(2)
  set expiryUtcTimestamp($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasExpiryUtcTimestamp() => $_has(1);
  @$pb.TagNumber(2)
  void clearExpiryUtcTimestamp() => $_clearField(2);
}

class LoginAttempt extends $pb.GeneratedMessage {
  factory LoginAttempt({
    $core.String? id,
    $core.String? phoneNumber,
    $core.String? password,
    StorageMetadataMessage? metadata,
    $fixnum.Int64? expiryUtcTimestamp,
    $fixnum.Int64? numAttempts,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (password != null) result.password = password;
    if (metadata != null) result.metadata = metadata;
    if (expiryUtcTimestamp != null)
      result.expiryUtcTimestamp = expiryUtcTimestamp;
    if (numAttempts != null) result.numAttempts = numAttempts;
    return result;
  }

  LoginAttempt._();

  factory LoginAttempt.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LoginAttempt.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LoginAttempt',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(3, _omitFieldNames ? '' : 'password')
    ..aOM<StorageMetadataMessage>(4, _omitFieldNames ? '' : 'metadata',
        subBuilder: StorageMetadataMessage.create)
    ..aInt64(5, _omitFieldNames ? '' : 'expiryUtcTimestamp')
    ..aInt64(6, _omitFieldNames ? '' : 'numAttempts')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginAttempt clone() => LoginAttempt()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginAttempt copyWith(void Function(LoginAttempt) updates) =>
      super.copyWith((message) => updates(message as LoginAttempt))
          as LoginAttempt;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoginAttempt create() => LoginAttempt._();
  @$core.override
  LoginAttempt createEmptyInstance() => create();
  static $pb.PbList<LoginAttempt> createRepeated() =>
      $pb.PbList<LoginAttempt>();
  @$core.pragma('dart2js:noInline')
  static LoginAttempt getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LoginAttempt>(create);
  static LoginAttempt? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get phoneNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set phoneNumber($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPhoneNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearPhoneNumber() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get password => $_getSZ(2);
  @$pb.TagNumber(3)
  set password($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPassword() => $_has(2);
  @$pb.TagNumber(3)
  void clearPassword() => $_clearField(3);

  @$pb.TagNumber(4)
  StorageMetadataMessage get metadata => $_getN(3);
  @$pb.TagNumber(4)
  set metadata(StorageMetadataMessage value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasMetadata() => $_has(3);
  @$pb.TagNumber(4)
  void clearMetadata() => $_clearField(4);
  @$pb.TagNumber(4)
  StorageMetadataMessage ensureMetadata() => $_ensure(3);

  @$pb.TagNumber(5)
  $fixnum.Int64 get expiryUtcTimestamp => $_getI64(4);
  @$pb.TagNumber(5)
  set expiryUtcTimestamp($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasExpiryUtcTimestamp() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpiryUtcTimestamp() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get numAttempts => $_getI64(5);
  @$pb.TagNumber(6)
  set numAttempts($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasNumAttempts() => $_has(5);
  @$pb.TagNumber(6)
  void clearNumAttempts() => $_clearField(6);
}

class UserStorageMessage extends $pb.GeneratedMessage {
  factory UserStorageMessage({
    UserMessage? user,
    TokenMessage? accessToken,
    TokenMessage? refreshToken,
  }) {
    final result = create();
    if (user != null) result.user = user;
    if (accessToken != null) result.accessToken = accessToken;
    if (refreshToken != null) result.refreshToken = refreshToken;
    return result;
  }

  UserStorageMessage._();

  factory UserStorageMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserStorageMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserStorageMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'),
      createEmptyInstance: create)
    ..aOM<UserMessage>(1, _omitFieldNames ? '' : 'user',
        subBuilder: UserMessage.create)
    ..aOM<TokenMessage>(2, _omitFieldNames ? '' : 'accessToken',
        subBuilder: TokenMessage.create)
    ..aOM<TokenMessage>(3, _omitFieldNames ? '' : 'refreshToken',
        subBuilder: TokenMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserStorageMessage clone() => UserStorageMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserStorageMessage copyWith(void Function(UserStorageMessage) updates) =>
      super.copyWith((message) => updates(message as UserStorageMessage))
          as UserStorageMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserStorageMessage create() => UserStorageMessage._();
  @$core.override
  UserStorageMessage createEmptyInstance() => create();
  static $pb.PbList<UserStorageMessage> createRepeated() =>
      $pb.PbList<UserStorageMessage>();
  @$core.pragma('dart2js:noInline')
  static UserStorageMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserStorageMessage>(create);
  static UserStorageMessage? _defaultInstance;

  @$pb.TagNumber(1)
  UserMessage get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(UserMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  UserMessage ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  TokenMessage get accessToken => $_getN(1);
  @$pb.TagNumber(2)
  set accessToken(TokenMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAccessToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccessToken() => $_clearField(2);
  @$pb.TagNumber(2)
  TokenMessage ensureAccessToken() => $_ensure(1);

  @$pb.TagNumber(3)
  TokenMessage get refreshToken => $_getN(2);
  @$pb.TagNumber(3)
  set refreshToken(TokenMessage value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRefreshToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearRefreshToken() => $_clearField(3);
  @$pb.TagNumber(3)
  TokenMessage ensureRefreshToken() => $_ensure(2);
}

class RefreshTokensMessage extends $pb.GeneratedMessage {
  factory RefreshTokensMessage({
    $core.String? id,
    $core.String? userId,
    $core.Iterable<TokenMessage>? tokens,
    StorageMetadataMessage? metadata,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (tokens != null) result.tokens.addAll(tokens);
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  RefreshTokensMessage._();

  factory RefreshTokensMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RefreshTokensMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RefreshTokensMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..pc<TokenMessage>(3, _omitFieldNames ? '' : 'tokens', $pb.PbFieldType.PM,
        subBuilder: TokenMessage.create)
    ..aOM<StorageMetadataMessage>(4, _omitFieldNames ? '' : 'metadata',
        subBuilder: StorageMetadataMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshTokensMessage clone() =>
      RefreshTokensMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshTokensMessage copyWith(void Function(RefreshTokensMessage) updates) =>
      super.copyWith((message) => updates(message as RefreshTokensMessage))
          as RefreshTokensMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RefreshTokensMessage create() => RefreshTokensMessage._();
  @$core.override
  RefreshTokensMessage createEmptyInstance() => create();
  static $pb.PbList<RefreshTokensMessage> createRepeated() =>
      $pb.PbList<RefreshTokensMessage>();
  @$core.pragma('dart2js:noInline')
  static RefreshTokensMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RefreshTokensMessage>(create);
  static RefreshTokensMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<TokenMessage> get tokens => $_getList(2);

  @$pb.TagNumber(4)
  StorageMetadataMessage get metadata => $_getN(3);
  @$pb.TagNumber(4)
  set metadata(StorageMetadataMessage value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasMetadata() => $_has(3);
  @$pb.TagNumber(4)
  void clearMetadata() => $_clearField(4);
  @$pb.TagNumber(4)
  StorageMetadataMessage ensureMetadata() => $_ensure(3);
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
    StorageMetadataMessage? metadata,
    $core.String? phoneNumber,
    $core.String? encryptedPhoneNumber,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (email != null) result.email = email;
    if (imageUrl != null) result.imageUrl = imageUrl;
    if (subscriptions != null) result.subscriptions.addAll(subscriptions);
    if (listens != null) result.listens.addAll(listens);
    if (following != null) result.following.addAll(following);
    if (numFollowers != null) result.numFollowers = numFollowers;
    if (metadata != null) result.metadata = metadata;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (encryptedPhoneNumber != null)
      result.encryptedPhoneNumber = encryptedPhoneNumber;
    return result;
  }

  UserMessage._();

  factory UserMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'email')
    ..aOS(4, _omitFieldNames ? '' : 'imageUrl')
    ..pc<UserSubscriptionMessage>(
        5, _omitFieldNames ? '' : 'subscriptions', $pb.PbFieldType.PM,
        subBuilder: UserSubscriptionMessage.create)
    ..pc<UserListenMessage>(
        6, _omitFieldNames ? '' : 'listens', $pb.PbFieldType.PM,
        subBuilder: UserListenMessage.create)
    ..pc<UserFollowMessage>(
        7, _omitFieldNames ? '' : 'following', $pb.PbFieldType.PM,
        subBuilder: UserFollowMessage.create)
    ..aInt64(8, _omitFieldNames ? '' : 'numFollowers')
    ..aOM<StorageMetadataMessage>(9, _omitFieldNames ? '' : 'metadata',
        subBuilder: StorageMetadataMessage.create)
    ..aOS(10, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(11, _omitFieldNames ? '' : 'encryptedPhoneNumber')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserMessage clone() => UserMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserMessage copyWith(void Function(UserMessage) updates) =>
      super.copyWith((message) => updates(message as UserMessage))
          as UserMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserMessage create() => UserMessage._();
  @$core.override
  UserMessage createEmptyInstance() => create();
  static $pb.PbList<UserMessage> createRepeated() => $pb.PbList<UserMessage>();
  @$core.pragma('dart2js:noInline')
  static UserMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserMessage>(create);
  static UserMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => $_clearField(3);

  /// Should this be a data url?
  @$pb.TagNumber(4)
  $core.String get imageUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set imageUrl($core.String value) => $_setString(3, value);
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
  set numFollowers($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasNumFollowers() => $_has(7);
  @$pb.TagNumber(8)
  void clearNumFollowers() => $_clearField(8);

  @$pb.TagNumber(9)
  StorageMetadataMessage get metadata => $_getN(8);
  @$pb.TagNumber(9)
  set metadata(StorageMetadataMessage value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasMetadata() => $_has(8);
  @$pb.TagNumber(9)
  void clearMetadata() => $_clearField(9);
  @$pb.TagNumber(9)
  StorageMetadataMessage ensureMetadata() => $_ensure(8);

  /// What about country code, etc.
  /// TODO(duncan): Maybe I should just not store this?
  @$pb.TagNumber(10)
  $core.String get phoneNumber => $_getSZ(9);
  @$pb.TagNumber(10)
  set phoneNumber($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasPhoneNumber() => $_has(9);
  @$pb.TagNumber(10)
  void clearPhoneNumber() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get encryptedPhoneNumber => $_getSZ(10);
  @$pb.TagNumber(11)
  set encryptedPhoneNumber($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasEncryptedPhoneNumber() => $_has(10);
  @$pb.TagNumber(11)
  void clearEncryptedPhoneNumber() => $_clearField(11);
}

/// Stripped down UserMessage for more public consumption
/// eg. listens
class PublicUserMessage extends $pb.GeneratedMessage {
  factory PublicUserMessage({
    $core.String? id,
    $core.String? name,
    $core.String? imageUrl,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (imageUrl != null) result.imageUrl = imageUrl;
    return result;
  }

  PublicUserMessage._();

  factory PublicUserMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PublicUserMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PublicUserMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'imageUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublicUserMessage clone() => PublicUserMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublicUserMessage copyWith(void Function(PublicUserMessage) updates) =>
      super.copyWith((message) => updates(message as PublicUserMessage))
          as PublicUserMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PublicUserMessage create() => PublicUserMessage._();
  @$core.override
  PublicUserMessage createEmptyInstance() => create();
  static $pb.PbList<PublicUserMessage> createRepeated() =>
      $pb.PbList<PublicUserMessage>();
  @$core.pragma('dart2js:noInline')
  static PublicUserMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PublicUserMessage>(create);
  static PublicUserMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get imageUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set imageUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasImageUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearImageUrl() => $_clearField(3);
}

class UserFollowMessage extends $pb.GeneratedMessage {
  factory UserFollowMessage({
    $core.String? id,
    $core.String? userId,
    $core.String? followedUserId,
    StorageMetadataMessage? metadata,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (followedUserId != null) result.followedUserId = followedUserId;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  UserFollowMessage._();

  factory UserFollowMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserFollowMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserFollowMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'followedUserId')
    ..aOM<StorageMetadataMessage>(4, _omitFieldNames ? '' : 'metadata',
        subBuilder: StorageMetadataMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserFollowMessage clone() => UserFollowMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserFollowMessage copyWith(void Function(UserFollowMessage) updates) =>
      super.copyWith((message) => updates(message as UserFollowMessage))
          as UserFollowMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserFollowMessage create() => UserFollowMessage._();
  @$core.override
  UserFollowMessage createEmptyInstance() => create();
  static $pb.PbList<UserFollowMessage> createRepeated() =>
      $pb.PbList<UserFollowMessage>();
  @$core.pragma('dart2js:noInline')
  static UserFollowMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserFollowMessage>(create);
  static UserFollowMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get followedUserId => $_getSZ(2);
  @$pb.TagNumber(3)
  set followedUserId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFollowedUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearFollowedUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  StorageMetadataMessage get metadata => $_getN(3);
  @$pb.TagNumber(4)
  set metadata(StorageMetadataMessage value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasMetadata() => $_has(3);
  @$pb.TagNumber(4)
  void clearMetadata() => $_clearField(4);
  @$pb.TagNumber(4)
  StorageMetadataMessage ensureMetadata() => $_ensure(3);
}

class UserSubscriptionMessage extends $pb.GeneratedMessage {
  factory UserSubscriptionMessage({
    $core.String? id,
    $core.String? userId,
    $core.String? podcastId,
    StorageMetadataMessage? metadata,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (podcastId != null) result.podcastId = podcastId;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  UserSubscriptionMessage._();

  factory UserSubscriptionMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserSubscriptionMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserSubscriptionMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'podcastId')
    ..aOM<StorageMetadataMessage>(4, _omitFieldNames ? '' : 'metadata',
        subBuilder: StorageMetadataMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserSubscriptionMessage clone() =>
      UserSubscriptionMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserSubscriptionMessage copyWith(
          void Function(UserSubscriptionMessage) updates) =>
      super.copyWith((message) => updates(message as UserSubscriptionMessage))
          as UserSubscriptionMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserSubscriptionMessage create() => UserSubscriptionMessage._();
  @$core.override
  UserSubscriptionMessage createEmptyInstance() => create();
  static $pb.PbList<UserSubscriptionMessage> createRepeated() =>
      $pb.PbList<UserSubscriptionMessage>();
  @$core.pragma('dart2js:noInline')
  static UserSubscriptionMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserSubscriptionMessage>(create);
  static UserSubscriptionMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get podcastId => $_getSZ(2);
  @$pb.TagNumber(3)
  set podcastId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPodcastId() => $_has(2);
  @$pb.TagNumber(3)
  void clearPodcastId() => $_clearField(3);

  @$pb.TagNumber(4)
  StorageMetadataMessage get metadata => $_getN(3);
  @$pb.TagNumber(4)
  set metadata(StorageMetadataMessage value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasMetadata() => $_has(3);
  @$pb.TagNumber(4)
  void clearMetadata() => $_clearField(4);
  @$pb.TagNumber(4)
  StorageMetadataMessage ensureMetadata() => $_ensure(3);
}

class UserListenMessage extends $pb.GeneratedMessage {
  factory UserListenMessage({
    $core.String? id,
    $core.String? userId,
    $core.String? episodeId,
    $fixnum.Int64? listenTimestamp,
    $fixnum.Int64? seconds,
    $core.bool? completed,
    EpisodeMessage? episode,
    StorageMetadataMessage? metadata,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (episodeId != null) result.episodeId = episodeId;
    if (listenTimestamp != null) result.listenTimestamp = listenTimestamp;
    if (seconds != null) result.seconds = seconds;
    if (completed != null) result.completed = completed;
    if (episode != null) result.episode = episode;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  UserListenMessage._();

  factory UserListenMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserListenMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserListenMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'episodeId')
    ..aInt64(4, _omitFieldNames ? '' : 'listenTimestamp')
    ..aInt64(5, _omitFieldNames ? '' : 'seconds')
    ..aOB(6, _omitFieldNames ? '' : 'completed')
    ..aOM<EpisodeMessage>(7, _omitFieldNames ? '' : 'episode',
        subBuilder: EpisodeMessage.create)
    ..aOM<StorageMetadataMessage>(8, _omitFieldNames ? '' : 'metadata',
        subBuilder: StorageMetadataMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserListenMessage clone() => UserListenMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserListenMessage copyWith(void Function(UserListenMessage) updates) =>
      super.copyWith((message) => updates(message as UserListenMessage))
          as UserListenMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserListenMessage create() => UserListenMessage._();
  @$core.override
  UserListenMessage createEmptyInstance() => create();
  static $pb.PbList<UserListenMessage> createRepeated() =>
      $pb.PbList<UserListenMessage>();
  @$core.pragma('dart2js:noInline')
  static UserListenMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserListenMessage>(create);
  static UserListenMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get episodeId => $_getSZ(2);
  @$pb.TagNumber(3)
  set episodeId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEpisodeId() => $_has(2);
  @$pb.TagNumber(3)
  void clearEpisodeId() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get listenTimestamp => $_getI64(3);
  @$pb.TagNumber(4)
  set listenTimestamp($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasListenTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearListenTimestamp() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get seconds => $_getI64(4);
  @$pb.TagNumber(5)
  set seconds($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSeconds() => $_has(4);
  @$pb.TagNumber(5)
  void clearSeconds() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get completed => $_getBF(5);
  @$pb.TagNumber(6)
  set completed($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCompleted() => $_has(5);
  @$pb.TagNumber(6)
  void clearCompleted() => $_clearField(6);

  @$pb.TagNumber(7)
  EpisodeMessage get episode => $_getN(6);
  @$pb.TagNumber(7)
  set episode(EpisodeMessage value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasEpisode() => $_has(6);
  @$pb.TagNumber(7)
  void clearEpisode() => $_clearField(7);
  @$pb.TagNumber(7)
  EpisodeMessage ensureEpisode() => $_ensure(6);

  @$pb.TagNumber(8)
  StorageMetadataMessage get metadata => $_getN(7);
  @$pb.TagNumber(8)
  set metadata(StorageMetadataMessage value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasMetadata() => $_has(7);
  @$pb.TagNumber(8)
  void clearMetadata() => $_clearField(8);
  @$pb.TagNumber(8)
  StorageMetadataMessage ensureMetadata() => $_ensure(7);
}

class UserFeedItemEpisodeMessage extends $pb.GeneratedMessage {
  factory UserFeedItemEpisodeMessage({
    EpisodeMessage? episode,
    $core.Iterable<PublicUserMessage>? userListens,
  }) {
    final result = create();
    if (episode != null) result.episode = episode;
    if (userListens != null) result.userListens.addAll(userListens);
    return result;
  }

  UserFeedItemEpisodeMessage._();

  factory UserFeedItemEpisodeMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserFeedItemEpisodeMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserFeedItemEpisodeMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'),
      createEmptyInstance: create)
    ..aOM<EpisodeMessage>(1, _omitFieldNames ? '' : 'episode',
        subBuilder: EpisodeMessage.create)
    ..pc<PublicUserMessage>(
        2, _omitFieldNames ? '' : 'userListens', $pb.PbFieldType.PM,
        subBuilder: PublicUserMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserFeedItemEpisodeMessage clone() =>
      UserFeedItemEpisodeMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserFeedItemEpisodeMessage copyWith(
          void Function(UserFeedItemEpisodeMessage) updates) =>
      super.copyWith(
              (message) => updates(message as UserFeedItemEpisodeMessage))
          as UserFeedItemEpisodeMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserFeedItemEpisodeMessage create() => UserFeedItemEpisodeMessage._();
  @$core.override
  UserFeedItemEpisodeMessage createEmptyInstance() => create();
  static $pb.PbList<UserFeedItemEpisodeMessage> createRepeated() =>
      $pb.PbList<UserFeedItemEpisodeMessage>();
  @$core.pragma('dart2js:noInline')
  static UserFeedItemEpisodeMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserFeedItemEpisodeMessage>(create);
  static UserFeedItemEpisodeMessage? _defaultInstance;

  @$pb.TagNumber(1)
  EpisodeMessage get episode => $_getN(0);
  @$pb.TagNumber(1)
  set episode(EpisodeMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEpisode() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpisode() => $_clearField(1);
  @$pb.TagNumber(1)
  EpisodeMessage ensureEpisode() => $_ensure(0);

  /// These are social items relating to followed users
  @$pb.TagNumber(2)
  $pb.PbList<PublicUserMessage> get userListens => $_getList(1);
}

class UserFeedItemRecommendationMessage extends $pb.GeneratedMessage {
  factory UserFeedItemRecommendationMessage({
    EpisodeMessage? episode,
    PodcastMessage? podcast,
    $core.Iterable<PublicUserMessage>? userListens,
    $core.Iterable<PublicUserMessage>? userSubscriptions,
  }) {
    final result = create();
    if (episode != null) result.episode = episode;
    if (podcast != null) result.podcast = podcast;
    if (userListens != null) result.userListens.addAll(userListens);
    if (userSubscriptions != null)
      result.userSubscriptions.addAll(userSubscriptions);
    return result;
  }

  UserFeedItemRecommendationMessage._();

  factory UserFeedItemRecommendationMessage.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserFeedItemRecommendationMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserFeedItemRecommendationMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'),
      createEmptyInstance: create)
    ..aOM<EpisodeMessage>(1, _omitFieldNames ? '' : 'episode',
        subBuilder: EpisodeMessage.create)
    ..aOM<PodcastMessage>(2, _omitFieldNames ? '' : 'podcast',
        subBuilder: PodcastMessage.create)
    ..pc<PublicUserMessage>(
        3, _omitFieldNames ? '' : 'userListens', $pb.PbFieldType.PM,
        subBuilder: PublicUserMessage.create)
    ..pc<PublicUserMessage>(
        4, _omitFieldNames ? '' : 'userSubscriptions', $pb.PbFieldType.PM,
        subBuilder: PublicUserMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserFeedItemRecommendationMessage clone() =>
      UserFeedItemRecommendationMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserFeedItemRecommendationMessage copyWith(
          void Function(UserFeedItemRecommendationMessage) updates) =>
      super.copyWith((message) =>
              updates(message as UserFeedItemRecommendationMessage))
          as UserFeedItemRecommendationMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserFeedItemRecommendationMessage create() =>
      UserFeedItemRecommendationMessage._();
  @$core.override
  UserFeedItemRecommendationMessage createEmptyInstance() => create();
  static $pb.PbList<UserFeedItemRecommendationMessage> createRepeated() =>
      $pb.PbList<UserFeedItemRecommendationMessage>();
  @$core.pragma('dart2js:noInline')
  static UserFeedItemRecommendationMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserFeedItemRecommendationMessage>(
          create);
  static UserFeedItemRecommendationMessage? _defaultInstance;

  @$pb.TagNumber(1)
  EpisodeMessage get episode => $_getN(0);
  @$pb.TagNumber(1)
  set episode(EpisodeMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEpisode() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpisode() => $_clearField(1);
  @$pb.TagNumber(1)
  EpisodeMessage ensureEpisode() => $_ensure(0);

  @$pb.TagNumber(2)
  PodcastMessage get podcast => $_getN(1);
  @$pb.TagNumber(2)
  set podcast(PodcastMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPodcast() => $_has(1);
  @$pb.TagNumber(2)
  void clearPodcast() => $_clearField(2);
  @$pb.TagNumber(2)
  PodcastMessage ensurePodcast() => $_ensure(1);

  @$pb.TagNumber(3)
  $pb.PbList<PublicUserMessage> get userListens => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<PublicUserMessage> get userSubscriptions => $_getList(3);
}

class UserFeedItemMessage extends $pb.GeneratedMessage {
  factory UserFeedItemMessage({
    UserFeedItemEpisodeMessage? episodeItem,
    $core.Iterable<UserFeedItemRecommendationMessage>? recommendedItems,
  }) {
    final result = create();
    if (episodeItem != null) result.episodeItem = episodeItem;
    if (recommendedItems != null)
      result.recommendedItems.addAll(recommendedItems);
    return result;
  }

  UserFeedItemMessage._();

  factory UserFeedItemMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserFeedItemMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserFeedItemMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'),
      createEmptyInstance: create)
    ..aOM<UserFeedItemEpisodeMessage>(1, _omitFieldNames ? '' : 'episodeItem',
        subBuilder: UserFeedItemEpisodeMessage.create)
    ..pc<UserFeedItemRecommendationMessage>(
        2, _omitFieldNames ? '' : 'recommendedItems', $pb.PbFieldType.PM,
        subBuilder: UserFeedItemRecommendationMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserFeedItemMessage clone() => UserFeedItemMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserFeedItemMessage copyWith(void Function(UserFeedItemMessage) updates) =>
      super.copyWith((message) => updates(message as UserFeedItemMessage))
          as UserFeedItemMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserFeedItemMessage create() => UserFeedItemMessage._();
  @$core.override
  UserFeedItemMessage createEmptyInstance() => create();
  static $pb.PbList<UserFeedItemMessage> createRepeated() =>
      $pb.PbList<UserFeedItemMessage>();
  @$core.pragma('dart2js:noInline')
  static UserFeedItemMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserFeedItemMessage>(create);
  static UserFeedItemMessage? _defaultInstance;

  @$pb.TagNumber(1)
  UserFeedItemEpisodeMessage get episodeItem => $_getN(0);
  @$pb.TagNumber(1)
  set episodeItem(UserFeedItemEpisodeMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEpisodeItem() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpisodeItem() => $_clearField(1);
  @$pb.TagNumber(1)
  UserFeedItemEpisodeMessage ensureEpisodeItem() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<UserFeedItemRecommendationMessage> get recommendedItems =>
      $_getList(1);
}

class UserFeedMessage extends $pb.GeneratedMessage {
  factory UserFeedMessage({
    $core.String? userId,
    $core.Iterable<UserFeedItemMessage>? items,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (items != null) result.items.addAll(items);
    return result;
  }

  UserFeedMessage._();

  factory UserFeedMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserFeedMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserFeedMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..pc<UserFeedItemMessage>(
        2, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM,
        subBuilder: UserFeedItemMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserFeedMessage clone() => UserFeedMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserFeedMessage copyWith(void Function(UserFeedMessage) updates) =>
      super.copyWith((message) => updates(message as UserFeedMessage))
          as UserFeedMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserFeedMessage create() => UserFeedMessage._();
  @$core.override
  UserFeedMessage createEmptyInstance() => create();
  static $pb.PbList<UserFeedMessage> createRepeated() =>
      $pb.PbList<UserFeedMessage>();
  @$core.pragma('dart2js:noInline')
  static UserFeedMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserFeedMessage>(create);
  static UserFeedMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<UserFeedItemMessage> get items => $_getList(1);
}

/// Search Results
class SearchResultMessage extends $pb.GeneratedMessage {
  factory SearchResultMessage({
    PodcastMessage? podcast,
    UserMessage? user,
    EpisodeMessage? episode,
  }) {
    final result = create();
    if (podcast != null) result.podcast = podcast;
    if (user != null) result.user = user;
    if (episode != null) result.episode = episode;
    return result;
  }

  SearchResultMessage._();

  factory SearchResultMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchResultMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchResultMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'),
      createEmptyInstance: create)
    ..aOM<PodcastMessage>(1, _omitFieldNames ? '' : 'podcast',
        subBuilder: PodcastMessage.create)
    ..aOM<UserMessage>(2, _omitFieldNames ? '' : 'user',
        subBuilder: UserMessage.create)
    ..aOM<EpisodeMessage>(3, _omitFieldNames ? '' : 'episode',
        subBuilder: EpisodeMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchResultMessage clone() => SearchResultMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchResultMessage copyWith(void Function(SearchResultMessage) updates) =>
      super.copyWith((message) => updates(message as SearchResultMessage))
          as SearchResultMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchResultMessage create() => SearchResultMessage._();
  @$core.override
  SearchResultMessage createEmptyInstance() => create();
  static $pb.PbList<SearchResultMessage> createRepeated() =>
      $pb.PbList<SearchResultMessage>();
  @$core.pragma('dart2js:noInline')
  static SearchResultMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchResultMessage>(create);
  static SearchResultMessage? _defaultInstance;

  /// Only one of these should be filled out
  @$pb.TagNumber(1)
  PodcastMessage get podcast => $_getN(0);
  @$pb.TagNumber(1)
  set podcast(PodcastMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPodcast() => $_has(0);
  @$pb.TagNumber(1)
  void clearPodcast() => $_clearField(1);
  @$pb.TagNumber(1)
  PodcastMessage ensurePodcast() => $_ensure(0);

  @$pb.TagNumber(2)
  UserMessage get user => $_getN(1);
  @$pb.TagNumber(2)
  set user(UserMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearUser() => $_clearField(2);
  @$pb.TagNumber(2)
  UserMessage ensureUser() => $_ensure(1);

  @$pb.TagNumber(3)
  EpisodeMessage get episode => $_getN(2);
  @$pb.TagNumber(3)
  set episode(EpisodeMessage value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasEpisode() => $_has(2);
  @$pb.TagNumber(3)
  void clearEpisode() => $_clearField(3);
  @$pb.TagNumber(3)
  EpisodeMessage ensureEpisode() => $_ensure(2);
}

class SearchResultsMessage extends $pb.GeneratedMessage {
  factory SearchResultsMessage({
    $core.Iterable<SearchResultMessage>? results,
  }) {
    final result = create();
    if (results != null) result.results.addAll(results);
    return result;
  }

  SearchResultsMessage._();

  factory SearchResultsMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchResultsMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchResultsMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'),
      createEmptyInstance: create)
    ..pc<SearchResultMessage>(
        1, _omitFieldNames ? '' : 'results', $pb.PbFieldType.PM,
        subBuilder: SearchResultMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchResultsMessage clone() =>
      SearchResultsMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchResultsMessage copyWith(void Function(SearchResultsMessage) updates) =>
      super.copyWith((message) => updates(message as SearchResultsMessage))
          as SearchResultsMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchResultsMessage create() => SearchResultsMessage._();
  @$core.override
  SearchResultsMessage createEmptyInstance() => create();
  static $pb.PbList<SearchResultsMessage> createRepeated() =>
      $pb.PbList<SearchResultsMessage>();
  @$core.pragma('dart2js:noInline')
  static SearchResultsMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchResultsMessage>(create);
  static SearchResultsMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SearchResultMessage> get results => $_getList(0);
}

class UserDownloadMessage extends $pb.GeneratedMessage {
  factory UserDownloadMessage({
    $core.String? id,
    $core.String? episodeId,
    $core.String? filePath,
    $core.bool? isDownloaded,
    StorageMetadataMessage? metadata,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (episodeId != null) result.episodeId = episodeId;
    if (filePath != null) result.filePath = filePath;
    if (isDownloaded != null) result.isDownloaded = isDownloaded;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  UserDownloadMessage._();

  factory UserDownloadMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserDownloadMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserDownloadMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'episodeId')
    ..aOS(3, _omitFieldNames ? '' : 'filePath')
    ..aOB(4, _omitFieldNames ? '' : 'isDownloaded')
    ..aOM<StorageMetadataMessage>(5, _omitFieldNames ? '' : 'metadata',
        subBuilder: StorageMetadataMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserDownloadMessage clone() => UserDownloadMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserDownloadMessage copyWith(void Function(UserDownloadMessage) updates) =>
      super.copyWith((message) => updates(message as UserDownloadMessage))
          as UserDownloadMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserDownloadMessage create() => UserDownloadMessage._();
  @$core.override
  UserDownloadMessage createEmptyInstance() => create();
  static $pb.PbList<UserDownloadMessage> createRepeated() =>
      $pb.PbList<UserDownloadMessage>();
  @$core.pragma('dart2js:noInline')
  static UserDownloadMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserDownloadMessage>(create);
  static UserDownloadMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get episodeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set episodeId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEpisodeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearEpisodeId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get filePath => $_getSZ(2);
  @$pb.TagNumber(3)
  set filePath($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFilePath() => $_has(2);
  @$pb.TagNumber(3)
  void clearFilePath() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isDownloaded => $_getBF(3);
  @$pb.TagNumber(4)
  set isDownloaded($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIsDownloaded() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsDownloaded() => $_clearField(4);

  @$pb.TagNumber(5)
  StorageMetadataMessage get metadata => $_getN(4);
  @$pb.TagNumber(5)
  set metadata(StorageMetadataMessage value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasMetadata() => $_has(4);
  @$pb.TagNumber(5)
  void clearMetadata() => $_clearField(5);
  @$pb.TagNumber(5)
  StorageMetadataMessage ensureMetadata() => $_ensure(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
