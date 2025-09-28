// This is a generated file - do not edit.
//
// Generated from proto/api.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

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
    {
      '1': 'access_token',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.TokenMessage',
      '10': 'accessToken'
    },
  ],
};

/// Descriptor for `RequestInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestInfoDescriptor = $convert.base64Decode(
    'CgtSZXF1ZXN0SW5mbxIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSOQoMYWNjZXNzX3Rva2VuGA'
    'IgASgLMhYucmVzb25hdGUuVG9rZW5NZXNzYWdlUgthY2Nlc3NUb2tlbg==');

@$core.Deprecated('Use refreshAuthMessageDescriptor instead')
const RefreshAuthMessage$json = {
  '1': 'RefreshAuthMessage',
  '2': [
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RefreshAuthMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RefreshAuthMessage.Response',
      '10': 'response'
    },
  ],
  '3': [RefreshAuthMessage_Request$json, RefreshAuthMessage_Response$json],
};

@$core.Deprecated('Use refreshAuthMessageDescriptor instead')
const RefreshAuthMessage_Request$json = {
  '1': 'Request',
  '2': [
    {
      '1': 'request_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RequestInfo',
      '10': 'requestInfo'
    },
    {
      '1': 'refresh_token',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.TokenMessage',
      '10': 'refreshToken'
    },
  ],
};

@$core.Deprecated('Use refreshAuthMessageDescriptor instead')
const RefreshAuthMessage_Response$json = {
  '1': 'Response',
  '2': [
    {
      '1': 'response_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ResponseInfo',
      '10': 'responseInfo'
    },
    {
      '1': 'access_token',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.TokenMessage',
      '10': 'accessToken'
    },
  ],
};

/// Descriptor for `RefreshAuthMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshAuthMessageDescriptor = $convert.base64Decode(
    'ChJSZWZyZXNoQXV0aE1lc3NhZ2USQgoHcmVxdWVzdBgBIAEoCzIoLnJlc29uYXRlLmFwaS5SZW'
    'ZyZXNoQXV0aE1lc3NhZ2UuUmVxdWVzdFIHcmVxdWVzdBJFCghyZXNwb25zZRgCIAEoCzIpLnJl'
    'c29uYXRlLmFwaS5SZWZyZXNoQXV0aE1lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGoQBCgdSZX'
    'F1ZXN0EjwKDHJlcXVlc3RfaW5mbxgBIAEoCzIZLnJlc29uYXRlLmFwaS5SZXF1ZXN0SW5mb1IL'
    'cmVxdWVzdEluZm8SOwoNcmVmcmVzaF90b2tlbhgCIAEoCzIWLnJlc29uYXRlLlRva2VuTWVzc2'
    'FnZVIMcmVmcmVzaFRva2VuGoYBCghSZXNwb25zZRI/Cg1yZXNwb25zZV9pbmZvGAEgASgLMhou'
    'cmVzb25hdGUuYXBpLlJlc3BvbnNlSW5mb1IMcmVzcG9uc2VJbmZvEjkKDGFjY2Vzc190b2tlbh'
    'gCIAEoCzIWLnJlc29uYXRlLlRva2VuTWVzc2FnZVILYWNjZXNzVG9rZW4=');

@$core.Deprecated('Use loginRequestMessageDescriptor instead')
const LoginRequestMessage$json = {
  '1': 'LoginRequestMessage',
  '2': [
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.LoginRequestMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.LoginRequestMessage.Response',
      '10': 'response'
    },
  ],
  '3': [LoginRequestMessage_Request$json, LoginRequestMessage_Response$json],
};

@$core.Deprecated('Use loginRequestMessageDescriptor instead')
const LoginRequestMessage_Request$json = {
  '1': 'Request',
  '2': [
    {
      '1': 'request_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RequestInfo',
      '10': 'requestInfo'
    },
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
  ],
};

@$core.Deprecated('Use loginRequestMessageDescriptor instead')
const LoginRequestMessage_Response$json = {
  '1': 'Response',
  '2': [
    {
      '1': 'response_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ResponseInfo',
      '10': 'responseInfo'
    },
  ],
};

