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

@$core.Deprecated('Use internalResponseInfoDescriptor instead')
const InternalResponseInfo$json = {
  '1': 'InternalResponseInfo',
  '2': [
    {
      '1': 'access_token',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.TokenMessage',
      '10': 'accessToken'
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

/// Descriptor for `InternalResponseInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List internalResponseInfoDescriptor = $convert.base64Decode(
    'ChRJbnRlcm5hbFJlc3BvbnNlSW5mbxI5CgxhY2Nlc3NfdG9rZW4YASABKAsyFi5yZXNvbmF0ZS'
    '5Ub2tlbk1lc3NhZ2VSC2FjY2Vzc1Rva2VuEjsKDXJlZnJlc2hfdG9rZW4YAiABKAsyFi5yZXNv'
    'bmF0ZS5Ub2tlbk1lc3NhZ2VSDHJlZnJlc2hUb2tlbg==');

@$core.Deprecated('Use responseInfoDescriptor instead')
const ResponseInfo$json = {
  '1': 'ResponseInfo',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_message', '3': 2, '4': 1, '5': 9, '10': 'errorMessage'},
    {
      '1': 'error',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.resonate.ErrorEnum',
      '10': 'error'
    },
    {
      '1': 'internal_info',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.InternalResponseInfo',
      '10': 'internalInfo'
    },
  ],
};

/// Descriptor for `ResponseInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List responseInfoDescriptor = $convert.base64Decode(
    'CgxSZXNwb25zZUluZm8SGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIjCg1lcnJvcl9tZXNzYW'
    'dlGAIgASgJUgxlcnJvck1lc3NhZ2USKQoFZXJyb3IYAyABKA4yEy5yZXNvbmF0ZS5FcnJvckVu'
    'dW1SBWVycm9yEkcKDWludGVybmFsX2luZm8YBCABKAsyIi5yZXNvbmF0ZS5hcGkuSW50ZXJuYW'
    'xSZXNwb25zZUluZm9SDGludGVybmFsSW5mbw==');

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
    {'1': 'phone_number', '3': 3, '4': 1, '5': 9, '10': 'phoneNumber'},
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
    'cmVzb25hdGUuYXBpLkxvZ2luUmVxdWVzdE1lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGoABCg'
    'dSZXF1ZXN0EjwKDHJlcXVlc3RfaW5mbxgBIAEoCzIZLnJlc29uYXRlLmFwaS5SZXF1ZXN0SW5m'
    'b1ILcmVxdWVzdEluZm8SFAoFZW1haWwYAiABKAlSBWVtYWlsEiEKDHBob25lX251bWJlchgDIA'
    'EoCVILcGhvbmVOdW1iZXIaSwoIUmVzcG9uc2USPwoNcmVzcG9uc2VfaW5mbxgBIAEoCzIaLnJl'
    'c29uYXRlLmFwaS5SZXNwb25zZUluZm9SDHJlc3BvbnNlSW5mbw==');

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
    {'1': 'phone_number', '3': 4, '4': 1, '5': 9, '10': 'phoneNumber'},
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
    'dGUuYXBpLkxvZ2luVXNlck1lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGpwBCgdSZXF1ZXN0Ej'
    'wKDHJlcXVlc3RfaW5mbxgBIAEoCzIZLnJlc29uYXRlLmFwaS5SZXF1ZXN0SW5mb1ILcmVxdWVz'
    'dEluZm8SFAoFZW1haWwYAiABKAlSBWVtYWlsEhoKCHBhc3N3b3JkGAMgASgJUghwYXNzd29yZB'
    'IhCgxwaG9uZV9udW1iZXIYBCABKAlSC3Bob25lTnVtYmVyGu4BCghSZXNwb25zZRI/Cg1yZXNw'
    'b25zZV9pbmZvGAEgASgLMhoucmVzb25hdGUuYXBpLlJlc3BvbnNlSW5mb1IMcmVzcG9uc2VJbm'
    'ZvEjkKDGFjY2Vzc190b2tlbhgCIAEoCzIWLnJlc29uYXRlLlRva2VuTWVzc2FnZVILYWNjZXNz'
    'VG9rZW4SOwoNcmVmcmVzaF90b2tlbhgDIAEoCzIWLnJlc29uYXRlLlRva2VuTWVzc2FnZVIMcm'
    'VmcmVzaFRva2VuEikKBHVzZXIYBCABKAsyFS5yZXNvbmF0ZS5Vc2VyTWVzc2FnZVIEdXNlcg==');

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

@$core.Deprecated('Use searchTopMessageDescriptor instead')
const SearchTopMessage$json = {
  '1': 'SearchTopMessage',
  '2': [
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.SearchTopMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.SearchTopMessage.Response',
      '10': 'response'
    },
  ],
  '3': [SearchTopMessage_Request$json, SearchTopMessage_Response$json],
};

