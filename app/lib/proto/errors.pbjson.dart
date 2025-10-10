// This is a generated file - do not edit.
//
// Generated from proto/errors.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use errorEnumDescriptor instead')
const ErrorEnum$json = {
  '1': 'ErrorEnum',
  '2': [
    {'1': 'ERROR_UNKNOWN', '2': 0},
    {'1': 'ERROR_INTERNAL', '2': 1},
    {'1': 'ERROR_PERMISSION_DENIED', '2': 2},
    {'1': 'ERROR_INVALID_CREDENTIALS', '2': 3},
    {'1': 'ERROR_TOO_MANY_ATTEMPTS', '2': 4},
    {'1': 'ERROR_TIME_EXPIRED', '2': 5},
    {'1': 'ERROR_UPLOAD_SIZE_EXCEEDED', '2': 6},
  ],
};

/// Descriptor for `ErrorEnum`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List errorEnumDescriptor = $convert.base64Decode(
    'CglFcnJvckVudW0SEQoNRVJST1JfVU5LTk9XThAAEhIKDkVSUk9SX0lOVEVSTkFMEAESGwoXRV'
    'JST1JfUEVSTUlTU0lPTl9ERU5JRUQQAhIdChlFUlJPUl9JTlZBTElEX0NSRURFTlRJQUxTEAMS'
    'GwoXRVJST1JfVE9PX01BTllfQVRURU1QVFMQBBIWChJFUlJPUl9USU1FX0VYUElSRUQQBRIeCh'
    'pFUlJPUl9VUExPQURfU0laRV9FWENFRURFRBAG');