/// Descriptor for `LoginRequestMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginRequestMessageDescriptor = $convert.base64Decode(
    'ChNMb2dpblJlcXVlc3RNZXNzYWdlEkMKB3JlcXVlc3QYASABKAsyKS5yZXNvbmF0ZS5hcGkuTG'
    '9naW5SZXF1ZXN0TWVzc2FnZS5SZXF1ZXN0UgdyZXF1ZXN0EkYKCHJlc3BvbnNlGAIgASgLMiou'
    'cmVzb25hdGUuYXBpLkxvZ2luUmVxdWVzdE1lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGl0KB1'
    'JlcXVlc3QSPAoMcmVxdWVzdF9pbmZvGAEgASgLMhkucmVzb25hdGUuYXBpLlJlcXVlc3RJbmZv'
    'UgtyZXF1ZXN0SW5mbxIUCgVlbWFpbBgCIAEoCVIFZW1haWwaSwoIUmVzcG9uc2USPwoNcmVzcG'
    '9uc2VfaW5mbxgBIAEoCzIaLnJlc29uYXRlLmFwaS5SZXNwb25zZUluZm9SDHJlc3BvbnNlSW5m'
    'bw==');

@$core.Deprecated('Use loginUserMessageDescriptor instead')
const LoginUserMessage$json = {
  '1': 'LoginUserMessage',
  '2': [
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.LoginUserMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.LoginUserMessage.Response',
      '10': 'response'
    },
  ],
  '3': [LoginUserMessage_Request$json, LoginUserMessage_Response$json],
};

@$core.Deprecated('Use loginUserMessageDescriptor instead')
const LoginUserMessage_Request$json = {
  '1': 'Request',
  '2': [
    {
      '1': 'request_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RequestInfo',
      '10': 'requestInfo'
    },
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {'1': 'password', '3': 3, '4': 1, '5': 9, '10': 'password'},
  ],
};

@$core.Deprecated('Use loginUserMessageDescriptor instead')
const LoginUserMessage_Response$json = {
  '1': 'Response',
  '2': [
    {
      '1': 'response_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ResponseInfo',
      '10': 'responseInfo'
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
    {
      '1': 'user',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.resonate.UserMessage',
      '10': 'user'
    },
  ],
};

/// Descriptor for `LoginUserMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginUserMessageDescriptor = $convert.base64Decode(
    'ChBMb2dpblVzZXJNZXNzYWdlEkAKB3JlcXVlc3QYASABKAsyJi5yZXNvbmF0ZS5hcGkuTG9naW'
    '5Vc2VyTWVzc2FnZS5SZXF1ZXN0UgdyZXF1ZXN0EkMKCHJlc3BvbnNlGAIgASgLMicucmVzb25h'
    'dGUuYXBpLkxvZ2luVXNlck1lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGnkKB1JlcXVlc3QSPA'
    'oMcmVxdWVzdF9pbmZvGAEgASgLMhkucmVzb25hdGUuYXBpLlJlcXVlc3RJbmZvUgtyZXF1ZXN0'
    'SW5mbxIUCgVlbWFpbBgCIAEoCVIFZW1haWwSGgoIcGFzc3dvcmQYAyABKAlSCHBhc3N3b3JkGu'
    '4BCghSZXNwb25zZRI/Cg1yZXNwb25zZV9pbmZvGAEgASgLMhoucmVzb25hdGUuYXBpLlJlc3Bv'
    'bnNlSW5mb1IMcmVzcG9uc2VJbmZvEjkKDGFjY2Vzc190b2tlbhgCIAEoCzIWLnJlc29uYXRlLl'
    'Rva2VuTWVzc2FnZVILYWNjZXNzVG9rZW4SOwoNcmVmcmVzaF90b2tlbhgDIAEoCzIWLnJlc29u'
    'YXRlLlRva2VuTWVzc2FnZVIMcmVmcmVzaFRva2VuEikKBHVzZXIYBCABKAsyFS5yZXNvbmF0ZS'
    '5Vc2VyTWVzc2FnZVIEdXNlcg==');