@$core.Deprecated('Use searchTopMessageDescriptor instead')
const SearchTopMessage_Request$json = {
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
  ],
};

@$core.Deprecated('Use searchTopMessageDescriptor instead')
const SearchTopMessage_Response$json = {
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

/// Descriptor for `SearchTopMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchTopMessageDescriptor = $convert.base64Decode(
    'ChBTZWFyY2hUb3BNZXNzYWdlEkAKB3JlcXVlc3QYASABKAsyJi5yZXNvbmF0ZS5hcGkuU2Vhcm'
    'NoVG9wTWVzc2FnZS5SZXF1ZXN0UgdyZXF1ZXN0EkMKCHJlc3BvbnNlGAIgASgLMicucmVzb25h'
    'dGUuYXBpLlNlYXJjaFRvcE1lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGkcKB1JlcXVlc3QSPA'
    'oMcmVxdWVzdF9pbmZvGAEgASgLMhkucmVzb25hdGUuYXBpLlJlcXVlc3RJbmZvUgtyZXF1ZXN0'
    'SW5mbxqSAQoIUmVzcG9uc2USPwoNcmVzcG9uc2VfaW5mbxgBIAEoCzIaLnJlc29uYXRlLmFwaS'
    '5SZXNwb25zZUluZm9SDHJlc3BvbnNlSW5mbxJFCg5zZWFyY2hfcmVzdWx0cxgCIAEoCzIeLnJl'
    'c29uYXRlLlNlYXJjaFJlc3VsdHNNZXNzYWdlUg1zZWFyY2hSZXN1bHRz');

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

@$core.Deprecated('Use queryCursorDescriptor instead')
const QueryCursor$json = {
  '1': 'QueryCursor',
  '2': [
    {'1': 'cursor', '3': 1, '4': 1, '5': 9, '10': 'cursor'},
    {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `QueryCursor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryCursorDescriptor = $convert.base64Decode(
    'CgtRdWVyeUN1cnNvchIWCgZjdXJzb3IYASABKAlSBmN1cnNvchIWCgZvZmZzZXQYAiABKAVSBm'
    '9mZnNldA==');

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
    {
      '1': 'cursor',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.QueryCursor',
      '10': 'cursor'
    },
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
    {
      '1': 'cursor',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.QueryCursor',
      '10': 'cursor'
    },
  ],
};

/// Descriptor for `ListPodcastEpisodesMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPodcastEpisodesMessageDescriptor = $convert.base64Decode(
    'ChpMaXN0UG9kY2FzdEVwaXNvZGVzTWVzc2FnZRJKCgdyZXF1ZXN0GAEgASgLMjAucmVzb25hdG'
    'UuYXBpLkxpc3RQb2RjYXN0RXBpc29kZXNNZXNzYWdlLlJlcXVlc3RSB3JlcXVlc3QSTQoIcmVz'
    'cG9uc2UYAiABKAsyMS5yZXNvbmF0ZS5hcGkuTGlzdFBvZGNhc3RFcGlzb2Rlc01lc3NhZ2UuUm'
    'VzcG9uc2VSCHJlc3BvbnNlGpkBCgdSZXF1ZXN0EjwKDHJlcXVlc3RfaW5mbxgBIAEoCzIZLnJl'
    'c29uYXRlLmFwaS5SZXF1ZXN0SW5mb1ILcmVxdWVzdEluZm8SHQoKcG9kY2FzdF9pZBgCIAEoCV'
    'IJcG9kY2FzdElkEjEKBmN1cnNvchgDIAEoCzIZLnJlc29uYXRlLmFwaS5RdWVyeUN1cnNvclIG'
    'Y3Vyc29yGugBCghSZXNwb25zZRI/Cg1yZXNwb25zZV9pbmZvGAEgASgLMhoucmVzb25hdGUuYX'
    'BpLlJlc3BvbnNlSW5mb1IMcmVzcG9uc2VJbmZvEjQKCGVwaXNvZGVzGAIgAygLMhgucmVzb25h'
    'dGUuRXBpc29kZU1lc3NhZ2VSCGVwaXNvZGVzEjIKB3BvZGNhc3QYAyABKAsyGC5yZXNvbmF0ZS'
    '5Qb2RjYXN0TWVzc2FnZVIHcG9kY2FzdBIxCgZjdXJzb3IYBCABKAsyGS5yZXNvbmF0ZS5hcGku'
    'UXVlcnlDdXJzb3JSBmN1cnNvcg==');

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
    {'1': 'include_podcasts', '3': 3, '4': 1, '5': 8, '10': 'includePodcasts'},
    {
      '1': 'cursor',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.QueryCursor',
      '10': 'cursor'
    },
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
    {
      '1': 'cursor',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.QueryCursor',
      '10': 'cursor'
    },
  ],
};

/// Descriptor for `ListSubscriptionMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listSubscriptionMessageDescriptor = $convert.base64Decode(
    'ChdMaXN0U3Vic2NyaXB0aW9uTWVzc2FnZRJHCgdyZXF1ZXN0GAEgASgLMi0ucmVzb25hdGUuYX'
    'BpLkxpc3RTdWJzY3JpcHRpb25NZXNzYWdlLlJlcXVlc3RSB3JlcXVlc3QSSgoIcmVzcG9uc2UY'
    'AiABKAsyLi5yZXNvbmF0ZS5hcGkuTGlzdFN1YnNjcmlwdGlvbk1lc3NhZ2UuUmVzcG9uc2VSCH'
    'Jlc3BvbnNlGr4BCgdSZXF1ZXN0EjwKDHJlcXVlc3RfaW5mbxgBIAEoCzIZLnJlc29uYXRlLmFw'
    'aS5SZXF1ZXN0SW5mb1ILcmVxdWVzdEluZm8SFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEikKEG'
    'luY2x1ZGVfcG9kY2FzdHMYAyABKAhSD2luY2x1ZGVQb2RjYXN0cxIxCgZjdXJzb3IYBCABKAsy'
    'GS5yZXNvbmF0ZS5hcGkuUXVlcnlDdXJzb3JSBmN1cnNvchrHAQoIUmVzcG9uc2USPwoNcmVzcG'
    '9uc2VfaW5mbxgBIAEoCzIaLnJlc29uYXRlLmFwaS5SZXNwb25zZUluZm9SDHJlc3BvbnNlSW5m'
    'bxJHCg1zdWJzY3JpcHRpb25zGAIgAygLMiEucmVzb25hdGUuVXNlclN1YnNjcmlwdGlvbk1lc3'
    'NhZ2VSDXN1YnNjcmlwdGlvbnMSMQoGY3Vyc29yGAMgASgLMhkucmVzb25hdGUuYXBpLlF1ZXJ5'
    'Q3Vyc29yUgZjdXJzb3I=');

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
    {'1': 'include_episodes', '3': 3, '4': 1, '5': 8, '10': 'includeEpisodes'},
    {
      '1': 'cursor',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.QueryCursor',
      '10': 'cursor'
    },
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
    {
      '1': 'cursor',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.QueryCursor',
      '10': 'cursor'
    },
  ],
};

