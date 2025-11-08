// This is a generated file - do not edit.
//
// Generated from proto/common.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use storageMetadataMessageDescriptor instead')
const StorageMetadataMessage$json = {
  '1': 'StorageMetadataMessage',
  '2': [
    {'1': 'is_deleted', '3': 1, '4': 1, '5': 8, '10': 'isDeleted'},
    {
      '1': 'updated_timestamp',
      '3': 2,
      '4': 1,
      '5': 3,
      '10': 'updatedTimestamp'
    },
    {
      '1': 'created_timestamp',
      '3': 3,
      '4': 1,
      '5': 3,
      '10': 'createdTimestamp'
    },
  ],
};

/// Descriptor for `StorageMetadataMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storageMetadataMessageDescriptor = $convert.base64Decode(
    'ChZTdG9yYWdlTWV0YWRhdGFNZXNzYWdlEh0KCmlzX2RlbGV0ZWQYASABKAhSCWlzRGVsZXRlZB'
    'IrChF1cGRhdGVkX3RpbWVzdGFtcBgCIAEoA1IQdXBkYXRlZFRpbWVzdGFtcBIrChFjcmVhdGVk'
    'X3RpbWVzdGFtcBgDIAEoA1IQY3JlYXRlZFRpbWVzdGFtcA==');

@$core.Deprecated('Use podcastMessageDescriptor instead')
const PodcastMessage$json = {
  '1': 'PodcastMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'url', '3': 4, '4': 1, '5': 9, '10': 'url'},
    {'1': 'image_url', '3': 5, '4': 1, '5': 9, '10': 'imageUrl'},
    {'1': 'author', '3': 6, '4': 1, '5': 9, '8': {}, '10': 'author'},
    {
      '1': 'episodes',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.resonate.EpisodeMessage',
      '10': 'episodes'
    },
    {
      '1': 'metadata',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.resonate.StorageMetadataMessage',
      '10': 'metadata'
    },
    {
      '1': 'latest_episode_timestamp',
      '3': 9,
      '4': 1,
      '5': 3,
      '8': {},
      '10': 'latestEpisodeTimestamp'
    },
    {
      '1': 'last_fetch_timestamp',
      '3': 10,
      '4': 1,
      '5': 3,
      '8': {},
      '10': 'lastFetchTimestamp'
    },
  ],
};

/// Descriptor for `PodcastMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List podcastMessageDescriptor = $convert.base64Decode(
    'Cg5Qb2RjYXN0TWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSGgoFdGl0bGUYAiABKAlCBIC1GAFSBX'
    'RpdGxlEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIQCgN1cmwYBCABKAlSA3Vy'
    'bBIbCglpbWFnZV91cmwYBSABKAlSCGltYWdlVXJsEhwKBmF1dGhvchgGIAEoCUIEgLUYAVIGYX'
    'V0aG9yEjQKCGVwaXNvZGVzGAcgAygLMhgucmVzb25hdGUuRXBpc29kZU1lc3NhZ2VSCGVwaXNv'
    'ZGVzEjwKCG1ldGFkYXRhGAggASgLMiAucmVzb25hdGUuU3RvcmFnZU1ldGFkYXRhTWVzc2FnZV'
    'IIbWV0YWRhdGESPgoYbGF0ZXN0X2VwaXNvZGVfdGltZXN0YW1wGAkgASgDQgSAtRgBUhZsYXRl'
    'c3RFcGlzb2RlVGltZXN0YW1wEjYKFGxhc3RfZmV0Y2hfdGltZXN0YW1wGAogASgDQgSAtRgBUh'
    'JsYXN0RmV0Y2hUaW1lc3RhbXA=');

@$core.Deprecated('Use episodeMessageDescriptor instead')
const EpisodeMessage$json = {
  '1': 'EpisodeMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'podcast_id', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'podcastId'},
    {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'audio_url', '3': 5, '4': 1, '5': 9, '10': 'audioUrl'},
    {'1': 'image_url', '3': 6, '4': 1, '5': 9, '10': 'imageUrl'},
    {
      '1': 'publish_timestamp',
      '3': 8,
      '4': 1,
      '5': 3,
      '8': {},
      '10': 'publishTimestamp'
    },
    {'1': 'duration_seconds', '3': 9, '4': 1, '5': 3, '10': 'durationSeconds'},
    {'1': 'episode_number', '3': 10, '4': 1, '5': 3, '10': 'episodeNumber'},
    {'1': 'explicit', '3': 11, '4': 1, '5': 8, '10': 'explicit'},
    {
      '1': 'metadata',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.resonate.StorageMetadataMessage',
      '10': 'metadata'
    },
  ],
};