@$core.Deprecated('Use createUserMessageDescriptor instead')
const CreateUserMessage$json = {
  '1': 'CreateUserMessage',
  '2': [
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.CreateUserMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.CreateUserMessage.Response',
      '10': 'response'
    },
  ],
  '3': [CreateUserMessage_Request$json, CreateUserMessage_Response$json],
};

@$core.Deprecated('Use createUserMessageDescriptor instead')
const CreateUserMessage_Request$json = {
  '1': 'Request',
  '2': [
    {
      '1': 'request_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RequestInfo',
      '10': 'requestInfo'
    },
    {
      '1': 'user',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.UserMessage',
      '10': 'user'
    },
  ],
};

@$core.Deprecated('Use createUserMessageDescriptor instead')
const CreateUserMessage_Response$json = {
  '1': 'Response',
  '2': [
    {
      '1': 'response_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ResponseInfo',
      '10': 'responseInfo'
    },
    {
      '1': 'user',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.UserMessage',
      '10': 'user'
    },
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
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.GetUserMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.GetUserMessage.Response',
      '10': 'response'
    },
  ],
  '3': [GetUserMessage_Request$json, GetUserMessage_Response$json],
};

@$core.Deprecated('Use getUserMessageDescriptor instead')
const GetUserMessage_Request$json = {
  '1': 'Request',
  '2': [
    {
      '1': 'request_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RequestInfo',
      '10': 'requestInfo'
    },
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

@$core.Deprecated('Use getUserMessageDescriptor instead')
const GetUserMessage_Response$json = {
  '1': 'Response',
  '2': [
    {
      '1': 'response_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ResponseInfo',
      '10': 'responseInfo'
    },
    {
      '1': 'user',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.UserMessage',
      '10': 'user'
    },
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
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.UpdateUserMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.UpdateUserMessage.Response',
      '10': 'response'
    },
  ],
  '3': [UpdateUserMessage_Request$json, UpdateUserMessage_Response$json],
};

@$core.Deprecated('Use updateUserMessageDescriptor instead')
const UpdateUserMessage_Request$json = {
  '1': 'Request',
  '2': [
    {
      '1': 'request_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RequestInfo',
      '10': 'requestInfo'
    },
    {
      '1': 'user',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.UserMessage',
      '10': 'user'
    },
  ],
};

@$core.Deprecated('Use updateUserMessageDescriptor instead')
const UpdateUserMessage_Response$json = {
  '1': 'Response',
  '2': [
    {
      '1': 'response_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ResponseInfo',
      '10': 'responseInfo'
    },
    {
      '1': 'user',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.UserMessage',
      '10': 'user'
    },
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
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.SearchMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.SearchMessage.Response',
      '10': 'response'
    },
  ],
  '3': [SearchMessage_Request$json, SearchMessage_Response$json],
};

@$core.Deprecated('Use searchMessageDescriptor instead')
const SearchMessage_Request$json = {
  '1': 'Request',
  '2': [
    {
      '1': 'request_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RequestInfo',
      '10': 'requestInfo'
    },
    {'1': 'query', '3': 2, '4': 1, '5': 9, '10': 'query'},
  ],
};

@$core.Deprecated('Use searchMessageDescriptor instead')
const SearchMessage_Response$json = {
  '1': 'Response',
  '2': [
    {
      '1': 'response_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ResponseInfo',
      '10': 'responseInfo'
    },
    {
      '1': 'search_results',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.SearchResultsMessage',
      '10': 'searchResults'
    },
  ],
};

/// Descriptor for `SearchMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchMessageDescriptor = $convert.base64Decode(
    'Cg1TZWFyY2hNZXNzYWdlEj0KB3JlcXVlc3QYASABKAsyIy5yZXNvbmF0ZS5hcGkuU2VhcmNoTW'
    'Vzc2FnZS5SZXF1ZXN0UgdyZXF1ZXN0EkAKCHJlc3BvbnNlGAIgASgLMiQucmVzb25hdGUuYXBp'
    'LlNlYXJjaE1lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGl0KB1JlcXVlc3QSPAoMcmVxdWVzdF'
    '9pbmZvGAEgASgLMhkucmVzb25hdGUuYXBpLlJlcXVlc3RJbmZvUgtyZXF1ZXN0SW5mbxIUCgVx'
    'dWVyeRgCIAEoCVIFcXVlcnkakgEKCFJlc3BvbnNlEj8KDXJlc3BvbnNlX2luZm8YASABKAsyGi'
    '5yZXNvbmF0ZS5hcGkuUmVzcG9uc2VJbmZvUgxyZXNwb25zZUluZm8SRQoOc2VhcmNoX3Jlc3Vs'
    'dHMYAiABKAsyHi5yZXNvbmF0ZS5TZWFyY2hSZXN1bHRzTWVzc2FnZVINc2VhcmNoUmVzdWx0cw'
    '==');