/// Descriptor for `ListListenMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listListenMessageDescriptor = $convert.base64Decode(
    'ChFMaXN0TGlzdGVuTWVzc2FnZRJBCgdyZXF1ZXN0GAEgASgLMicucmVzb25hdGUuYXBpLkxpc3'
    'RMaXN0ZW5NZXNzYWdlLlJlcXVlc3RSB3JlcXVlc3QSRAoIcmVzcG9uc2UYAiABKAsyKC5yZXNv'
    'bmF0ZS5hcGkuTGlzdExpc3Rlbk1lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGr4BCgdSZXF1ZX'
    'N0EjwKDHJlcXVlc3RfaW5mbxgBIAEoCzIZLnJlc29uYXRlLmFwaS5SZXF1ZXN0SW5mb1ILcmVx'
    'dWVzdEluZm8SFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEikKEGluY2x1ZGVfZXBpc29kZXMYAy'
    'ABKAhSD2luY2x1ZGVFcGlzb2RlcxIxCgZjdXJzb3IYBCABKAsyGS5yZXNvbmF0ZS5hcGkuUXVl'
    'cnlDdXJzb3JSBmN1cnNvchq1AQoIUmVzcG9uc2USPwoNcmVzcG9uc2VfaW5mbxgBIAEoCzIaLn'
    'Jlc29uYXRlLmFwaS5SZXNwb25zZUluZm9SDHJlc3BvbnNlSW5mbxI1CgdsaXN0ZW5zGAIgAygL'
    'MhsucmVzb25hdGUuVXNlckxpc3Rlbk1lc3NhZ2VSB2xpc3RlbnMSMQoGY3Vyc29yGAUgASgLMh'
    'kucmVzb25hdGUuYXBpLlF1ZXJ5Q3Vyc29yUgZjdXJzb3I=');

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

@$core.Deprecated('Use addFollowMessageDescriptor instead')
const AddFollowMessage$json = {
  '1': 'AddFollowMessage',
  '2': [
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.AddFollowMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.AddFollowMessage.Response',
      '10': 'response'
    },
  ],
  '3': [AddFollowMessage_Request$json, AddFollowMessage_Response$json],
};

@$core.Deprecated('Use addFollowMessageDescriptor instead')
const AddFollowMessage_Request$json = {
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
      '1': 'follow',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.UserFollowMessage',
      '10': 'follow'
    },
  ],
};

