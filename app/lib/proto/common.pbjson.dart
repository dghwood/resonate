//
//  Generated code. Do not modify.
//  source: proto/common.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use podcastMessageDescriptor instead')
const PodcastMessage$json = {
  '1': 'PodcastMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'url', '3': 4, '4': 1, '5': 9, '10': 'url'},
    {'1': 'image_url', '3': 5, '4': 1, '5': 9, '10': 'imageUrl'},
    {'1': 'author', '3': 6, '4': 1, '5': 9, '10': 'author'},
    {'1': 'episodes', '3': 7, '4': 3, '5': 11, '6': '.resonate.EpisodeMessage', '10': 'episodes'},
  ],
};

/// Descriptor for `PodcastMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List podcastMessageDescriptor = $convert.base64Decode(
    'Cg5Qb2RjYXN0TWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEi'
    'AKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIQCgN1cmwYBCABKAlSA3VybBIbCglp'
    'bWFnZV91cmwYBSABKAlSCGltYWdlVXJsEhYKBmF1dGhvchgGIAEoCVIGYXV0aG9yEjQKCGVwaX'
    'NvZGVzGAcgAygLMhgucmVzb25hdGUuRXBpc29kZU1lc3NhZ2VSCGVwaXNvZGVz');

@$core.Deprecated('Use episodeMessageDescriptor instead')
const EpisodeMessage$json = {
  '1': 'EpisodeMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'podcast_id', '3': 2, '4': 1, '5': 9, '10': 'podcastId'},
    {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'audio_url', '3': 5, '4': 1, '5': 9, '10': 'audioUrl'},
    {'1': 'image_url', '3': 6, '4': 1, '5': 9, '10': 'imageUrl'},
    {'1': 'publish_timestamp', '3': 8, '4': 1, '5': 3, '10': 'publishTimestamp'},
    {'1': 'duration_seconds', '3': 9, '4': 1, '5': 3, '10': 'durationSeconds'},
    {'1': 'episode_number', '3': 10, '4': 1, '5': 3, '10': 'episodeNumber'},
    {'1': 'explicit', '3': 11, '4': 1, '5': 8, '10': 'explicit'},
  ],
};

/// Descriptor for `EpisodeMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List episodeMessageDescriptor = $convert.base64Decode(
    'Cg5FcGlzb2RlTWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSHQoKcG9kY2FzdF9pZBgCIAEoCVIJcG'
    '9kY2FzdElkEhQKBXRpdGxlGAMgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgEIAEoCVILZGVz'
    'Y3JpcHRpb24SGwoJYXVkaW9fdXJsGAUgASgJUghhdWRpb1VybBIbCglpbWFnZV91cmwYBiABKA'
    'lSCGltYWdlVXJsEisKEXB1Ymxpc2hfdGltZXN0YW1wGAggASgDUhBwdWJsaXNoVGltZXN0YW1w'
    'EikKEGR1cmF0aW9uX3NlY29uZHMYCSABKANSD2R1cmF0aW9uU2Vjb25kcxIlCg5lcGlzb2RlX2'
    '51bWJlchgKIAEoA1INZXBpc29kZU51bWJlchIaCghleHBsaWNpdBgLIAEoCFIIZXhwbGljaXQ=');

@$core.Deprecated('Use userMessageDescriptor instead')
const UserMessage$json = {
  '1': 'UserMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    {'1': 'image_url', '3': 4, '4': 1, '5': 9, '10': 'imageUrl'},
    {'1': 'subscriptions', '3': 5, '4': 3, '5': 11, '6': '.resonate.UserSubscriptionMessage', '10': 'subscriptions'},
    {'1': 'listens', '3': 6, '4': 3, '5': 11, '6': '.resonate.UserListenMessage', '10': 'listens'},
    {'1': 'following', '3': 7, '4': 3, '5': 11, '6': '.resonate.UserFollowMessage', '10': 'following'},
    {'1': 'num_followers', '3': 8, '4': 1, '5': 3, '10': 'numFollowers'},
  ],
};

/// Descriptor for `UserMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userMessageDescriptor = $convert.base64Decode(
    'CgtVc2VyTWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIUCgVlbW'
    'FpbBgDIAEoCVIFZW1haWwSGwoJaW1hZ2VfdXJsGAQgASgJUghpbWFnZVVybBJHCg1zdWJzY3Jp'
    'cHRpb25zGAUgAygLMiEucmVzb25hdGUuVXNlclN1YnNjcmlwdGlvbk1lc3NhZ2VSDXN1YnNjcm'
    'lwdGlvbnMSNQoHbGlzdGVucxgGIAMoCzIbLnJlc29uYXRlLlVzZXJMaXN0ZW5NZXNzYWdlUgds'
    'aXN0ZW5zEjkKCWZvbGxvd2luZxgHIAMoCzIbLnJlc29uYXRlLlVzZXJGb2xsb3dNZXNzYWdlUg'
    'lmb2xsb3dpbmcSIwoNbnVtX2ZvbGxvd2VycxgIIAEoA1IMbnVtRm9sbG93ZXJz');