/// Descriptor for `EpisodeMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List episodeMessageDescriptor = $convert.base64Decode(
    'Cg5FcGlzb2RlTWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSIwoKcG9kY2FzdF9pZBgCIAEoCUIEgL'
    'UYAVIJcG9kY2FzdElkEhQKBXRpdGxlGAMgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgEIAEo'
    'CVILZGVzY3JpcHRpb24SGwoJYXVkaW9fdXJsGAUgASgJUghhdWRpb1VybBIbCglpbWFnZV91cm'
    'wYBiABKAlSCGltYWdlVXJsEjEKEXB1Ymxpc2hfdGltZXN0YW1wGAggASgDQgSAtRgBUhBwdWJs'
    'aXNoVGltZXN0YW1wEikKEGR1cmF0aW9uX3NlY29uZHMYCSABKANSD2R1cmF0aW9uU2Vjb25kcx'
    'IlCg5lcGlzb2RlX251bWJlchgKIAEoA1INZXBpc29kZU51bWJlchIaCghleHBsaWNpdBgLIAEo'
    'CFIIZXhwbGljaXQSPAoIbWV0YWRhdGEYDCABKAsyIC5yZXNvbmF0ZS5TdG9yYWdlTWV0YWRhdG'
    'FNZXNzYWdlUghtZXRhZGF0YQ==');

@$core.Deprecated('Use tokenMessageDescriptor instead')
const TokenMessage$json = {
  '1': 'TokenMessage',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {
      '1': 'expiry_utc_timestamp',
      '3': 2,
      '4': 1,
      '5': 3,
      '10': 'expiryUtcTimestamp'
    },
  ],
};

/// Descriptor for `TokenMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tokenMessageDescriptor = $convert.base64Decode(
    'CgxUb2tlbk1lc3NhZ2USFAoFdG9rZW4YASABKAlSBXRva2VuEjAKFGV4cGlyeV91dGNfdGltZX'
    'N0YW1wGAIgASgDUhJleHBpcnlVdGNUaW1lc3RhbXA=');

@$core.Deprecated('Use loginAttemptDescriptor instead')
const LoginAttempt$json = {
  '1': 'LoginAttempt',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'phone_number', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'phoneNumber'},
    {'1': 'password', '3': 3, '4': 1, '5': 9, '10': 'password'},
    {
      '1': 'metadata',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.resonate.StorageMetadataMessage',
      '10': 'metadata'
    },
    {
      '1': 'expiry_utc_timestamp',
      '3': 5,
      '4': 1,
      '5': 3,
      '10': 'expiryUtcTimestamp'
    },
    {'1': 'num_attempts', '3': 6, '4': 1, '5': 3, '10': 'numAttempts'},
  ],
};

/// Descriptor for `LoginAttempt`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginAttemptDescriptor = $convert.base64Decode(
    'CgxMb2dpbkF0dGVtcHQSDgoCaWQYASABKAlSAmlkEicKDHBob25lX251bWJlchgCIAEoCUIEgL'
    'UYAVILcGhvbmVOdW1iZXISGgoIcGFzc3dvcmQYAyABKAlSCHBhc3N3b3JkEjwKCG1ldGFkYXRh'
    'GAQgASgLMiAucmVzb25hdGUuU3RvcmFnZU1ldGFkYXRhTWVzc2FnZVIIbWV0YWRhdGESMAoUZX'
    'hwaXJ5X3V0Y190aW1lc3RhbXAYBSABKANSEmV4cGlyeVV0Y1RpbWVzdGFtcBIhCgxudW1fYXR0'
    'ZW1wdHMYBiABKANSC251bUF0dGVtcHRz');