@$core.Deprecated('Use addFollowMessageDescriptor instead')
const AddFollowMessage_Response$json = {
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
      '1': 'follow',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.UserFollowMessage',
      '10': 'follow'
    },
  ],
};

/// Descriptor for `AddFollowMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addFollowMessageDescriptor = $convert.base64Decode(
    'ChBBZGRGb2xsb3dNZXNzYWdlEkAKB3JlcXVlc3QYASABKAsyJi5yZXNvbmF0ZS5hcGkuQWRkRm'
    '9sbG93TWVzc2FnZS5SZXF1ZXN0UgdyZXF1ZXN0EkMKCHJlc3BvbnNlGAIgASgLMicucmVzb25h'
    'dGUuYXBpLkFkZEZvbGxvd01lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGnwKB1JlcXVlc3QSPA'
    'oMcmVxdWVzdF9pbmZvGAEgASgLMhkucmVzb25hdGUuYXBpLlJlcXVlc3RJbmZvUgtyZXF1ZXN0'
    'SW5mbxIzCgZmb2xsb3cYAiABKAsyGy5yZXNvbmF0ZS5Vc2VyRm9sbG93TWVzc2FnZVIGZm9sbG'
    '93GoABCghSZXNwb25zZRI/Cg1yZXNwb25zZV9pbmZvGAEgASgLMhoucmVzb25hdGUuYXBpLlJl'
    'c3BvbnNlSW5mb1IMcmVzcG9uc2VJbmZvEjMKBmZvbGxvdxgCIAEoCzIbLnJlc29uYXRlLlVzZX'
    'JGb2xsb3dNZXNzYWdlUgZmb2xsb3c=');

@$core.Deprecated('Use removeFollowMessageDescriptor instead')
const RemoveFollowMessage$json = {
  '1': 'RemoveFollowMessage',
  '2': [
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RemoveFollowMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RemoveFollowMessage.Response',
      '10': 'response'
    },
  ],
  '3': [RemoveFollowMessage_Request$json, RemoveFollowMessage_Response$json],
};

@$core.Deprecated('Use removeFollowMessageDescriptor instead')
const RemoveFollowMessage_Request$json = {
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
      '1': 'follow',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.UserFollowMessage',
      '10': 'follow'
    },
  ],
};

@$core.Deprecated('Use removeFollowMessageDescriptor instead')
const RemoveFollowMessage_Response$json = {
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
      '1': 'follow',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.UserFollowMessage',
      '10': 'follow'
    },
  ],
};

/// Descriptor for `RemoveFollowMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeFollowMessageDescriptor = $convert.base64Decode(
    'ChNSZW1vdmVGb2xsb3dNZXNzYWdlEkMKB3JlcXVlc3QYASABKAsyKS5yZXNvbmF0ZS5hcGkuUm'
    'Vtb3ZlRm9sbG93TWVzc2FnZS5SZXF1ZXN0UgdyZXF1ZXN0EkYKCHJlc3BvbnNlGAIgASgLMiou'
    'cmVzb25hdGUuYXBpLlJlbW92ZUZvbGxvd01lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGnwKB1'
    'JlcXVlc3QSPAoMcmVxdWVzdF9pbmZvGAEgASgLMhkucmVzb25hdGUuYXBpLlJlcXVlc3RJbmZv'
    'UgtyZXF1ZXN0SW5mbxIzCgZmb2xsb3cYAiABKAsyGy5yZXNvbmF0ZS5Vc2VyRm9sbG93TWVzc2'
    'FnZVIGZm9sbG93GoABCghSZXNwb25zZRI/Cg1yZXNwb25zZV9pbmZvGAEgASgLMhoucmVzb25h'
    'dGUuYXBpLlJlc3BvbnNlSW5mb1IMcmVzcG9uc2VJbmZvEjMKBmZvbGxvdxgCIAEoCzIbLnJlc2'
    '9uYXRlLlVzZXJGb2xsb3dNZXNzYWdlUgZmb2xsb3c=');

@$core.Deprecated('Use listFollowMessageDescriptor instead')
const ListFollowMessage$json = {
  '1': 'ListFollowMessage',
  '2': [
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ListFollowMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ListFollowMessage.Response',
      '10': 'response'
    },
  ],
  '3': [ListFollowMessage_Request$json, ListFollowMessage_Response$json],
};

@$core.Deprecated('Use listFollowMessageDescriptor instead')
const ListFollowMessage_Request$json = {
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
      '1': 'cursor',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.QueryCursor',
      '10': 'cursor'
    },
    {'1': 'include_users', '3': 4, '4': 1, '5': 8, '10': 'includeUsers'},
    {'1': 'is_followed', '3': 5, '4': 1, '5': 8, '10': 'isFollowed'},
  ],
};