@$core.Deprecated('Use getPodcastMessageDescriptor instead')
const GetPodcastMessage$json = {
  '1': 'GetPodcastMessage',
  '2': [
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.GetPodcastMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.GetPodcastMessage.Response',
      '10': 'response'
    },
  ],
  '3': [GetPodcastMessage_Request$json, GetPodcastMessage_Response$json],
};

@$core.Deprecated('Use getPodcastMessageDescriptor instead')
const GetPodcastMessage_Request$json = {
  '1': 'Request',
  '2': [
    {
      '1': 'request_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RequestInfo',
      '10': 'requestInfo'
    },
    {'1': 'podcast_id', '3': 2, '4': 1, '5': 9, '10': 'podcastId'},
  ],
};

@$core.Deprecated('Use getPodcastMessageDescriptor instead')
const GetPodcastMessage_Response$json = {
  '1': 'Response',
  '2': [
    {
      '1': 'response_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ResponseInfo',
      '10': 'responseInfo'
    },
    {
      '1': 'podcast',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.PodcastMessage',
      '10': 'podcast'
    },
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

@$core.Deprecated('Use listPodcastEpisodesMessageDescriptor instead')
const ListPodcastEpisodesMessage$json = {
  '1': 'ListPodcastEpisodesMessage',
  '2': [
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ListPodcastEpisodesMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ListPodcastEpisodesMessage.Response',
      '10': 'response'
    },
  ],
  '3': [
    ListPodcastEpisodesMessage_Request$json,
    ListPodcastEpisodesMessage_Response$json
  ],
};

@$core.Deprecated('Use listPodcastEpisodesMessageDescriptor instead')
const ListPodcastEpisodesMessage_Request$json = {
  '1': 'Request',
  '2': [
    {
      '1': 'request_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RequestInfo',
      '10': 'requestInfo'
    },
    {'1': 'podcast_id', '3': 2, '4': 1, '5': 9, '10': 'podcastId'},
  ],
};

@$core.Deprecated('Use listPodcastEpisodesMessageDescriptor instead')
const ListPodcastEpisodesMessage_Response$json = {
  '1': 'Response',
  '2': [
    {
      '1': 'response_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ResponseInfo',
      '10': 'responseInfo'
    },
    {
      '1': 'episodes',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.resonate.EpisodeMessage',
      '10': 'episodes'
    },
    {
      '1': 'podcast',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.resonate.PodcastMessage',
      '10': 'podcast'
    },
  ],
};

/// Descriptor for `ListPodcastEpisodesMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPodcastEpisodesMessageDescriptor = $convert.base64Decode(
    'ChpMaXN0UG9kY2FzdEVwaXNvZGVzTWVzc2FnZRJKCgdyZXF1ZXN0GAEgASgLMjAucmVzb25hdG'
    'UuYXBpLkxpc3RQb2RjYXN0RXBpc29kZXNNZXNzYWdlLlJlcXVlc3RSB3JlcXVlc3QSTQoIcmVz'
    'cG9uc2UYAiABKAsyMS5yZXNvbmF0ZS5hcGkuTGlzdFBvZGNhc3RFcGlzb2Rlc01lc3NhZ2UuUm'
    'VzcG9uc2VSCHJlc3BvbnNlGmYKB1JlcXVlc3QSPAoMcmVxdWVzdF9pbmZvGAEgASgLMhkucmVz'
    'b25hdGUuYXBpLlJlcXVlc3RJbmZvUgtyZXF1ZXN0SW5mbxIdCgpwb2RjYXN0X2lkGAIgASgJUg'
    'lwb2RjYXN0SWQatQEKCFJlc3BvbnNlEj8KDXJlc3BvbnNlX2luZm8YASABKAsyGi5yZXNvbmF0'
    'ZS5hcGkuUmVzcG9uc2VJbmZvUgxyZXNwb25zZUluZm8SNAoIZXBpc29kZXMYAiADKAsyGC5yZX'
    'NvbmF0ZS5FcGlzb2RlTWVzc2FnZVIIZXBpc29kZXMSMgoHcG9kY2FzdBgDIAEoCzIYLnJlc29u'
    'YXRlLlBvZGNhc3RNZXNzYWdlUgdwb2RjYXN0');