@$core.Deprecated('Use userStorageMessageDescriptor instead')
const UserStorageMessage$json = {
  '1': 'UserStorageMessage',
  '2': [
    {
      '1': 'user',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.UserMessage',
      '10': 'user'
    },
    {
      '1': 'access_token',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.TokenMessage',
      '10': 'accessToken'
    },
    {
      '1': 'refresh_token',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.resonate.TokenMessage',
      '10': 'refreshToken'
    },
  ],
};

/// Descriptor for `UserStorageMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userStorageMessageDescriptor = $convert.base64Decode(
    'ChJVc2VyU3RvcmFnZU1lc3NhZ2USKQoEdXNlchgBIAEoCzIVLnJlc29uYXRlLlVzZXJNZXNzYW'
    'dlUgR1c2VyEjkKDGFjY2Vzc190b2tlbhgCIAEoCzIWLnJlc29uYXRlLlRva2VuTWVzc2FnZVIL'
    'YWNjZXNzVG9rZW4SOwoNcmVmcmVzaF90b2tlbhgDIAEoCzIWLnJlc29uYXRlLlRva2VuTWVzc2'
    'FnZVIMcmVmcmVzaFRva2Vu');

@$core.Deprecated('Use refreshTokensMessageDescriptor instead')
const RefreshTokensMessage$json = {
  '1': 'RefreshTokensMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'userId'},
    {
      '1': 'tokens',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.resonate.TokenMessage',
      '10': 'tokens'
    },
    {
      '1': 'metadata',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.resonate.StorageMetadataMessage',
      '10': 'metadata'
    },
  ],
};

/// Descriptor for `RefreshTokensMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshTokensMessageDescriptor = $convert.base64Decode(
    'ChRSZWZyZXNoVG9rZW5zTWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSHQoHdXNlcl9pZBgCIAEoCU'
    'IEgLUYAVIGdXNlcklkEi4KBnRva2VucxgDIAMoCzIWLnJlc29uYXRlLlRva2VuTWVzc2FnZVIG'
    'dG9rZW5zEjwKCG1ldGFkYXRhGAQgASgLMiAucmVzb25hdGUuU3RvcmFnZU1ldGFkYXRhTWVzc2'
    'FnZVIIbWV0YWRhdGE=');

@$core.Deprecated('Use userMessageDescriptor instead')
const UserMessage$json = {
  '1': 'UserMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    {'1': 'phone_number', '3': 10, '4': 1, '5': 9, '10': 'phoneNumber'},
    {
      '1': 'encrypted_phone_number',
      '3': 11,
      '4': 1,
      '5': 9,
      '10': 'encryptedPhoneNumber'
    },
    {'1': 'image_url', '3': 4, '4': 1, '5': 9, '10': 'imageUrl'},
    {
      '1': 'subscriptions',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.resonate.UserSubscriptionMessage',
      '10': 'subscriptions'
    },
    {
      '1': 'listens',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.resonate.UserListenMessage',
      '10': 'listens'
    },
    {
      '1': 'following',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.resonate.UserFollowMessage',
      '10': 'following'
    },
    {'1': 'num_followers', '3': 8, '4': 1, '5': 3, '10': 'numFollowers'},
    {
      '1': 'metadata',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.resonate.StorageMetadataMessage',
      '10': 'metadata'
    },
  ],
};

/// Descriptor for `UserMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userMessageDescriptor = $convert.base64Decode(
    'CgtVc2VyTWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIUCgVlbW'
    'FpbBgDIAEoCVIFZW1haWwSIQoMcGhvbmVfbnVtYmVyGAogASgJUgtwaG9uZU51bWJlchI0ChZl'
    'bmNyeXB0ZWRfcGhvbmVfbnVtYmVyGAsgASgJUhRlbmNyeXB0ZWRQaG9uZU51bWJlchIbCglpbW'
    'FnZV91cmwYBCABKAlSCGltYWdlVXJsEkcKDXN1YnNjcmlwdGlvbnMYBSADKAsyIS5yZXNvbmF0'
    'ZS5Vc2VyU3Vic2NyaXB0aW9uTWVzc2FnZVINc3Vic2NyaXB0aW9ucxI1CgdsaXN0ZW5zGAYgAy'
    'gLMhsucmVzb25hdGUuVXNlckxpc3Rlbk1lc3NhZ2VSB2xpc3RlbnMSOQoJZm9sbG93aW5nGAcg'
    'AygLMhsucmVzb25hdGUuVXNlckZvbGxvd01lc3NhZ2VSCWZvbGxvd2luZxIjCg1udW1fZm9sbG'
    '93ZXJzGAggASgDUgxudW1Gb2xsb3dlcnMSPAoIbWV0YWRhdGEYCSABKAsyIC5yZXNvbmF0ZS5T'
    'dG9yYWdlTWV0YWRhdGFNZXNzYWdlUghtZXRhZGF0YQ==');