@$core.Deprecated('Use listFollowMessageDescriptor instead')
const ListFollowMessage_Response$json = {
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
      '1': 'follows',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.resonate.UserFollowMessage',
      '10': 'follows'
    },
    {
      '1': 'cursor',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.QueryCursor',
      '10': 'cursor'
    },
  ],
};

/// Descriptor for `ListFollowMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listFollowMessageDescriptor = $convert.base64Decode(
    'ChFMaXN0Rm9sbG93TWVzc2FnZRJBCgdyZXF1ZXN0GAEgASgLMicucmVzb25hdGUuYXBpLkxpc3'
    'RGb2xsb3dNZXNzYWdlLlJlcXVlc3RSB3JlcXVlc3QSRAoIcmVzcG9uc2UYAiABKAsyKC5yZXNv'
    'bmF0ZS5hcGkuTGlzdEZvbGxvd01lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGtkBCgdSZXF1ZX'
    'N0EjwKDHJlcXVlc3RfaW5mbxgBIAEoCzIZLnJlc29uYXRlLmFwaS5SZXF1ZXN0SW5mb1ILcmVx'
    'dWVzdEluZm8SFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEjEKBmN1cnNvchgDIAEoCzIZLnJlc2'
    '9uYXRlLmFwaS5RdWVyeUN1cnNvclIGY3Vyc29yEiMKDWluY2x1ZGVfdXNlcnMYBCABKAhSDGlu'
    'Y2x1ZGVVc2VycxIfCgtpc19mb2xsb3dlZBgFIAEoCFIKaXNGb2xsb3dlZBq1AQoIUmVzcG9uc2'
    'USPwoNcmVzcG9uc2VfaW5mbxgBIAEoCzIaLnJlc29uYXRlLmFwaS5SZXNwb25zZUluZm9SDHJl'
    'c3BvbnNlSW5mbxI1Cgdmb2xsb3dzGAIgAygLMhsucmVzb25hdGUuVXNlckZvbGxvd01lc3NhZ2'
    'VSB2ZvbGxvd3MSMQoGY3Vyc29yGAMgASgLMhkucmVzb25hdGUuYXBpLlF1ZXJ5Q3Vyc29yUgZj'
    'dXJzb3I=');

@$core.Deprecated('Use getPublicUserMessageDescriptor instead')
const GetPublicUserMessage$json = {
  '1': 'GetPublicUserMessage',
  '2': [
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.GetPublicUserMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.GetPublicUserMessage.Response',
      '10': 'response'
    },
  ],
  '3': [GetPublicUserMessage_Request$json, GetPublicUserMessage_Response$json],
};

@$core.Deprecated('Use getPublicUserMessageDescriptor instead')
const GetPublicUserMessage_Request$json = {
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

@$core.Deprecated('Use getPublicUserMessageDescriptor instead')
const GetPublicUserMessage_Response$json = {
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
      '6': '.resonate.PublicUserMessage',
      '10': 'user'
    },
  ],
};

/// Descriptor for `GetPublicUserMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPublicUserMessageDescriptor = $convert.base64Decode(
    'ChRHZXRQdWJsaWNVc2VyTWVzc2FnZRJECgdyZXF1ZXN0GAEgASgLMioucmVzb25hdGUuYXBpLk'
    'dldFB1YmxpY1VzZXJNZXNzYWdlLlJlcXVlc3RSB3JlcXVlc3QSRwoIcmVzcG9uc2UYAiABKAsy'
    'Ky5yZXNvbmF0ZS5hcGkuR2V0UHVibGljVXNlck1lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGm'
    'AKB1JlcXVlc3QSPAoMcmVxdWVzdF9pbmZvGAEgASgLMhkucmVzb25hdGUuYXBpLlJlcXVlc3RJ'
    'bmZvUgtyZXF1ZXN0SW5mbxIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQafAoIUmVzcG9uc2USPw'
    'oNcmVzcG9uc2VfaW5mbxgBIAEoCzIaLnJlc29uYXRlLmFwaS5SZXNwb25zZUluZm9SDHJlc3Bv'
    'bnNlSW5mbxIvCgR1c2VyGAIgASgLMhsucmVzb25hdGUuUHVibGljVXNlck1lc3NhZ2VSBHVzZX'
    'I=');

@$core.Deprecated('Use editUserMessageDescriptor instead')
const EditUserMessage$json = {
  '1': 'EditUserMessage',
  '2': [
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.EditUserMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.EditUserMessage.Response',
      '10': 'response'
    },
  ],
  '3': [EditUserMessage_Request$json, EditUserMessage_Response$json],
};