@$core.Deprecated('Use getEpisodeMessageDescriptor instead')
const GetEpisodeMessage$json = {
  '1': 'GetEpisodeMessage',
  '2': [
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.GetEpisodeMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.GetEpisodeMessage.Response',
      '10': 'response'
    },
  ],
  '3': [GetEpisodeMessage_Request$json, GetEpisodeMessage_Response$json],
};

@$core.Deprecated('Use getEpisodeMessageDescriptor instead')
const GetEpisodeMessage_Request$json = {
  '1': 'Request',
  '2': [
    {
      '1': 'request_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RequestInfo',
      '10': 'requestInfo'
    },
    {'1': 'episode_id', '3': 2, '4': 1, '5': 9, '10': 'episodeId'},
  ],
};

@$core.Deprecated('Use getEpisodeMessageDescriptor instead')
const GetEpisodeMessage_Response$json = {
  '1': 'Response',
  '2': [
    {
      '1': 'response_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ResponseInfo',
      '10': 'responseInfo'
    },
    {
      '1': 'episode',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.EpisodeMessage',
      '10': 'episode'
    },
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
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.AddSubscriptionMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.AddSubscriptionMessage.Response',
      '10': 'response'
    },
  ],
  '3': [
    AddSubscriptionMessage_Request$json,
    AddSubscriptionMessage_Response$json
  ],
};

@$core.Deprecated('Use addSubscriptionMessageDescriptor instead')
const AddSubscriptionMessage_Request$json = {
  '1': 'Request',
  '2': [
    {
      '1': 'request_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RequestInfo',
      '10': 'requestInfo'
    },
    {
      '1': 'subscription',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.UserSubscriptionMessage',
      '10': 'subscription'
    },
  ],
};

@$core.Deprecated('Use addSubscriptionMessageDescriptor instead')
const AddSubscriptionMessage_Response$json = {
  '1': 'Response',
  '2': [
    {
      '1': 'response_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ResponseInfo',
      '10': 'responseInfo'
    },
    {
      '1': 'subscription',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.UserSubscriptionMessage',
      '10': 'subscription'
    },
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
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RemoveSubscriptionMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RemoveSubscriptionMessage.Response',
      '10': 'response'
    },
  ],
  '3': [
    RemoveSubscriptionMessage_Request$json,
    RemoveSubscriptionMessage_Response$json
  ],
};

@$core.Deprecated('Use removeSubscriptionMessageDescriptor instead')
const RemoveSubscriptionMessage_Request$json = {
  '1': 'Request',
  '2': [
    {
      '1': 'request_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RequestInfo',
      '10': 'requestInfo'
    },
    {
      '1': 'subscription',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.UserSubscriptionMessage',
      '10': 'subscription'
    },
  ],
};