@$core.Deprecated('Use publicUserMessageDescriptor instead')
const PublicUserMessage$json = {
  '1': 'PublicUserMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'image_url', '3': 3, '4': 1, '5': 9, '10': 'imageUrl'},
  ],
};

/// Descriptor for `PublicUserMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publicUserMessageDescriptor = $convert.base64Decode(
    'ChFQdWJsaWNVc2VyTWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZR'
    'IbCglpbWFnZV91cmwYAyABKAlSCGltYWdlVXJs');

@$core.Deprecated('Use userFollowMessageDescriptor instead')
const UserFollowMessage$json = {
  '1': 'UserFollowMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'userId'},
    {
      '1': 'followed_user_id',
      '3': 3,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'followedUserId'
    },
    {
      '1': 'follow_utc_timestamp_ms',
      '3': 4,
      '4': 1,
      '5': 3,
      '10': 'followUtcTimestampMs'
    },
    {
      '1': 'metadata',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.resonate.StorageMetadataMessage',
      '10': 'metadata'
    },
    {
      '1': 'user',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.resonate.PublicUserMessage',
      '10': 'user'
    },
  ],
};

/// Descriptor for `UserFollowMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userFollowMessageDescriptor = $convert.base64Decode(
    'ChFVc2VyRm9sbG93TWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSHQoHdXNlcl9pZBgCIAEoCUIEgL'
    'UYAVIGdXNlcklkEi4KEGZvbGxvd2VkX3VzZXJfaWQYAyABKAlCBIC1GAFSDmZvbGxvd2VkVXNl'
    'cklkEjUKF2ZvbGxvd191dGNfdGltZXN0YW1wX21zGAQgASgDUhRmb2xsb3dVdGNUaW1lc3RhbX'
    'BNcxI8CghtZXRhZGF0YRgFIAEoCzIgLnJlc29uYXRlLlN0b3JhZ2VNZXRhZGF0YU1lc3NhZ2VS'
    'CG1ldGFkYXRhEi8KBHVzZXIYBiABKAsyGy5yZXNvbmF0ZS5QdWJsaWNVc2VyTWVzc2FnZVIEdX'
    'Nlcg==');

@$core.Deprecated('Use userSubscriptionMessageDescriptor instead')
const UserSubscriptionMessage$json = {
  '1': 'UserSubscriptionMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'userId'},
    {'1': 'podcast_id', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'podcastId'},
    {
      '1': 'metadata',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.resonate.StorageMetadataMessage',
      '10': 'metadata'
    },
    {
      '1': 'podcast',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.resonate.PodcastMessage',
      '10': 'podcast'
    },
  ],
};

/// Descriptor for `UserSubscriptionMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userSubscriptionMessageDescriptor = $convert.base64Decode(
    'ChdVc2VyU3Vic2NyaXB0aW9uTWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSHQoHdXNlcl9pZBgCIA'
    'EoCUIEgLUYAVIGdXNlcklkEiMKCnBvZGNhc3RfaWQYAyABKAlCBIC1GAFSCXBvZGNhc3RJZBI8'
    'CghtZXRhZGF0YRgEIAEoCzIgLnJlc29uYXRlLlN0b3JhZ2VNZXRhZGF0YU1lc3NhZ2VSCG1ldG'
    'FkYXRhEjIKB3BvZGNhc3QYBSABKAsyGC5yZXNvbmF0ZS5Qb2RjYXN0TWVzc2FnZVIHcG9kY2Fz'
    'dA==');