@$core.Deprecated('Use editUserMessageDescriptor instead')
const EditUserMessage_Request$json = {
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

@$core.Deprecated('Use editUserMessageDescriptor instead')
const EditUserMessage_Response$json = {
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

/// Descriptor for `EditUserMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List editUserMessageDescriptor = $convert.base64Decode(
    'Cg9FZGl0VXNlck1lc3NhZ2USPwoHcmVxdWVzdBgBIAEoCzIlLnJlc29uYXRlLmFwaS5FZGl0VX'
    'Nlck1lc3NhZ2UuUmVxdWVzdFIHcmVxdWVzdBJCCghyZXNwb25zZRgCIAEoCzImLnJlc29uYXRl'
    'LmFwaS5FZGl0VXNlck1lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGnIKB1JlcXVlc3QSPAoMcm'
    'VxdWVzdF9pbmZvGAEgASgLMhkucmVzb25hdGUuYXBpLlJlcXVlc3RJbmZvUgtyZXF1ZXN0SW5m'
    'bxIpCgR1c2VyGAIgASgLMhUucmVzb25hdGUuVXNlck1lc3NhZ2VSBHVzZXIadgoIUmVzcG9uc2'
    'USPwoNcmVzcG9uc2VfaW5mbxgBIAEoCzIaLnJlc29uYXRlLmFwaS5SZXNwb25zZUluZm9SDHJl'
    'c3BvbnNlSW5mbxIpCgR1c2VyGAIgASgLMhUucmVzb25hdGUuVXNlck1lc3NhZ2VSBHVzZXI=');

@$core.Deprecated('Use removeUserMessageDescriptor instead')
const RemoveUserMessage$json = {
  '1': 'RemoveUserMessage',
  '2': [
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RemoveUserMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RemoveUserMessage.Response',
      '10': 'response'
    },
  ],
  '3': [RemoveUserMessage_Request$json, RemoveUserMessage_Response$json],
};

@$core.Deprecated('Use removeUserMessageDescriptor instead')
const RemoveUserMessage_Request$json = {
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

@$core.Deprecated('Use removeUserMessageDescriptor instead')
const RemoveUserMessage_Response$json = {
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

/// Descriptor for `RemoveUserMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeUserMessageDescriptor = $convert.base64Decode(
    'ChFSZW1vdmVVc2VyTWVzc2FnZRJBCgdyZXF1ZXN0GAEgASgLMicucmVzb25hdGUuYXBpLlJlbW'
    '92ZVVzZXJNZXNzYWdlLlJlcXVlc3RSB3JlcXVlc3QSRAoIcmVzcG9uc2UYAiABKAsyKC5yZXNv'
    'bmF0ZS5hcGkuUmVtb3ZlVXNlck1lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGmAKB1JlcXVlc3'
    'QSPAoMcmVxdWVzdF9pbmZvGAEgASgLMhkucmVzb25hdGUuYXBpLlJlcXVlc3RJbmZvUgtyZXF1'
    'ZXN0SW5mbxIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQaSwoIUmVzcG9uc2USPwoNcmVzcG9uc2'
    'VfaW5mbxgBIAEoCzIaLnJlc29uYXRlLmFwaS5SZXNwb25zZUluZm9SDHJlc3BvbnNlSW5mbw==');

@$core.Deprecated('Use listUserMessageDescriptor instead')
const ListUserMessage$json = {
  '1': 'ListUserMessage',
  '2': [
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ListUserMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ListUserMessage.Response',
      '10': 'response'
    },
  ],
  '3': [ListUserMessage_Request$json, ListUserMessage_Response$json],
};

@$core.Deprecated('Use listUserMessageDescriptor instead')
const ListUserMessage_Request$json = {
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
    {'1': 'user_ids', '3': 2, '4': 3, '5': 9, '10': 'userIds'},
  ],
};

@$core.Deprecated('Use listUserMessageDescriptor instead')
const ListUserMessage_Response$json = {
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
      '1': 'users',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.resonate.PublicUserMessage',
      '10': 'users'
    },
  ],
};

/// Descriptor for `ListUserMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUserMessageDescriptor = $convert.base64Decode(
    'Cg9MaXN0VXNlck1lc3NhZ2USPwoHcmVxdWVzdBgBIAEoCzIlLnJlc29uYXRlLmFwaS5MaXN0VX'
    'Nlck1lc3NhZ2UuUmVxdWVzdFIHcmVxdWVzdBJCCghyZXNwb25zZRgCIAEoCzImLnJlc29uYXRl'
    'LmFwaS5MaXN0VXNlck1lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGmIKB1JlcXVlc3QSPAoMcm'
    'VxdWVzdF9pbmZvGAEgASgLMhkucmVzb25hdGUuYXBpLlJlcXVlc3RJbmZvUgtyZXF1ZXN0SW5m'
    'bxIZCgh1c2VyX2lkcxgCIAMoCVIHdXNlcklkcxp+CghSZXNwb25zZRI/Cg1yZXNwb25zZV9pbm'
    'ZvGAEgASgLMhoucmVzb25hdGUuYXBpLlJlc3BvbnNlSW5mb1IMcmVzcG9uc2VJbmZvEjEKBXVz'
    'ZXJzGAIgAygLMhsucmVzb25hdGUuUHVibGljVXNlck1lc3NhZ2VSBXVzZXJz');

