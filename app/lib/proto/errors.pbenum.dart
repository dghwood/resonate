// This is a generated file - do not edit.
//
// Generated from proto/errors.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ErrorEnum extends $pb.ProtobufEnum {
  static const ErrorEnum ERROR_UNKNOWN =
      ErrorEnum._(0, _omitEnumNames ? '' : 'ERROR_UNKNOWN');
  static const ErrorEnum ERROR_INTERNAL =
      ErrorEnum._(1, _omitEnumNames ? '' : 'ERROR_INTERNAL');
  static const ErrorEnum ERROR_PERMISSION_DENIED =
      ErrorEnum._(2, _omitEnumNames ? '' : 'ERROR_PERMISSION_DENIED');

  static const $core.List<ErrorEnum> values = <ErrorEnum>[
    ERROR_UNKNOWN,
    ERROR_INTERNAL,
    ERROR_PERMISSION_DENIED,
  ];

  static final $core.List<ErrorEnum?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static ErrorEnum? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ErrorEnum._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