@$core.Deprecated('Use removeSubscriptionMessageDescriptor instead')
const RemoveSubscriptionMessage_Response$json = {
  '1': 'Response',
  '2': [
    {
      '1': 'response_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ResponseInfo',
      '10': 'responseInfo'
    },
    {
      '1': 'subscription',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.UserSubscriptionMessage',
      '10': 'subscription'
    },
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

@$core.Deprecated('Use listSubscriptionMessageDescriptor instead')
const ListSubscriptionMessage$json = {
  '1': 'ListSubscriptionMessage',
  '2': [
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ListSubscriptionMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ListSubscriptionMessage.Response',
      '10': 'response'
    },
  ],
  '3': [
    ListSubscriptionMessage_Request$json,
    ListSubscriptionMessage_Response$json
  ],
};

@$core.Deprecated('Use listSubscriptionMessageDescriptor instead')
const ListSubscriptionMessage_Request$json = {
  '1': 'Request',
  '2': [
    {
      '1': 'request_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RequestInfo',
      '10': 'requestInfo'
    },
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

@$core.Deprecated('Use listSubscriptionMessageDescriptor instead')
const ListSubscriptionMessage_Response$json = {
  '1': 'Response',
  '2': [
    {
      '1': 'response_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ResponseInfo',
      '10': 'responseInfo'
    },
    {
      '1': 'subscriptions',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.resonate.UserSubscriptionMessage',
      '10': 'subscriptions'
    },
  ],
};

/// Descriptor for `ListSubscriptionMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listSubscriptionMessageDescriptor = $convert.base64Decode(
    'ChdMaXN0U3Vic2NyaXB0aW9uTWVzc2FnZRJHCgdyZXF1ZXN0GAEgASgLMi0ucmVzb25hdGUuYX'
    'BpLkxpc3RTdWJzY3JpcHRpb25NZXNzYWdlLlJlcXVlc3RSB3JlcXVlc3QSSgoIcmVzcG9uc2UY'
    'AiABKAsyLi5yZXNvbmF0ZS5hcGkuTGlzdFN1YnNjcmlwdGlvbk1lc3NhZ2UuUmVzcG9uc2VSCH'
    'Jlc3BvbnNlGmAKB1JlcXVlc3QSPAoMcmVxdWVzdF9pbmZvGAEgASgLMhkucmVzb25hdGUuYXBp'
    'LlJlcXVlc3RJbmZvUgtyZXF1ZXN0SW5mbxIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQalAEKCF'
    'Jlc3BvbnNlEj8KDXJlc3BvbnNlX2luZm8YASABKAsyGi5yZXNvbmF0ZS5hcGkuUmVzcG9uc2VJ'
    'bmZvUgxyZXNwb25zZUluZm8SRwoNc3Vic2NyaXB0aW9ucxgCIAMoCzIhLnJlc29uYXRlLlVzZX'
    'JTdWJzY3JpcHRpb25NZXNzYWdlUg1zdWJzY3JpcHRpb25z');

@$core.Deprecated('Use addListenMessageDescriptor instead')
const AddListenMessage$json = {
  '1': 'AddListenMessage',
  '2': [
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.AddListenMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.AddListenMessage.Response',
      '10': 'response'
    },
  ],
  '3': [AddListenMessage_Request$json, AddListenMessage_Response$json],
};

@$core.Deprecated('Use addListenMessageDescriptor instead')
const AddListenMessage_Request$json = {
  '1': 'Request',
  '2': [
    {
      '1': 'request_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RequestInfo',
      '10': 'requestInfo'
    },
    {
      '1': 'listen',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.UserListenMessage',
      '10': 'listen'
    },
  ],
};

@$core.Deprecated('Use addListenMessageDescriptor instead')
const AddListenMessage_Response$json = {
  '1': 'Response',
  '2': [
    {
      '1': 'response_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ResponseInfo',
      '10': 'responseInfo'
    },
    {
      '1': 'listen',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.UserListenMessage',
      '10': 'listen'
    },
  ],
};

/// Descriptor for `AddListenMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addListenMessageDescriptor = $convert.base64Decode(
    'ChBBZGRMaXN0ZW5NZXNzYWdlEkAKB3JlcXVlc3QYASABKAsyJi5yZXNvbmF0ZS5hcGkuQWRkTG'
    'lzdGVuTWVzc2FnZS5SZXF1ZXN0UgdyZXF1ZXN0EkMKCHJlc3BvbnNlGAIgASgLMicucmVzb25h'
    'dGUuYXBpLkFkZExpc3Rlbk1lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGnwKB1JlcXVlc3QSPA'
    'oMcmVxdWVzdF9pbmZvGAEgASgLMhkucmVzb25hdGUuYXBpLlJlcXVlc3RJbmZvUgtyZXF1ZXN0'
    'SW5mbxIzCgZsaXN0ZW4YAiABKAsyGy5yZXNvbmF0ZS5Vc2VyTGlzdGVuTWVzc2FnZVIGbGlzdG'
    'VuGoABCghSZXNwb25zZRI/Cg1yZXNwb25zZV9pbmZvGAEgASgLMhoucmVzb25hdGUuYXBpLlJl'
    'c3BvbnNlSW5mb1IMcmVzcG9uc2VJbmZvEjMKBmxpc3RlbhgCIAEoCzIbLnJlc29uYXRlLlVzZX'
    'JMaXN0ZW5NZXNzYWdlUgZsaXN0ZW4=');