@$core.Deprecated('Use uploadImageMessageDescriptor instead')
const UploadImageMessage$json = {
  '1': 'UploadImageMessage',
  '2': [
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.UploadImageMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.UploadImageMessage.Response',
      '10': 'response'
    },
  ],
  '3': [UploadImageMessage_Request$json, UploadImageMessage_Response$json],
};

@$core.Deprecated('Use uploadImageMessageDescriptor instead')
const UploadImageMessage_Request$json = {
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
    {'1': 'image_bytes', '3': 2, '4': 1, '5': 12, '10': 'imageBytes'},
  ],
};

@$core.Deprecated('Use uploadImageMessageDescriptor instead')
const UploadImageMessage_Response$json = {
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
    {'1': 'image_url', '3': 2, '4': 1, '5': 9, '10': 'imageUrl'},
  ],
};

/// Descriptor for `UploadImageMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadImageMessageDescriptor = $convert.base64Decode(
    'ChJVcGxvYWRJbWFnZU1lc3NhZ2USQgoHcmVxdWVzdBgBIAEoCzIoLnJlc29uYXRlLmFwaS5VcG'
    'xvYWRJbWFnZU1lc3NhZ2UuUmVxdWVzdFIHcmVxdWVzdBJFCghyZXNwb25zZRgCIAEoCzIpLnJl'
    'c29uYXRlLmFwaS5VcGxvYWRJbWFnZU1lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGmgKB1JlcX'
    'Vlc3QSPAoMcmVxdWVzdF9pbmZvGAEgASgLMhkucmVzb25hdGUuYXBpLlJlcXVlc3RJbmZvUgty'
    'ZXF1ZXN0SW5mbxIfCgtpbWFnZV9ieXRlcxgCIAEoDFIKaW1hZ2VCeXRlcxpoCghSZXNwb25zZR'
    'I/Cg1yZXNwb25zZV9pbmZvGAEgASgLMhoucmVzb25hdGUuYXBpLlJlc3BvbnNlSW5mb1IMcmVz'
    'cG9uc2VJbmZvEhsKCWltYWdlX3VybBgCIAEoCVIIaW1hZ2VVcmw=');

@$core.Deprecated('Use findContactsMessageDescriptor instead')
const FindContactsMessage$json = {
  '1': 'FindContactsMessage',
  '2': [
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.FindContactsMessage.Request',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.FindContactsMessage.Response',
      '10': 'response'
    },
  ],
  '3': [FindContactsMessage_Request$json, FindContactsMessage_Response$json],
};

@$core.Deprecated('Use findContactsMessageDescriptor instead')
const FindContactsMessage_Request$json = {
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
    {'1': 'phone_numbers', '3': 2, '4': 3, '5': 9, '10': 'phoneNumbers'},
    {
      '1': 'cursor',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.QueryCursor',
      '10': 'cursor'
    },
  ],
};

@$core.Deprecated('Use findContactsMessageDescriptor instead')
const FindContactsMessage_Response$json = {
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
      '1': 'users',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.resonate.PublicUserMessage',
      '10': 'users'
    },
    {
      '1': 'cursor',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.QueryCursor',
      '10': 'cursor'
    },
  ],
};

/// Descriptor for `FindContactsMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List findContactsMessageDescriptor = $convert.base64Decode(
    'ChNGaW5kQ29udGFjdHNNZXNzYWdlEkMKB3JlcXVlc3QYASABKAsyKS5yZXNvbmF0ZS5hcGkuRm'
    'luZENvbnRhY3RzTWVzc2FnZS5SZXF1ZXN0UgdyZXF1ZXN0EkYKCHJlc3BvbnNlGAIgASgLMiou'
    'cmVzb25hdGUuYXBpLkZpbmRDb250YWN0c01lc3NhZ2UuUmVzcG9uc2VSCHJlc3BvbnNlGp8BCg'
    'dSZXF1ZXN0EjwKDHJlcXVlc3RfaW5mbxgBIAEoCzIZLnJlc29uYXRlLmFwaS5SZXF1ZXN0SW5m'
    'b1ILcmVxdWVzdEluZm8SIwoNcGhvbmVfbnVtYmVycxgCIAMoCVIMcGhvbmVOdW1iZXJzEjEKBm'
    'N1cnNvchgDIAEoCzIZLnJlc29uYXRlLmFwaS5RdWVyeUN1cnNvclIGY3Vyc29yGrEBCghSZXNw'
    'b25zZRI/Cg1yZXNwb25zZV9pbmZvGAEgASgLMhoucmVzb25hdGUuYXBpLlJlc3BvbnNlSW5mb1'
    'IMcmVzcG9uc2VJbmZvEjEKBXVzZXJzGAIgAygLMhsucmVzb25hdGUuUHVibGljVXNlck1lc3Nh'
    'Z2VSBXVzZXJzEjEKBmN1cnNvchgDIAEoCzIZLnJlc29uYXRlLmFwaS5RdWVyeUN1cnNvclIGY3'
    'Vyc29y');