@$core.Deprecated('Use userFollowMessageDescriptor instead')
const UserFollowMessage$json = {
  '1': 'UserFollowMessage',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'followed_user_id', '3': 2, '4': 1, '5': 9, '10': 'followedUserId'},
  ],
};

/// Descriptor for `UserFollowMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userFollowMessageDescriptor = $convert.base64Decode(
    'ChFVc2VyRm9sbG93TWVzc2FnZRIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSKAoQZm9sbG93ZW'
    'RfdXNlcl9pZBgCIAEoCVIOZm9sbG93ZWRVc2VySWQ=');

@$core.Deprecated('Use userSubscriptionMessageDescriptor instead')
const UserSubscriptionMessage$json = {
  '1': 'UserSubscriptionMessage',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'podcast_id', '3': 2, '4': 1, '5': 9, '10': 'podcastId'},
  ],
};

/// Descriptor for `UserSubscriptionMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userSubscriptionMessageDescriptor = $convert.base64Decode(
    'ChdVc2VyU3Vic2NyaXB0aW9uTWVzc2FnZRIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSHQoKcG'
    '9kY2FzdF9pZBgCIAEoCVIJcG9kY2FzdElk');

@$core.Deprecated('Use userListenMessageDescriptor instead')
const UserListenMessage$json = {
  '1': 'UserListenMessage',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'episode_id', '3': 2, '4': 1, '5': 9, '10': 'episodeId'},
    {'1': 'listen_timestamp', '3': 3, '4': 1, '5': 3, '10': 'listenTimestamp'},
    {'1': 'seconds', '3': 4, '4': 1, '5': 3, '10': 'seconds'},
    {'1': 'completed', '3': 5, '4': 1, '5': 8, '10': 'completed'},
    {'1': 'episode', '3': 6, '4': 1, '5': 11, '6': '.resonate.EpisodeMessage', '10': 'episode'},
  ],
};

/// Descriptor for `UserListenMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userListenMessageDescriptor = $convert.base64Decode(
    'ChFVc2VyTGlzdGVuTWVzc2FnZRIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSHQoKZXBpc29kZV'
    '9pZBgCIAEoCVIJZXBpc29kZUlkEikKEGxpc3Rlbl90aW1lc3RhbXAYAyABKANSD2xpc3RlblRp'
    'bWVzdGFtcBIYCgdzZWNvbmRzGAQgASgDUgdzZWNvbmRzEhwKCWNvbXBsZXRlZBgFIAEoCFIJY2'
    '9tcGxldGVkEjIKB2VwaXNvZGUYBiABKAsyGC5yZXNvbmF0ZS5FcGlzb2RlTWVzc2FnZVIHZXBp'
    'c29kZQ==');

@$core.Deprecated('Use userFeedItemMessageDescriptor instead')
const UserFeedItemMessage$json = {
  '1': 'UserFeedItemMessage',
  '2': [
    {'1': 'episode', '3': 1, '4': 1, '5': 11, '6': '.resonate.EpisodeMessage', '10': 'episode'},
    {'1': 'listen', '3': 2, '4': 1, '5': 11, '6': '.resonate.UserListenMessage', '10': 'listen'},
  ],
};

/// Descriptor for `UserFeedItemMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userFeedItemMessageDescriptor = $convert.base64Decode(
    'ChNVc2VyRmVlZEl0ZW1NZXNzYWdlEjIKB2VwaXNvZGUYASABKAsyGC5yZXNvbmF0ZS5FcGlzb2'
    'RlTWVzc2FnZVIHZXBpc29kZRIzCgZsaXN0ZW4YAiABKAsyGy5yZXNvbmF0ZS5Vc2VyTGlzdGVu'
    'TWVzc2FnZVIGbGlzdGVu');

@$core.Deprecated('Use userFeedMessageDescriptor instead')
const UserFeedMessage$json = {
  '1': 'UserFeedMessage',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'items', '3': 2, '4': 3, '5': 11, '6': '.resonate.UserFeedItemMessage', '10': 'items'},
  ],
};

/// Descriptor for `UserFeedMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userFeedMessageDescriptor = $convert.base64Decode(
    'Cg9Vc2VyRmVlZE1lc3NhZ2USFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEjMKBWl0ZW1zGAIgAy'
    'gLMh0ucmVzb25hdGUuVXNlckZlZWRJdGVtTWVzc2FnZVIFaXRlbXM=');