@$core.Deprecated('Use removeListenMessageDescriptor instead')
const RemoveListenMessage$json = {
  '1': 'RemoveListenMessage',
  '2': [
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RemoveListenMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RemoveListenMessage.Response',
      '10': 'response'
    },
  ],
  '3': [RemoveListenMessage_Request$json, RemoveListenMessage_Response$json],
};

@$core.Deprecated('Use removeListenMessageDescriptor instead')
const RemoveListenMessage_Request$json = {
  '1': 'Request',
  '2': [
    {
      '1': 'request_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RequestInfo',
      '10': 'requestInfo'
    },
    {
      '1': 'listen',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.UserListenMessage',
      '10': 'listen'
    },
  ],
};

@$core.Deprecated('Use removeListenMessageDescriptor instead')
const RemoveListenMessage_Response$json = {
  '1': 'Response',
  '2': [
    {
      '1': 'response_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ResponseInfo',
      '10': 'responseInfo'
    },
    {
      '1': 'listen',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.UserListenMessage',
      '10': 'listen'
    },
  ],
};

/// Descriptor for `RemoveListenMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeListenMessageDescriptor = $convert.base64Decode(
    'ChNSZW1vdmVMaXN0ZW5NZXNzYWdlEkMKB3JlcXVlc3QYASABKAsyKS5yZXNvbmF0ZS5hcGkuUm'
    'Vtb3ZlTGlzdGVuTWVzc2FnZS5SZXF1ZXN0UgdyZXF1ZXN0EkYKCHJlc3BvbnNlGAIgASgLMiou'
    'cmVzb25hdGUuYXBpLlJlbW92ZUxpc3Rlbk1lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGnwKB1'
    'JlcXVlc3QSPAoMcmVxdWVzdF9pbmZvGAEgASgLMhkucmVzb25hdGUuYXBpLlJlcXVlc3RJbmZv'
    'UgtyZXF1ZXN0SW5mbxIzCgZsaXN0ZW4YAiABKAsyGy5yZXNvbmF0ZS5Vc2VyTGlzdGVuTWVzc2'
    'FnZVIGbGlzdGVuGoABCghSZXNwb25zZRI/Cg1yZXNwb25zZV9pbmZvGAEgASgLMhoucmVzb25h'
    'dGUuYXBpLlJlc3BvbnNlSW5mb1IMcmVzcG9uc2VJbmZvEjMKBmxpc3RlbhgCIAEoCzIbLnJlc2'
    '9uYXRlLlVzZXJMaXN0ZW5NZXNzYWdlUgZsaXN0ZW4=');

@$core.Deprecated('Use listListenMessageDescriptor instead')
const ListListenMessage$json = {
  '1': 'ListListenMessage',
  '2': [
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ListListenMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ListListenMessage.Response',
      '10': 'response'
    },
  ],
  '3': [ListListenMessage_Request$json, ListListenMessage_Response$json],
};

