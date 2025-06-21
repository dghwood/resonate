//
//  Generated code. Do not modify.
//  source: proto/api.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use responseInfoDescriptor instead')
const ResponseInfo$json = {
  '1': 'ResponseInfo',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_message', '3': 2, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `ResponseInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List responseInfoDescriptor = $convert.base64Decode(
    'CgxSZXNwb25zZUluZm8SGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIjCg1lcnJvcl9tZXNzYW'
    'dlGAIgASgJUgxlcnJvck1lc3NhZ2U=');

@$core.Deprecated('Use requestInfoDescriptor instead')
const RequestInfo$json = {
  '1': 'RequestInfo',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `RequestInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestInfoDescriptor = $convert.base64Decode(
    'CgtSZXF1ZXN0SW5mbxIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQ=');

@$core.Deprecated('Use createUserMessageDescriptor instead')
const CreateUserMessage$json = {
  '1': 'CreateUserMessage',
  '2': [
    {'1': 'request', '3': 1, '4': 1, '5': 11, '6': '.resonate.api.CreateUserMessage.Request', '10': 'request'},
    {'1': 'response', '3': 2, '4': 1, '5': 11, '6': '.resonate.api.CreateUserMessage.Response', '10': 'response'},
  ],
  '3': [CreateUserMessage_Request$json, CreateUserMessage_Response$json],
};

@$core.Deprecated('Use createUserMessageDescriptor instead')
const CreateUserMessage_Request$json = {
  '1': 'Request',
  '2': [
    {'1': 'request_info', '3': 1, '4': 1, '5': 11, '6': '.resonate.api.RequestInfo', '10': 'requestInfo'},
    {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.resonate.UserMessage', '10': 'user'},
  ],
};

@$core.Deprecated('Use createUserMessageDescriptor instead')
const CreateUserMessage_Response$json = {
  '1': 'Response',
  '2': [
    {'1': 'response_info', '3': 1, '4': 1, '5': 11, '6': '.resonate.api.ResponseInfo', '10': 'responseInfo'},
    {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.resonate.UserMessage', '10': 'user'},
  ],
};

/// Descriptor for `CreateUserMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUserMessageDescriptor = $convert.base64Decode(
    'ChFDcmVhdGVVc2VyTWVzc2FnZRJBCgdyZXF1ZXN0GAEgASgLMicucmVzb25hdGUuYXBpLkNyZW'
    'F0ZVVzZXJNZXNzYWdlLlJlcXVlc3RSB3JlcXVlc3QSRAoIcmVzcG9uc2UYAiABKAsyKC5yZXNv'
    'bmF0ZS5hcGkuQ3JlYXRlVXNlck1lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGnIKB1JlcXVlc3'
    'QSPAoMcmVxdWVzdF9pbmZvGAEgASgLMhkucmVzb25hdGUuYXBpLlJlcXVlc3RJbmZvUgtyZXF1'
    'ZXN0SW5mbxIpCgR1c2VyGAIgASgLMhUucmVzb25hdGUuVXNlck1lc3NhZ2VSBHVzZXIadgoIUm'
    'VzcG9uc2USPwoNcmVzcG9uc2VfaW5mbxgBIAEoCzIaLnJlc29uYXRlLmFwaS5SZXNwb25zZUlu'
    'Zm9SDHJlc3BvbnNlSW5mbxIpCgR1c2VyGAIgASgLMhUucmVzb25hdGUuVXNlck1lc3NhZ2VSBH'
    'VzZXI=');

@$core.Deprecated('Use getUserMessageDescriptor instead')
const GetUserMessage$json = {
  '1': 'GetUserMessage',
  '2': [
    {'1': 'request', '3': 1, '4': 1, '5': 11, '6': '.resonate.api.GetUserMessage.Request', '10': 'request'},
    {'1': 'response', '3': 2, '4': 1, '5': 11, '6': '.resonate.api.GetUserMessage.Response', '10': 'response'},
  ],
  '3': [GetUserMessage_Request$json, GetUserMessage_Response$json],
};

@$core.Deprecated('Use getUserMessageDescriptor instead')
const GetUserMessage_Request$json = {
  '1': 'Request',
  '2': [
    {'1': 'request_info', '3': 1, '4': 1, '5': 11, '6': '.resonate.api.RequestInfo', '10': 'requestInfo'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

@$core.Deprecated('Use getUserMessageDescriptor instead')
const GetUserMessage_Response$json = {
  '1': 'Response',
  '2': [
    {'1': 'response_info', '3': 1, '4': 1, '5': 11, '6': '.resonate.api.ResponseInfo', '10': 'responseInfo'},
    {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.resonate.UserMessage', '10': 'user'},
  ],
};

/// Descriptor for `GetUserMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserMessageDescriptor = $convert.base64Decode(
    'Cg5HZXRVc2VyTWVzc2FnZRI+CgdyZXF1ZXN0GAEgASgLMiQucmVzb25hdGUuYXBpLkdldFVzZX'
    'JNZXNzYWdlLlJlcXVlc3RSB3JlcXVlc3QSQQoIcmVzcG9uc2UYAiABKAsyJS5yZXNvbmF0ZS5h'
    'cGkuR2V0VXNlck1lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGmAKB1JlcXVlc3QSPAoMcmVxdW'
    'VzdF9pbmZvGAEgASgLMhkucmVzb25hdGUuYXBpLlJlcXVlc3RJbmZvUgtyZXF1ZXN0SW5mbxIX'
    'Cgd1c2VyX2lkGAIgASgJUgZ1c2VySWQadgoIUmVzcG9uc2USPwoNcmVzcG9uc2VfaW5mbxgBIA'
    'EoCzIaLnJlc29uYXRlLmFwaS5SZXNwb25zZUluZm9SDHJlc3BvbnNlSW5mbxIpCgR1c2VyGAIg'
    'ASgLMhUucmVzb25hdGUuVXNlck1lc3NhZ2VSBHVzZXI=');

@$core.Deprecated('Use updateUserMessageDescriptor instead')
const UpdateUserMessage$json = {
  '1': 'UpdateUserMessage',
  '2': [
    {'1': 'request', '3': 1, '4': 1, '5': 11, '6': '.resonate.api.UpdateUserMessage.Request', '10': 'request'},
    {'1': 'response', '3': 2, '4': 1, '5': 11, '6': '.resonate.api.UpdateUserMessage.Response', '10': 'response'},
  ],
  '3': [UpdateUserMessage_Request$json, UpdateUserMessage_Response$json],
};

@$core.Deprecated('Use updateUserMessageDescriptor instead')
const UpdateUserMessage_Request$json = {
  '1': 'Request',
  '2': [
    {'1': 'request_info', '3': 1, '4': 1, '5': 11, '6': '.resonate.api.RequestInfo', '10': 'requestInfo'},
    {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.resonate.UserMessage', '10': 'user'},
  ],
};

@$core.Deprecated('Use updateUserMessageDescriptor instead')
const UpdateUserMessage_Response$json = {
  '1': 'Response',
  '2': [
    {'1': 'response_info', '3': 1, '4': 1, '5': 11, '6': '.resonate.api.ResponseInfo', '10': 'responseInfo'},
    {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.resonate.UserMessage', '10': 'user'},
  ],
};

/// Descriptor for `UpdateUserMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateUserMessageDescriptor = $convert.base64Decode(
    'ChFVcGRhdGVVc2VyTWVzc2FnZRJBCgdyZXF1ZXN0GAEgASgLMicucmVzb25hdGUuYXBpLlVwZG'
    'F0ZVVzZXJNZXNzYWdlLlJlcXVlc3RSB3JlcXVlc3QSRAoIcmVzcG9uc2UYAiABKAsyKC5yZXNv'
    'bmF0ZS5hcGkuVXBkYXRlVXNlck1lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGnIKB1JlcXVlc3'
    'QSPAoMcmVxdWVzdF9pbmZvGAEgASgLMhkucmVzb25hdGUuYXBpLlJlcXVlc3RJbmZvUgtyZXF1'
    'ZXN0SW5mbxIpCgR1c2VyGAIgASgLMhUucmVzb25hdGUuVXNlck1lc3NhZ2VSBHVzZXIadgoIUm'
    'VzcG9uc2USPwoNcmVzcG9uc2VfaW5mbxgBIAEoCzIaLnJlc29uYXRlLmFwaS5SZXNwb25zZUlu'
    'Zm9SDHJlc3BvbnNlSW5mbxIpCgR1c2VyGAIgASgLMhUucmVzb25hdGUuVXNlck1lc3NhZ2VSBH'
    'VzZXI=');

@$core.Deprecated('Use searchMessageDescriptor instead')
const SearchMessage$json = {
  '1': 'SearchMessage',
  '2': [
    {'1': 'request', '3': 1, '4': 1, '5': 11, '6': '.resonate.api.SearchMessage.Request', '10': 'request'},
    {'1': 'response', '3': 2, '4': 1, '5': 11, '6': '.resonate.api.SearchMessage.Response', '10': 'response'},
  ],
  '3': [SearchMessage_Request$json, SearchMessage_Response$json],
};

@$core.Deprecated('Use searchMessageDescriptor instead')
const SearchMessage_Request$json = {
  '1': 'Request',
  '2': [
    {'1': 'request_info', '3': 1, '4': 1, '5': 11, '6': '.resonate.api.RequestInfo', '10': 'requestInfo'},
    {'1': 'query', '3': 2, '4': 1, '5': 9, '10': 'query'},
  ],
};

@$core.Deprecated('Use searchMessageDescriptor instead')
const SearchMessage_Response$json = {
  '1': 'Response',
  '2': [
    {'1': 'response_info', '3': 1, '4': 1, '5': 11, '6': '.resonate.api.ResponseInfo', '10': 'responseInfo'},
    {'1': 'podcasts', '3': 2, '4': 3, '5': 11, '6': '.resonate.PodcastMessage', '10': 'podcasts'},
    {'1': 'users', '3': 3, '4': 3, '5': 11, '6': '.resonate.UserMessage', '10': 'users'},
    {'1': 'episodes', '3': 4, '4': 3, '5': 11, '6': '.resonate.EpisodeMessage', '10': 'episodes'},
  ],
};

/// Descriptor for `SearchMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchMessageDescriptor = $convert.base64Decode(
    'Cg1TZWFyY2hNZXNzYWdlEj0KB3JlcXVlc3QYASABKAsyIy5yZXNvbmF0ZS5hcGkuU2VhcmNoTW'
    'Vzc2FnZS5SZXF1ZXN0UgdyZXF1ZXN0EkAKCHJlc3BvbnNlGAIgASgLMiQucmVzb25hdGUuYXBp'
    'LlNlYXJjaE1lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGl0KB1JlcXVlc3QSPAoMcmVxdWVzdF'
    '9pbmZvGAEgASgLMhkucmVzb25hdGUuYXBpLlJlcXVlc3RJbmZvUgtyZXF1ZXN0SW5mbxIUCgVx'
    'dWVyeRgCIAEoCVIFcXVlcnka5AEKCFJlc3BvbnNlEj8KDXJlc3BvbnNlX2luZm8YASABKAsyGi'
    '5yZXNvbmF0ZS5hcGkuUmVzcG9uc2VJbmZvUgxyZXNwb25zZUluZm8SNAoIcG9kY2FzdHMYAiAD'
    'KAsyGC5yZXNvbmF0ZS5Qb2RjYXN0TWVzc2FnZVIIcG9kY2FzdHMSKwoFdXNlcnMYAyADKAsyFS'
    '5yZXNvbmF0ZS5Vc2VyTWVzc2FnZVIFdXNlcnMSNAoIZXBpc29kZXMYBCADKAsyGC5yZXNvbmF0'
    'ZS5FcGlzb2RlTWVzc2FnZVIIZXBpc29kZXM=');

@$core.Deprecated('Use getPodcastMessageDescriptor instead')
const GetPodcastMessage$json = {
  '1': 'GetPodcastMessage',
  '2': [
    {'1': 'request', '3': 1, '4': 1, '5': 11, '6': '.resonate.api.GetPodcastMessage.Request', '10': 'request'},
    {'1': 'response', '3': 2, '4': 1, '5': 11, '6': '.resonate.api.GetPodcastMessage.Response', '10': 'response'},
  ],
  '3': [GetPodcastMessage_Request$json, GetPodcastMessage_Response$json],
};

@$core.Deprecated('Use getPodcastMessageDescriptor instead')
const GetPodcastMessage_Request$json = {
  '1': 'Request',
  '2': [
    {'1': 'request_info', '3': 1, '4': 1, '5': 11, '6': '.resonate.api.RequestInfo', '10': 'requestInfo'},
    {'1': 'podcast_id', '3': 2, '4': 1, '5': 9, '10': 'podcastId'},
  ],
};

@$core.Deprecated('Use getPodcastMessageDescriptor instead')
const GetPodcastMessage_Response$json = {
  '1': 'Response',
  '2': [
    {'1': 'response_info', '3': 1, '4': 1, '5': 11, '6': '.resonate.api.ResponseInfo', '10': 'responseInfo'},
    {'1': 'podcast', '3': 2, '4': 1, '5': 11, '6': '.resonate.PodcastMessage', '10': 'podcast'},
  ],
};

/// Descriptor for `GetPodcastMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPodcastMessageDescriptor = $convert.base64Decode(
    'ChFHZXRQb2RjYXN0TWVzc2FnZRJBCgdyZXF1ZXN0GAEgASgLMicucmVzb25hdGUuYXBpLkdldF'
    'BvZGNhc3RNZXNzYWdlLlJlcXVlc3RSB3JlcXVlc3QSRAoIcmVzcG9uc2UYAiABKAsyKC5yZXNv'
    'bmF0ZS5hcGkuR2V0UG9kY2FzdE1lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGmYKB1JlcXVlc3'
    'QSPAoMcmVxdWVzdF9pbmZvGAEgASgLMhkucmVzb25hdGUuYXBpLlJlcXVlc3RJbmZvUgtyZXF1'
    'ZXN0SW5mbxIdCgpwb2RjYXN0X2lkGAIgASgJUglwb2RjYXN0SWQafwoIUmVzcG9uc2USPwoNcm'
    'VzcG9uc2VfaW5mbxgBIAEoCzIaLnJlc29uYXRlLmFwaS5SZXNwb25zZUluZm9SDHJlc3BvbnNl'
    'SW5mbxIyCgdwb2RjYXN0GAIgASgLMhgucmVzb25hdGUuUG9kY2FzdE1lc3NhZ2VSB3BvZGNhc3'
    'Q=');

@$core.Deprecated('Use getEpisodeMessageDescriptor instead')
const GetEpisodeMessage$json = {
  '1': 'GetEpisodeMessage',
  '2': [
    {'1': 'request', '3': 1, '4': 1, '5': 11, '6': '.resonate.api.GetEpisodeMessage.Request', '10': 'request'},
    {'1': 'response', '3': 2, '4': 1, '5': 11, '6': '.resonate.api.GetEpisodeMessage.Response', '10': 'response'},
  ],
  '3': [GetEpisodeMessage_Request$json, GetEpisodeMessage_Response$json],
};

@$core.Deprecated('Use getEpisodeMessageDescriptor instead')
const GetEpisodeMessage_Request$json = {
  '1': 'Request',
  '2': [
    {'1': 'request_info', '3': 1, '4': 1, '5': 11, '6': '.resonate.api.RequestInfo', '10': 'requestInfo'},
    {'1': 'episode_id', '3': 2, '4': 1, '5': 9, '10': 'episodeId'},
  ],
};

@$core.Deprecated('Use getEpisodeMessageDescriptor instead')
const GetEpisodeMessage_Response$json = {
  '1': 'Response',
  '2': [
    {'1': 'response_info', '3': 1, '4': 1, '5': 11, '6': '.resonate.api.ResponseInfo', '10': 'responseInfo'},
    {'1': 'episode', '3': 2, '4': 1, '5': 11, '6': '.resonate.EpisodeMessage', '10': 'episode'},
  ],
};

/// Descriptor for `GetEpisodeMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEpisodeMessageDescriptor = $convert.base64Decode(
    'ChFHZXRFcGlzb2RlTWVzc2FnZRJBCgdyZXF1ZXN0GAEgASgLMicucmVzb25hdGUuYXBpLkdldE'
    'VwaXNvZGVNZXNzYWdlLlJlcXVlc3RSB3JlcXVlc3QSRAoIcmVzcG9uc2UYAiABKAsyKC5yZXNv'
    'bmF0ZS5hcGkuR2V0RXBpc29kZU1lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGmYKB1JlcXVlc3'
    'QSPAoMcmVxdWVzdF9pbmZvGAEgASgLMhkucmVzb25hdGUuYXBpLlJlcXVlc3RJbmZvUgtyZXF1'
    'ZXN0SW5mbxIdCgplcGlzb2RlX2lkGAIgASgJUgllcGlzb2RlSWQafwoIUmVzcG9uc2USPwoNcm'
    'VzcG9uc2VfaW5mbxgBIAEoCzIaLnJlc29uYXRlLmFwaS5SZXNwb25zZUluZm9SDHJlc3BvbnNl'
    'SW5mbxIyCgdlcGlzb2RlGAIgASgLMhgucmVzb25hdGUuRXBpc29kZU1lc3NhZ2VSB2VwaXNvZG'
    'U=');

@$core.Deprecated('Use addSubscriptionMessageDescriptor instead')
const AddSubscriptionMessage$json = {
  '1': 'AddSubscriptionMessage',
  '2': [
    {'1': 'request', '3': 1, '4': 1, '5': 11, '6': '.resonate.api.AddSubscriptionMessage.Request', '10': 'request'},
    {'1': 'response', '3': 2, '4': 1, '5': 11, '6': '.resonate.api.AddSubscriptionMessage.Response', '10': 'response'},
  ],
  '3': [AddSubscriptionMessage_Request$json, AddSubscriptionMessage_Response$json],
};

@$core.Deprecated('Use addSubscriptionMessageDescriptor instead')
const AddSubscriptionMessage_Request$json = {
  '1': 'Request',
  '2': [
    {'1': 'request_info', '3': 1, '4': 1, '5': 11, '6': '.resonate.api.RequestInfo', '10': 'requestInfo'},
    {'1': 'subscription', '3': 2, '4': 1, '5': 11, '6': '.resonate.UserSubscriptionMessage', '10': 'subscription'},
  ],
};

@$core.Deprecated('Use addSubscriptionMessageDescriptor instead')
const AddSubscriptionMessage_Response$json = {
  '1': 'Response',
  '2': [
    {'1': 'response_info', '3': 1, '4': 1, '5': 11, '6': '.resonate.api.ResponseInfo', '10': 'responseInfo'},
    {'1': 'subscription', '3': 2, '4': 1, '5': 11, '6': '.resonate.UserSubscriptionMessage', '10': 'subscription'},
  ],
};

/// Descriptor for `AddSubscriptionMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addSubscriptionMessageDescriptor = $convert.base64Decode(
    'ChZBZGRTdWJzY3JpcHRpb25NZXNzYWdlEkYKB3JlcXVlc3QYASABKAsyLC5yZXNvbmF0ZS5hcG'
    'kuQWRkU3Vic2NyaXB0aW9uTWVzc2FnZS5SZXF1ZXN0UgdyZXF1ZXN0EkkKCHJlc3BvbnNlGAIg'
    'ASgLMi0ucmVzb25hdGUuYXBpLkFkZFN1YnNjcmlwdGlvbk1lc3NhZ2UuUmVzcG9uc2VSCHJlc3'
    'BvbnNlGo4BCgdSZXF1ZXN0EjwKDHJlcXVlc3RfaW5mbxgBIAEoCzIZLnJlc29uYXRlLmFwaS5S'
    'ZXF1ZXN0SW5mb1ILcmVxdWVzdEluZm8SRQoMc3Vic2NyaXB0aW9uGAIgASgLMiEucmVzb25hdG'
    'UuVXNlclN1YnNjcmlwdGlvbk1lc3NhZ2VSDHN1YnNjcmlwdGlvbhqSAQoIUmVzcG9uc2USPwoN'
    'cmVzcG9uc2VfaW5mbxgBIAEoCzIaLnJlc29uYXRlLmFwaS5SZXNwb25zZUluZm9SDHJlc3Bvbn'
    'NlSW5mbxJFCgxzdWJzY3JpcHRpb24YAiABKAsyIS5yZXNvbmF0ZS5Vc2VyU3Vic2NyaXB0aW9u'
    'TWVzc2FnZVIMc3Vic2NyaXB0aW9u');

@$core.Deprecated('Use removeSubscriptionMessageDescriptor instead')
const RemoveSubscriptionMessage$json = {
  '1': 'RemoveSubscriptionMessage',
  '2': [
    {'1': 'request', '3': 1, '4': 1, '5': 11, '6': '.resonate.api.RemoveSubscriptionMessage.Request', '10': 'request'},
    {'1': 'response', '3': 2, '4': 1, '5': 11, '6': '.resonate.api.RemoveSubscriptionMessage.Response', '10': 'response'},
  ],
  '3': [RemoveSubscriptionMessage_Request$json, RemoveSubscriptionMessage_Response$json],
};

@$core.Deprecated('Use removeSubscriptionMessageDescriptor instead')
const RemoveSubscriptionMessage_Request$json = {
  '1': 'Request',
  '2': [
    {'1': 'request_info', '3': 1, '4': 1, '5': 11, '6': '.resonate.api.RequestInfo', '10': 'requestInfo'},
    {'1': 'subscription', '3': 2, '4': 1, '5': 11, '6': '.resonate.UserSubscriptionMessage', '10': 'subscription'},
  ],
};

@$core.Deprecated('Use removeSubscriptionMessageDescriptor instead')
const RemoveSubscriptionMessage_Response$json = {
  '1': 'Response',
  '2': [
    {'1': 'response_info', '3': 1, '4': 1, '5': 11, '6': '.resonate.api.ResponseInfo', '10': 'responseInfo'},
    {'1': 'subscription', '3': 2, '4': 1, '5': 11, '6': '.resonate.UserSubscriptionMessage', '10': 'subscription'},
  ],
};

/// Descriptor for `RemoveSubscriptionMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeSubscriptionMessageDescriptor = $convert.base64Decode(
    'ChlSZW1vdmVTdWJzY3JpcHRpb25NZXNzYWdlEkkKB3JlcXVlc3QYASABKAsyLy5yZXNvbmF0ZS'
    '5hcGkuUmVtb3ZlU3Vic2NyaXB0aW9uTWVzc2FnZS5SZXF1ZXN0UgdyZXF1ZXN0EkwKCHJlc3Bv'
    'bnNlGAIgASgLMjAucmVzb25hdGUuYXBpLlJlbW92ZVN1YnNjcmlwdGlvbk1lc3NhZ2UuUmVzcG'
    '9uc2VSCHJlc3BvbnNlGo4BCgdSZXF1ZXN0EjwKDHJlcXVlc3RfaW5mbxgBIAEoCzIZLnJlc29u'
    'YXRlLmFwaS5SZXF1ZXN0SW5mb1ILcmVxdWVzdEluZm8SRQoMc3Vic2NyaXB0aW9uGAIgASgLMi'
    'EucmVzb25hdGUuVXNlclN1YnNjcmlwdGlvbk1lc3NhZ2VSDHN1YnNjcmlwdGlvbhqSAQoIUmVz'
    'cG9uc2USPwoNcmVzcG9uc2VfaW5mbxgBIAEoCzIaLnJlc29uYXRlLmFwaS5SZXNwb25zZUluZm'
    '9SDHJlc3BvbnNlSW5mbxJFCgxzdWJzY3JpcHRpb24YAiABKAsyIS5yZXNvbmF0ZS5Vc2VyU3Vi'
    'c2NyaXB0aW9uTWVzc2FnZVIMc3Vic2NyaXB0aW9u');