@$core.Deprecated('Use userListenMessageDescriptor instead')
const UserListenMessage$json = {
  '1': 'UserListenMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'userId'},
    {'1': 'episode_id', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'episodeId'},
    {
      '1': 'listen_timestamp',
      '3': 4,
      '4': 1,
      '5': 3,
      '8': {},
      '10': 'listenTimestamp'
    },
    {'1': 'seconds', '3': 5, '4': 1, '5': 3, '10': 'seconds'},
    {'1': 'completed', '3': 6, '4': 1, '5': 8, '8': {}, '10': 'completed'},
    {
      '1': 'episode',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.resonate.EpisodeMessage',
      '10': 'episode'
    },
    {
      '1': 'metadata',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.resonate.StorageMetadataMessage',
      '10': 'metadata'
    },
  ],
};

/// Descriptor for `UserListenMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userListenMessageDescriptor = $convert.base64Decode(
    'ChFVc2VyTGlzdGVuTWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSHQoHdXNlcl9pZBgCIAEoCUIEgL'
    'UYAVIGdXNlcklkEiMKCmVwaXNvZGVfaWQYAyABKAlCBIC1GAFSCWVwaXNvZGVJZBIvChBsaXN0'
    'ZW5fdGltZXN0YW1wGAQgASgDQgSAtRgBUg9saXN0ZW5UaW1lc3RhbXASGAoHc2Vjb25kcxgFIA'
    'EoA1IHc2Vjb25kcxIiCgljb21wbGV0ZWQYBiABKAhCBIC1GAFSCWNvbXBsZXRlZBIyCgdlcGlz'
    'b2RlGAcgASgLMhgucmVzb25hdGUuRXBpc29kZU1lc3NhZ2VSB2VwaXNvZGUSPAoIbWV0YWRhdG'
    'EYCCABKAsyIC5yZXNvbmF0ZS5TdG9yYWdlTWV0YWRhdGFNZXNzYWdlUghtZXRhZGF0YQ==');

@$core.Deprecated('Use userFeedItemEpisodeMessageDescriptor instead')
const UserFeedItemEpisodeMessage$json = {
  '1': 'UserFeedItemEpisodeMessage',
  '2': [
    {
      '1': 'episode',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.EpisodeMessage',
      '10': 'episode'
    },
    {
      '1': 'user_listens',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.resonate.PublicUserMessage',
      '10': 'userListens'
    },
  ],
};

/// Descriptor for `UserFeedItemEpisodeMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userFeedItemEpisodeMessageDescriptor =
    $convert.base64Decode(
        'ChpVc2VyRmVlZEl0ZW1FcGlzb2RlTWVzc2FnZRIyCgdlcGlzb2RlGAEgASgLMhgucmVzb25hdG'
        'UuRXBpc29kZU1lc3NhZ2VSB2VwaXNvZGUSPgoMdXNlcl9saXN0ZW5zGAIgAygLMhsucmVzb25h'
        'dGUuUHVibGljVXNlck1lc3NhZ2VSC3VzZXJMaXN0ZW5z');

@$core.Deprecated('Use userFeedItemRecommendationMessageDescriptor instead')
const UserFeedItemRecommendationMessage$json = {
  '1': 'UserFeedItemRecommendationMessage',
  '2': [
    {
      '1': 'episode',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.EpisodeMessage',
      '10': 'episode'
    },
    {
      '1': 'podcast',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.PodcastMessage',
      '10': 'podcast'
    },
    {
      '1': 'user_listens',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.resonate.PublicUserMessage',
      '10': 'userListens'
    },
    {
      '1': 'user_subscriptions',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.resonate.PublicUserMessage',
      '10': 'userSubscriptions'
    },
  ],
};

/// Descriptor for `UserFeedItemRecommendationMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userFeedItemRecommendationMessageDescriptor = $convert.base64Decode(
    'CiFVc2VyRmVlZEl0ZW1SZWNvbW1lbmRhdGlvbk1lc3NhZ2USMgoHZXBpc29kZRgBIAEoCzIYLn'
    'Jlc29uYXRlLkVwaXNvZGVNZXNzYWdlUgdlcGlzb2RlEjIKB3BvZGNhc3QYAiABKAsyGC5yZXNv'
    'bmF0ZS5Qb2RjYXN0TWVzc2FnZVIHcG9kY2FzdBI+Cgx1c2VyX2xpc3RlbnMYAyADKAsyGy5yZX'
    'NvbmF0ZS5QdWJsaWNVc2VyTWVzc2FnZVILdXNlckxpc3RlbnMSSgoSdXNlcl9zdWJzY3JpcHRp'
    'b25zGAQgAygLMhsucmVzb25hdGUuUHVibGljVXNlck1lc3NhZ2VSEXVzZXJTdWJzY3JpcHRpb2'
    '5z');

