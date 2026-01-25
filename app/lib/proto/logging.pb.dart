// This is a generated file - do not edit.
//
// Generated from proto/logging.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'api.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Next Tag: 9
class ApiEventMessage extends $pb.GeneratedMessage {
  factory ApiEventMessage({
    $fixnum.Int64? timestampUsec,
    $core.String? apiPath,
    $0.RequestInfo? requestInfo,
    $0.ResponseInfo? responseInfo,
    $core.String? traceId,
    $core.String? ips,
    $fixnum.Int64? responseTimestampUsec,
    $core.String? instanceId,
    $core.String? binaryVersion,
  }) {
    final result = create();
    if (timestampUsec != null) result.timestampUsec = timestampUsec;
    if (apiPath != null) result.apiPath = apiPath;
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (traceId != null) result.traceId = traceId;
    if (ips != null) result.ips = ips;
    if (responseTimestampUsec != null)
      result.responseTimestampUsec = responseTimestampUsec;
    if (instanceId != null) result.instanceId = instanceId;
    if (binaryVersion != null) result.binaryVersion = binaryVersion;
    return result;
  }

  ApiEventMessage._();

  factory ApiEventMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ApiEventMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ApiEventMessage',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'resonate.logging'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'timestampUsec')
    ..aOS(2, _omitFieldNames ? '' : 'apiPath')
    ..aOM<$0.RequestInfo>(3, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: $0.RequestInfo.create)
    ..aOM<$0.ResponseInfo>(4, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: $0.ResponseInfo.create)
    ..aOS(5, _omitFieldNames ? '' : 'traceId')
    ..aOS(6, _omitFieldNames ? '' : 'ips')
    ..aInt64(7, _omitFieldNames ? '' : 'responseTimestampUsec')
    ..aOS(8, _omitFieldNames ? '' : 'instanceId')
    ..aOS(9, _omitFieldNames ? '' : 'binaryVersion')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ApiEventMessage clone() => ApiEventMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ApiEventMessage copyWith(void Function(ApiEventMessage) updates) =>
      super.copyWith((message) => updates(message as ApiEventMessage))
          as ApiEventMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ApiEventMessage create() => ApiEventMessage._();
  @$core.override
  ApiEventMessage createEmptyInstance() => create();
  static $pb.PbList<ApiEventMessage> createRepeated() =>
      $pb.PbList<ApiEventMessage>();
  @$core.pragma('dart2js:noInline')
  static ApiEventMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ApiEventMessage>(create);
  static ApiEventMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get timestampUsec => $_getI64(0);
  @$pb.TagNumber(1)
  set timestampUsec($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTimestampUsec() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestampUsec() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get apiPath => $_getSZ(1);
  @$pb.TagNumber(2)
  set apiPath($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasApiPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearApiPath() => $_clearField(2);

  @$pb.TagNumber(3)
  $0.RequestInfo get requestInfo => $_getN(2);
  @$pb.TagNumber(3)
  set requestInfo($0.RequestInfo value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRequestInfo() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequestInfo() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.RequestInfo ensureRequestInfo() => $_ensure(2);

  @$pb.TagNumber(4)
  $0.ResponseInfo get responseInfo => $_getN(3);
  @$pb.TagNumber(4)
  set responseInfo($0.ResponseInfo value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasResponseInfo() => $_has(3);
  @$pb.TagNumber(4)
  void clearResponseInfo() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.ResponseInfo ensureResponseInfo() => $_ensure(3);

  /// X-Cloud-Trace-Context header
  @$pb.TagNumber(5)
  $core.String get traceId => $_getSZ(4);
  @$pb.TagNumber(5)
  set traceId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTraceId() => $_has(4);
  @$pb.TagNumber(5)
  void clearTraceId() => $_clearField(5);

  /// X-Forwarded-For
  @$pb.TagNumber(6)
  $core.String get ips => $_getSZ(5);
  @$pb.TagNumber(6)
  set ips($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIps() => $_has(5);
  @$pb.TagNumber(6)
  void clearIps() => $_clearField(6);

  /// When the response was written
  @$pb.TagNumber(7)
  $fixnum.Int64 get responseTimestampUsec => $_getI64(6);
  @$pb.TagNumber(7)
  set responseTimestampUsec($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasResponseTimestampUsec() => $_has(6);
  @$pb.TagNumber(7)
  void clearResponseTimestampUsec() => $_clearField(7);

  /// Get this from "cloud.google.com/go/compute/metadata" on startup
  @$pb.TagNumber(8)
  $core.String get instanceId => $_getSZ(7);
  @$pb.TagNumber(8)
  set instanceId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasInstanceId() => $_has(7);
  @$pb.TagNumber(8)
  void clearInstanceId() => $_clearField(8);

  /// Need to add a binary version for the SERVER
  @$pb.TagNumber(9)
  $core.String get binaryVersion => $_getSZ(8);
  @$pb.TagNumber(9)
  set binaryVersion($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasBinaryVersion() => $_has(8);
  @$pb.TagNumber(9)
  void clearBinaryVersion() => $_clearField(9);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