@$core.Deprecated('Use searchContactsMessageDescriptor instead')
const SearchContactsMessage$json = {
  '1': 'SearchContactsMessage',
  '3': [
    SearchContactsMessage_Request$json,
    SearchContactsMessage_Response$json
  ],
};

@$core.Deprecated('Use searchContactsMessageDescriptor instead')
const SearchContactsMessage_Request$json = {
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
      '1': 'cursor',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.QueryCursor',
      '10': 'cursor'
    },
    {'1': 'query', '3': 3, '4': 1, '5': 9, '10': 'query'},
  ],
};

@$core.Deprecated('Use searchContactsMessageDescriptor instead')
const SearchContactsMessage_Response$json = {
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
      '1': 'users',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.resonate.PublicUserMessage',
      '10': 'users'
    },
    {
      '1': 'cursor',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.QueryCursor',
      '10': 'cursor'
    },
  ],
};

/// Descriptor for `SearchContactsMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchContactsMessageDescriptor = $convert.base64Decode(
    'ChVTZWFyY2hDb250YWN0c01lc3NhZ2UakAEKB1JlcXVlc3QSPAoMcmVxdWVzdF9pbmZvGAEgAS'
    'gLMhkucmVzb25hdGUuYXBpLlJlcXVlc3RJbmZvUgtyZXF1ZXN0SW5mbxIxCgZjdXJzb3IYAiAB'
    'KAsyGS5yZXNvbmF0ZS5hcGkuUXVlcnlDdXJzb3JSBmN1cnNvchIUCgVxdWVyeRgDIAEoCVIFcX'
    'VlcnkasQEKCFJlc3BvbnNlEj8KDXJlc3BvbnNlX2luZm8YASABKAsyGi5yZXNvbmF0ZS5hcGku'
    'UmVzcG9uc2VJbmZvUgxyZXNwb25zZUluZm8SMQoFdXNlcnMYAiADKAsyGy5yZXNvbmF0ZS5QdW'
    'JsaWNVc2VyTWVzc2FnZVIFdXNlcnMSMQoGY3Vyc29yGAMgASgLMhkucmVzb25hdGUuYXBpLlF1'
    'ZXJ5Q3Vyc29yUgZjdXJzb3I=');

@$core.Deprecated('Use searchTopContactsMessageDescriptor instead')
const SearchTopContactsMessage$json = {
  '1': 'SearchTopContactsMessage',
  '3': [
    SearchTopContactsMessage_Request$json,
    SearchTopContactsMessage_Response$json
  ],
};

@$core.Deprecated('Use searchTopContactsMessageDescriptor instead')
const SearchTopContactsMessage_Request$json = {
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
      '1': 'contacts',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.resonate.UserContactMessage',
      '10': 'contacts'
    },
  ],
};

@$core.Deprecated('Use searchTopContactsMessageDescriptor instead')
const SearchTopContactsMessage_Response$json = {
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
      '1': 'users',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.resonate.PublicUserMessage',
      '10': 'users'
    },
  ],
};

/// Descriptor for `SearchTopContactsMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchTopContactsMessageDescriptor = $convert.base64Decode(
    'ChhTZWFyY2hUb3BDb250YWN0c01lc3NhZ2UagQEKB1JlcXVlc3QSPAoMcmVxdWVzdF9pbmZvGA'
    'EgASgLMhkucmVzb25hdGUuYXBpLlJlcXVlc3RJbmZvUgtyZXF1ZXN0SW5mbxI4Cghjb250YWN0'
    'cxgCIAMoCzIcLnJlc29uYXRlLlVzZXJDb250YWN0TWVzc2FnZVIIY29udGFjdHMafgoIUmVzcG'
    '9uc2USPwoNcmVzcG9uc2VfaW5mbxgBIAEoCzIaLnJlc29uYXRlLmFwaS5SZXNwb25zZUluZm9S'
    'DHJlc3BvbnNlSW5mbxIxCgV1c2VycxgCIAMoCzIbLnJlc29uYXRlLlB1YmxpY1VzZXJNZXNzYW'
    'dlUgV1c2Vycw==');