@$core.Deprecated('Use userFeedItemMessageDescriptor instead')
const UserFeedItemMessage$json = {
  '1': 'UserFeedItemMessage',
  '2': [
    {
      '1': 'episode_item',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.UserFeedItemEpisodeMessage',
      '10': 'episodeItem'
    },
    {
      '1': 'recommended_items',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.resonate.UserFeedItemRecommendationMessage',
      '10': 'recommendedItems'
    },
  ],
};

/// Descriptor for `UserFeedItemMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userFeedItemMessageDescriptor = $convert.base64Decode(
    'ChNVc2VyRmVlZEl0ZW1NZXNzYWdlEkcKDGVwaXNvZGVfaXRlbRgBIAEoCzIkLnJlc29uYXRlLl'
    'VzZXJGZWVkSXRlbUVwaXNvZGVNZXNzYWdlUgtlcGlzb2RlSXRlbRJYChFyZWNvbW1lbmRlZF9p'
    'dGVtcxgCIAMoCzIrLnJlc29uYXRlLlVzZXJGZWVkSXRlbVJlY29tbWVuZGF0aW9uTWVzc2FnZV'
    'IQcmVjb21tZW5kZWRJdGVtcw==');

@$core.Deprecated('Use userFeedMessageDescriptor instead')
const UserFeedMessage$json = {
  '1': 'UserFeedMessage',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'userId'},
    {
      '1': 'items',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.resonate.UserFeedItemMessage',
      '10': 'items'
    },
    {
      '1': 'metadata',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.resonate.StorageMetadataMessage',
      '10': 'metadata'
    },
  ],
};

/// Descriptor for `UserFeedMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userFeedMessageDescriptor = $convert.base64Decode(
    'Cg9Vc2VyRmVlZE1lc3NhZ2USHQoHdXNlcl9pZBgBIAEoCUIEgLUYAVIGdXNlcklkEjMKBWl0ZW'
    '1zGAIgAygLMh0ucmVzb25hdGUuVXNlckZlZWRJdGVtTWVzc2FnZVIFaXRlbXMSPAoIbWV0YWRh'
    'dGEYAyABKAsyIC5yZXNvbmF0ZS5TdG9yYWdlTWV0YWRhdGFNZXNzYWdlUghtZXRhZGF0YQ==');

@$core.Deprecated('Use searchResultMessageDescriptor instead')
const SearchResultMessage$json = {
  '1': 'SearchResultMessage',
  '2': [
    {
      '1': 'podcast',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.PodcastMessage',
      '10': 'podcast'
    },
    {
      '1': 'user',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.UserMessage',
      '10': 'user'
    },
    {
      '1': 'episode',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.resonate.EpisodeMessage',
      '10': 'episode'
    },
  ],
};

/// Descriptor for `SearchResultMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchResultMessageDescriptor = $convert.base64Decode(
    'ChNTZWFyY2hSZXN1bHRNZXNzYWdlEjIKB3BvZGNhc3QYASABKAsyGC5yZXNvbmF0ZS5Qb2RjYX'
    'N0TWVzc2FnZVIHcG9kY2FzdBIpCgR1c2VyGAIgASgLMhUucmVzb25hdGUuVXNlck1lc3NhZ2VS'
    'BHVzZXISMgoHZXBpc29kZRgDIAEoCzIYLnJlc29uYXRlLkVwaXNvZGVNZXNzYWdlUgdlcGlzb2'
    'Rl');

@$core.Deprecated('Use searchResultsMessageDescriptor instead')
const SearchResultsMessage$json = {
  '1': 'SearchResultsMessage',
  '2': [
    {
      '1': 'results',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.resonate.SearchResultMessage',
      '10': 'results'
    },
  ],
};

