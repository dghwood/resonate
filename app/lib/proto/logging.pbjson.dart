// This is a generated file - do not edit.
//
// Generated from proto/logging.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use apiEventMessageDescriptor instead')
const ApiEventMessage$json = {
  '1': 'ApiEventMessage',
  '2': [
    {'1': 'timestamp_usec', '3': 1, '4': 1, '5': 3, '10': 'timestampUsec'},
    {'1': 'instance_id', '3': 8, '4': 1, '5': 9, '10': 'instanceId'},
    {'1': 'binary_version', '3': 9, '4': 1, '5': 9, '10': 'binaryVersion'},
    {'1': 'api_path', '3': 2, '4': 1, '5': 9, '10': 'apiPath'},
    {
      '1': 'request_info',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.RequestInfo',
      '10': 'requestInfo'
    },
    {
      '1': 'response_info',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.resonate.api.ResponseInfo',
      '10': 'responseInfo'
    },
    {'1': 'trace_id', '3': 5, '4': 1, '5': 9, '10': 'traceId'},
    {'1': 'ips', '3': 6, '4': 1, '5': 9, '10': 'ips'},
    {
      '1': 'response_timestamp_usec',
      '3': 7,
      '4': 1,
      '5': 3,
      '10': 'responseTimestampUsec'
    },
  ],
};

/// Descriptor for `ApiEventMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List apiEventMessageDescriptor = $convert.base64Decode(
    'Cg9BcGlFdmVudE1lc3NhZ2USJQoOdGltZXN0YW1wX3VzZWMYASABKANSDXRpbWVzdGFtcFVzZW'
    'MSHwoLaW5zdGFuY2VfaWQYCCABKAlSCmluc3RhbmNlSWQSJQoOYmluYXJ5X3ZlcnNpb24YCSAB'
    'KAlSDWJpbmFyeVZlcnNpb24SGQoIYXBpX3BhdGgYAiABKAlSB2FwaVBhdGgSPAoMcmVxdWVzdF'
    '9pbmZvGAMgASgLMhkucmVzb25hdGUuYXBpLlJlcXVlc3RJbmZvUgtyZXF1ZXN0SW5mbxI/Cg1y'
    'ZXNwb25zZV9pbmZvGAQgASgLMhoucmVzb25hdGUuYXBpLlJlc3BvbnNlSW5mb1IMcmVzcG9uc2'
    'VJbmZvEhkKCHRyYWNlX2lkGAUgASgJUgd0cmFjZUlkEhAKA2lwcxgGIAEoCVIDaXBzEjYKF3Jl'
    'c3BvbnNlX3RpbWVzdGFtcF91c2VjGAcgASgDUhVyZXNwb25zZVRpbWVzdGFtcFVzZWM=');