@$core.Deprecated('Use listListenMessageDescriptor instead')
const ListListenMessage_Request$json = {
  '1': 'Request',
  '2': [
    {
      '1': 'request_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RequestInfo',
      '10': 'requestInfo'
    },
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

@$core.Deprecated('Use listListenMessageDescriptor instead')
const ListListenMessage_Response$json = {
  '1': 'Response',
  '2': [
    {
      '1': 'response_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ResponseInfo',
      '10': 'responseInfo'
    },
    {
      '1': 'listens',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.resonate.UserListenMessage',
      '10': 'listens'
    },
  ],
};

/// Descriptor for `ListListenMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listListenMessageDescriptor = $convert.base64Decode(
    'ChFMaXN0TGlzdGVuTWVzc2FnZRJBCgdyZXF1ZXN0GAEgASgLMicucmVzb25hdGUuYXBpLkxpc3'
    'RMaXN0ZW5NZXNzYWdlLlJlcXVlc3RSB3JlcXVlc3QSRAoIcmVzcG9uc2UYAiABKAsyKC5yZXNv'
    'bmF0ZS5hcGkuTGlzdExpc3Rlbk1lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGmAKB1JlcXVlc3'
    'QSPAoMcmVxdWVzdF9pbmZvGAEgASgLMhkucmVzb25hdGUuYXBpLlJlcXVlc3RJbmZvUgtyZXF1'
    'ZXN0SW5mbxIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQaggEKCFJlc3BvbnNlEj8KDXJlc3Bvbn'
    'NlX2luZm8YASABKAsyGi5yZXNvbmF0ZS5hcGkuUmVzcG9uc2VJbmZvUgxyZXNwb25zZUluZm8S'
    'NQoHbGlzdGVucxgCIAMoCzIbLnJlc29uYXRlLlVzZXJMaXN0ZW5NZXNzYWdlUgdsaXN0ZW5z');

@$core.Deprecated('Use getFeedMessageDescriptor instead')
const GetFeedMessage$json = {
  '1': 'GetFeedMessage',
  '2': [
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.GetFeedMessage.Request',
      '10': 'request'
    },
    {
      '1': 'reponse',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.GetFeedMessage.Response',
      '10': 'reponse'
    },
  ],
  '3': [GetFeedMessage_Request$json, GetFeedMessage_Response$json],
};

@$core.Deprecated('Use getFeedMessageDescriptor instead')
const GetFeedMessage_Request$json = {
  '1': 'Request',
  '2': [
    {
      '1': 'request_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RequestInfo',
      '10': 'requestInfo'
    },
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {
      '1': 'before_timestamp_ms',
      '3': 3,
      '4': 1,
      '5': 3,
      '10': 'beforeTimestampMs'
    },
  ],
};

@$core.Deprecated('Use getFeedMessageDescriptor instead')
const GetFeedMessage_Response$json = {
  '1': 'Response',
  '2': [
    {
      '1': 'response_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ResponseInfo',
      '10': 'responseInfo'
    },
    {
      '1': 'feed',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.UserFeedMessage',
      '10': 'feed'
    },
  ],
};

/// Descriptor for `GetFeedMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFeedMessageDescriptor = $convert.base64Decode(
    'Cg5HZXRGZWVkTWVzc2FnZRI+CgdyZXF1ZXN0GAEgASgLMiQucmVzb25hdGUuYXBpLkdldEZlZW'
    'RNZXNzYWdlLlJlcXVlc3RSB3JlcXVlc3QSPwoHcmVwb25zZRgCIAEoCzIlLnJlc29uYXRlLmFw'
    'aS5HZXRGZWVkTWVzc2FnZS5SZXNwb25zZVIHcmVwb25zZRqQAQoHUmVxdWVzdBI8CgxyZXF1ZX'
    'N0X2luZm8YASABKAsyGS5yZXNvbmF0ZS5hcGkuUmVxdWVzdEluZm9SC3JlcXVlc3RJbmZvEhcK'
    'B3VzZXJfaWQYAiABKAlSBnVzZXJJZBIuChNiZWZvcmVfdGltZXN0YW1wX21zGAMgASgDUhFiZW'
    'ZvcmVUaW1lc3RhbXBNcxp6CghSZXNwb25zZRI/Cg1yZXNwb25zZV9pbmZvGAEgASgLMhoucmVz'
    'b25hdGUuYXBpLlJlc3BvbnNlSW5mb1IMcmVzcG9uc2VJbmZvEi0KBGZlZWQYAiABKAsyGS5yZX'
    'NvbmF0ZS5Vc2VyRmVlZE1lc3NhZ2VSBGZlZWQ=');