/// Descriptor for `SearchResultsMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchResultsMessageDescriptor = $convert.base64Decode(
    'ChRTZWFyY2hSZXN1bHRzTWVzc2FnZRI3CgdyZXN1bHRzGAEgAygLMh0ucmVzb25hdGUuU2Vhcm'
    'NoUmVzdWx0TWVzc2FnZVIHcmVzdWx0cw==');

@$core.Deprecated('Use userDownloadMessageDescriptor instead')
const UserDownloadMessage$json = {
  '1': 'UserDownloadMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'episode_id', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'episodeId'},
    {'1': 'file_path', '3': 3, '4': 1, '5': 9, '10': 'filePath'},
    {'1': 'is_downloaded', '3': 4, '4': 1, '5': 8, '10': 'isDownloaded'},
    {
      '1': 'metadata',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.resonate.StorageMetadataMessage',
      '10': 'metadata'
    },
  ],
};

/// Descriptor for `UserDownloadMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDownloadMessageDescriptor = $convert.base64Decode(
    'ChNVc2VyRG93bmxvYWRNZXNzYWdlEg4KAmlkGAEgASgJUgJpZBIjCgplcGlzb2RlX2lkGAIgAS'
    'gJQgSAtRgBUgllcGlzb2RlSWQSGwoJZmlsZV9wYXRoGAMgASgJUghmaWxlUGF0aBIjCg1pc19k'
    'b3dubG9hZGVkGAQgASgIUgxpc0Rvd25sb2FkZWQSPAoIbWV0YWRhdGEYBSABKAsyIC5yZXNvbm'
    'F0ZS5TdG9yYWdlTWV0YWRhdGFNZXNzYWdlUghtZXRhZGF0YQ==');

@$core.Deprecated('Use userContactsMessageDescriptor instead')
const UserContactsMessage$json = {
  '1': 'UserContactsMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'userId'},
    {
      '1': 'contacts',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.resonate.UserContactMessage',
      '10': 'contacts'
    },
    {
      '1': 'metadata',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.resonate.StorageMetadataMessage',
      '10': 'metadata'
    },
  ],
};

/// Descriptor for `UserContactsMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userContactsMessageDescriptor = $convert.base64Decode(
    'ChNVc2VyQ29udGFjdHNNZXNzYWdlEg4KAmlkGAEgASgJUgJpZBIdCgd1c2VyX2lkGAIgASgJQg'
    'SAtRgBUgZ1c2VySWQSOAoIY29udGFjdHMYAyADKAsyHC5yZXNvbmF0ZS5Vc2VyQ29udGFjdE1l'
    'c3NhZ2VSCGNvbnRhY3RzEjwKCG1ldGFkYXRhGAQgASgLMiAucmVzb25hdGUuU3RvcmFnZU1ldG'
    'FkYXRhTWVzc2FnZVIIbWV0YWRhdGE=');

@$core.Deprecated('Use userContactMessageDescriptor instead')
const UserContactMessage$json = {
  '1': 'UserContactMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'phone_number', '3': 3, '4': 1, '5': 9, '10': 'phoneNumber'},
  ],
};

/// Descriptor for `UserContactMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userContactMessageDescriptor = $convert.base64Decode(
    'ChJVc2VyQ29udGFjdE1lc3NhZ2USDgoCaWQYASABKAlSAmlkEiEKDHBob25lX251bWJlchgDIA'
    'EoCVILcGhvbmVOdW1iZXI=');

@$core.Deprecated('Use settingsMessageDescriptor instead')
const SettingsMessage$json = {
  '1': 'SettingsMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'id'},
    {
      '1': 'metadata',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.StorageMetadataMessage',
      '10': 'metadata'
    },
    {'1': 'enable_playlist', '3': 3, '4': 1, '5': 8, '10': 'enablePlaylist'},
  ],
};

/// Descriptor for `SettingsMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List settingsMessageDescriptor = $convert.base64Decode(
    'Cg9TZXR0aW5nc01lc3NhZ2USFAoCaWQYASABKAlCBIC1GAFSAmlkEjwKCG1ldGFkYXRhGAIgAS'
    'gLMiAucmVzb25hdGUuU3RvcmFnZU1ldGFkYXRhTWVzc2FnZVIIbWV0YWRhdGESJwoPZW5hYmxl'
    'X3BsYXlsaXN0GAMgASgIUg5lbmFibGVQbGF5bGlzdA==');
