// This is a generated file - do not edit.
//
// Generated from proto/api.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $0;
import 'errors.pbenum.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class InternalInfo extends $pb.GeneratedMessage {
  factory InternalInfo({
    $0.TokenMessage? accessToken,
    $0.TokenMessage? refreshToken,
  }) {
    final result = create();
    if (accessToken != null) result.accessToken = accessToken;
    if (refreshToken != null) result.refreshToken = refreshToken;
    return result;
  }

  InternalInfo._();

  factory InternalInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InternalInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InternalInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<$0.TokenMessage>(1, _omitFieldNames ? '' : 'accessToken',
        subBuilder: $0.TokenMessage.create)
    ..aOM<$0.TokenMessage>(2, _omitFieldNames ? '' : 'refreshToken',
        subBuilder: $0.TokenMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InternalInfo clone() => InternalInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InternalInfo copyWith(void Function(InternalInfo) updates) =>
      super.copyWith((message) => updates(message as InternalInfo))
          as InternalInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InternalInfo create() => InternalInfo._();
  @$core.override
  InternalInfo createEmptyInstance() => create();
  static $pb.PbList<InternalInfo> createRepeated() =>
      $pb.PbList<InternalInfo>();
  @$core.pragma('dart2js:noInline')
  static InternalInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InternalInfo>(create);
  static InternalInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $0.TokenMessage get accessToken => $_getN(0);
  @$pb.TagNumber(1)
  set accessToken($0.TokenMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAccessToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccessToken() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.TokenMessage ensureAccessToken() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.TokenMessage get refreshToken => $_getN(1);
  @$pb.TagNumber(2)
  set refreshToken($0.TokenMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasRefreshToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRefreshToken() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.TokenMessage ensureRefreshToken() => $_ensure(1);
}

class ResponseInfo extends $pb.GeneratedMessage {
  factory ResponseInfo({
    $core.bool? success,
    $core.String? errorMessage,
    $1.ErrorEnum? error,
    InternalInfo? internalInfo,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (error != null) result.error = error;
    if (internalInfo != null) result.internalInfo = internalInfo;
    return result;
  }

  ResponseInfo._();

  factory ResponseInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ResponseInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResponseInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorMessage')
    ..e<$1.ErrorEnum>(3, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE,
        defaultOrMaker: $1.ErrorEnum.ERROR_UNKNOWN,
        valueOf: $1.ErrorEnum.valueOf,
        enumValues: $1.ErrorEnum.values)
    ..aOM<InternalInfo>(4, _omitFieldNames ? '' : 'internalInfo',
        subBuilder: InternalInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResponseInfo clone() => ResponseInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResponseInfo copyWith(void Function(ResponseInfo) updates) =>
      super.copyWith((message) => updates(message as ResponseInfo))
          as ResponseInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResponseInfo create() => ResponseInfo._();
  @$core.override
  ResponseInfo createEmptyInstance() => create();
  static $pb.PbList<ResponseInfo> createRepeated() =>
      $pb.PbList<ResponseInfo>();
  @$core.pragma('dart2js:noInline')
  static ResponseInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResponseInfo>(create);
  static ResponseInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorMessage => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorMessage($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.ErrorEnum get error => $_getN(2);
  @$pb.TagNumber(3)
  set error($1.ErrorEnum value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => $_clearField(3);

  @$pb.TagNumber(4)
  InternalInfo get internalInfo => $_getN(3);
  @$pb.TagNumber(4)
  set internalInfo(InternalInfo value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasInternalInfo() => $_has(3);
  @$pb.TagNumber(4)
  void clearInternalInfo() => $_clearField(4);
  @$pb.TagNumber(4)
  InternalInfo ensureInternalInfo() => $_ensure(3);
}

class RequestInfo extends $pb.GeneratedMessage {
  factory RequestInfo({
    $core.String? userId,
    InternalInfo? internalInfo,
    $core.String? clientVersion,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (internalInfo != null) result.internalInfo = internalInfo;
    if (clientVersion != null) result.clientVersion = clientVersion;
    return result;
  }

  RequestInfo._();

  factory RequestInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOM<InternalInfo>(2, _omitFieldNames ? '' : 'internalInfo',
        subBuilder: InternalInfo.create)
    ..aOS(3, _omitFieldNames ? '' : 'clientVersion')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestInfo clone() => RequestInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestInfo copyWith(void Function(RequestInfo) updates) =>
      super.copyWith((message) => updates(message as RequestInfo))
          as RequestInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestInfo create() => RequestInfo._();
  @$core.override
  RequestInfo createEmptyInstance() => create();
  static $pb.PbList<RequestInfo> createRepeated() => $pb.PbList<RequestInfo>();
  @$core.pragma('dart2js:noInline')
  static RequestInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestInfo>(create);
  static RequestInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  InternalInfo get internalInfo => $_getN(1);
  @$pb.TagNumber(2)
  set internalInfo(InternalInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasInternalInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearInternalInfo() => $_clearField(2);
  @$pb.TagNumber(2)
  InternalInfo ensureInternalInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get clientVersion => $_getSZ(2);
  @$pb.TagNumber(3)
  set clientVersion($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasClientVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearClientVersion() => $_clearField(3);
}

class RefreshAuthMessage_Request extends $pb.GeneratedMessage {
  factory RefreshAuthMessage_Request({
    RequestInfo? requestInfo,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    return result;
  }

  RefreshAuthMessage_Request._();

  factory RefreshAuthMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RefreshAuthMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RefreshAuthMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshAuthMessage_Request clone() =>
      RefreshAuthMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshAuthMessage_Request copyWith(
          void Function(RefreshAuthMessage_Request) updates) =>
      super.copyWith(
              (message) => updates(message as RefreshAuthMessage_Request))
          as RefreshAuthMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RefreshAuthMessage_Request create() => RefreshAuthMessage_Request._();
  @$core.override
  RefreshAuthMessage_Request createEmptyInstance() => create();
  static $pb.PbList<RefreshAuthMessage_Request> createRepeated() =>
      $pb.PbList<RefreshAuthMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static RefreshAuthMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RefreshAuthMessage_Request>(create);
  static RefreshAuthMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);
}

class RefreshAuthMessage_Response extends $pb.GeneratedMessage {
  factory RefreshAuthMessage_Response({
    ResponseInfo? responseInfo,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    return result;
  }

  RefreshAuthMessage_Response._();

  factory RefreshAuthMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RefreshAuthMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RefreshAuthMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshAuthMessage_Response clone() =>
      RefreshAuthMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshAuthMessage_Response copyWith(
          void Function(RefreshAuthMessage_Response) updates) =>
      super.copyWith(
              (message) => updates(message as RefreshAuthMessage_Response))
          as RefreshAuthMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RefreshAuthMessage_Response create() =>
      RefreshAuthMessage_Response._();
  @$core.override
  RefreshAuthMessage_Response createEmptyInstance() => create();
  static $pb.PbList<RefreshAuthMessage_Response> createRepeated() =>
      $pb.PbList<RefreshAuthMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static RefreshAuthMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RefreshAuthMessage_Response>(create);
  static RefreshAuthMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);
}

/// Used to refresh access tokens
class RefreshAuthMessage extends $pb.GeneratedMessage {
  factory RefreshAuthMessage({
    RefreshAuthMessage_Request? request,
    RefreshAuthMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  RefreshAuthMessage._();

  factory RefreshAuthMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RefreshAuthMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RefreshAuthMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RefreshAuthMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: RefreshAuthMessage_Request.create)
    ..aOM<RefreshAuthMessage_Response>(2, _omitFieldNames ? '' : 'response',
        subBuilder: RefreshAuthMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshAuthMessage clone() => RefreshAuthMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshAuthMessage copyWith(void Function(RefreshAuthMessage) updates) =>
      super.copyWith((message) => updates(message as RefreshAuthMessage))
          as RefreshAuthMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RefreshAuthMessage create() => RefreshAuthMessage._();
  @$core.override
  RefreshAuthMessage createEmptyInstance() => create();
  static $pb.PbList<RefreshAuthMessage> createRepeated() =>
      $pb.PbList<RefreshAuthMessage>();
  @$core.pragma('dart2js:noInline')
  static RefreshAuthMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RefreshAuthMessage>(create);
  static RefreshAuthMessage? _defaultInstance;

  @$pb.TagNumber(1)
  RefreshAuthMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(RefreshAuthMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  RefreshAuthMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  RefreshAuthMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(RefreshAuthMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  RefreshAuthMessage_Response ensureResponse() => $_ensure(1);
}

class LoginRequestMessage_Request extends $pb.GeneratedMessage {
  factory LoginRequestMessage_Request({
    RequestInfo? requestInfo,
    $core.String? email,
    $core.String? phoneNumber,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (email != null) result.email = email;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    return result;
  }

  LoginRequestMessage_Request._();

  factory LoginRequestMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LoginRequestMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LoginRequestMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOS(3, _omitFieldNames ? '' : 'phoneNumber')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginRequestMessage_Request clone() =>
      LoginRequestMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginRequestMessage_Request copyWith(
          void Function(LoginRequestMessage_Request) updates) =>
      super.copyWith(
              (message) => updates(message as LoginRequestMessage_Request))
          as LoginRequestMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoginRequestMessage_Request create() =>
      LoginRequestMessage_Request._();
  @$core.override
  LoginRequestMessage_Request createEmptyInstance() => create();
  static $pb.PbList<LoginRequestMessage_Request> createRepeated() =>
      $pb.PbList<LoginRequestMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static LoginRequestMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LoginRequestMessage_Request>(create);
  static LoginRequestMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get phoneNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set phoneNumber($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPhoneNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearPhoneNumber() => $_clearField(3);
}

class LoginRequestMessage_Response extends $pb.GeneratedMessage {
  factory LoginRequestMessage_Response({
    ResponseInfo? responseInfo,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    return result;
  }

  LoginRequestMessage_Response._();

  factory LoginRequestMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LoginRequestMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LoginRequestMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginRequestMessage_Response clone() =>
      LoginRequestMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginRequestMessage_Response copyWith(
          void Function(LoginRequestMessage_Response) updates) =>
      super.copyWith(
              (message) => updates(message as LoginRequestMessage_Response))
          as LoginRequestMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoginRequestMessage_Response create() =>
      LoginRequestMessage_Response._();
  @$core.override
  LoginRequestMessage_Response createEmptyInstance() => create();
  static $pb.PbList<LoginRequestMessage_Response> createRepeated() =>
      $pb.PbList<LoginRequestMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static LoginRequestMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LoginRequestMessage_Response>(create);
  static LoginRequestMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);
}

/// Used to request login password
class LoginRequestMessage extends $pb.GeneratedMessage {
  factory LoginRequestMessage({
    LoginRequestMessage_Request? request,
    LoginRequestMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  LoginRequestMessage._();

  factory LoginRequestMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LoginRequestMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LoginRequestMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<LoginRequestMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: LoginRequestMessage_Request.create)
    ..aOM<LoginRequestMessage_Response>(2, _omitFieldNames ? '' : 'response',
        subBuilder: LoginRequestMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginRequestMessage clone() => LoginRequestMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginRequestMessage copyWith(void Function(LoginRequestMessage) updates) =>
      super.copyWith((message) => updates(message as LoginRequestMessage))
          as LoginRequestMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoginRequestMessage create() => LoginRequestMessage._();
  @$core.override
  LoginRequestMessage createEmptyInstance() => create();
  static $pb.PbList<LoginRequestMessage> createRepeated() =>
      $pb.PbList<LoginRequestMessage>();
  @$core.pragma('dart2js:noInline')
  static LoginRequestMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LoginRequestMessage>(create);
  static LoginRequestMessage? _defaultInstance;

  @$pb.TagNumber(1)
  LoginRequestMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(LoginRequestMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  LoginRequestMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  LoginRequestMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(LoginRequestMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  LoginRequestMessage_Response ensureResponse() => $_ensure(1);
}

class LoginUserMessage_Request extends $pb.GeneratedMessage {
  factory LoginUserMessage_Request({
    RequestInfo? requestInfo,
    $core.String? email,
    $core.String? password,
    $core.String? phoneNumber,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (email != null) result.email = email;
    if (password != null) result.password = password;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    return result;
  }

  LoginUserMessage_Request._();

  factory LoginUserMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LoginUserMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LoginUserMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOS(3, _omitFieldNames ? '' : 'password')
    ..aOS(4, _omitFieldNames ? '' : 'phoneNumber')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginUserMessage_Request clone() =>
      LoginUserMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginUserMessage_Request copyWith(
          void Function(LoginUserMessage_Request) updates) =>
      super.copyWith((message) => updates(message as LoginUserMessage_Request))
          as LoginUserMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoginUserMessage_Request create() => LoginUserMessage_Request._();
  @$core.override
  LoginUserMessage_Request createEmptyInstance() => create();
  static $pb.PbList<LoginUserMessage_Request> createRepeated() =>
      $pb.PbList<LoginUserMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static LoginUserMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LoginUserMessage_Request>(create);
  static LoginUserMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get password => $_getSZ(2);
  @$pb.TagNumber(3)
  set password($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPassword() => $_has(2);
  @$pb.TagNumber(3)
  void clearPassword() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get phoneNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set phoneNumber($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPhoneNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhoneNumber() => $_clearField(4);
}

class LoginUserMessage_Response extends $pb.GeneratedMessage {
  factory LoginUserMessage_Response({
    ResponseInfo? responseInfo,
    $0.UserMessage? user,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (user != null) result.user = user;
    return result;
  }

  LoginUserMessage_Response._();

  factory LoginUserMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LoginUserMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LoginUserMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..aOM<$0.UserMessage>(2, _omitFieldNames ? '' : 'user',
        subBuilder: $0.UserMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginUserMessage_Response clone() =>
      LoginUserMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginUserMessage_Response copyWith(
          void Function(LoginUserMessage_Response) updates) =>
      super.copyWith((message) => updates(message as LoginUserMessage_Response))
          as LoginUserMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoginUserMessage_Response create() => LoginUserMessage_Response._();
  @$core.override
  LoginUserMessage_Response createEmptyInstance() => create();
  static $pb.PbList<LoginUserMessage_Response> createRepeated() =>
      $pb.PbList<LoginUserMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static LoginUserMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LoginUserMessage_Response>(create);
  static LoginUserMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  /// TokenMessage access_token = 2;
  /// TokenMessage refresh_token = 3;
  @$pb.TagNumber(2)
  $0.UserMessage get user => $_getN(1);
  @$pb.TagNumber(2)
  set user($0.UserMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearUser() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UserMessage ensureUser() => $_ensure(1);
}

class LoginUserMessage extends $pb.GeneratedMessage {
  factory LoginUserMessage({
    LoginUserMessage_Request? request,
    LoginUserMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  LoginUserMessage._();

  factory LoginUserMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LoginUserMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LoginUserMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<LoginUserMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: LoginUserMessage_Request.create)
    ..aOM<LoginUserMessage_Response>(2, _omitFieldNames ? '' : 'response',
        subBuilder: LoginUserMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginUserMessage clone() => LoginUserMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginUserMessage copyWith(void Function(LoginUserMessage) updates) =>
      super.copyWith((message) => updates(message as LoginUserMessage))
          as LoginUserMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoginUserMessage create() => LoginUserMessage._();
  @$core.override
  LoginUserMessage createEmptyInstance() => create();
  static $pb.PbList<LoginUserMessage> createRepeated() =>
      $pb.PbList<LoginUserMessage>();
  @$core.pragma('dart2js:noInline')
  static LoginUserMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LoginUserMessage>(create);
  static LoginUserMessage? _defaultInstance;

  @$pb.TagNumber(1)
  LoginUserMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(LoginUserMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  LoginUserMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  LoginUserMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(LoginUserMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  LoginUserMessage_Response ensureResponse() => $_ensure(1);
}

class CreateUserMessage_Request extends $pb.GeneratedMessage {
  factory CreateUserMessage_Request({
    RequestInfo? requestInfo,
    $0.UserMessage? user,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (user != null) result.user = user;
    return result;
  }

  CreateUserMessage_Request._();

  factory CreateUserMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateUserMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateUserMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..aOM<$0.UserMessage>(2, _omitFieldNames ? '' : 'user',
        subBuilder: $0.UserMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUserMessage_Request clone() =>
      CreateUserMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUserMessage_Request copyWith(
          void Function(CreateUserMessage_Request) updates) =>
      super.copyWith((message) => updates(message as CreateUserMessage_Request))
          as CreateUserMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateUserMessage_Request create() => CreateUserMessage_Request._();
  @$core.override
  CreateUserMessage_Request createEmptyInstance() => create();
  static $pb.PbList<CreateUserMessage_Request> createRepeated() =>
      $pb.PbList<CreateUserMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static CreateUserMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateUserMessage_Request>(create);
  static CreateUserMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserMessage get user => $_getN(1);
  @$pb.TagNumber(2)
  set user($0.UserMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearUser() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UserMessage ensureUser() => $_ensure(1);
}

class CreateUserMessage_Response extends $pb.GeneratedMessage {
  factory CreateUserMessage_Response({
    ResponseInfo? responseInfo,
    $0.UserMessage? user,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (user != null) result.user = user;
    return result;
  }

  CreateUserMessage_Response._();

  factory CreateUserMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateUserMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateUserMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..aOM<$0.UserMessage>(2, _omitFieldNames ? '' : 'user',
        subBuilder: $0.UserMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUserMessage_Response clone() =>
      CreateUserMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUserMessage_Response copyWith(
          void Function(CreateUserMessage_Response) updates) =>
      super.copyWith(
              (message) => updates(message as CreateUserMessage_Response))
          as CreateUserMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateUserMessage_Response create() => CreateUserMessage_Response._();
  @$core.override
  CreateUserMessage_Response createEmptyInstance() => create();
  static $pb.PbList<CreateUserMessage_Response> createRepeated() =>
      $pb.PbList<CreateUserMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static CreateUserMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateUserMessage_Response>(create);
  static CreateUserMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserMessage get user => $_getN(1);
  @$pb.TagNumber(2)
  set user($0.UserMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearUser() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UserMessage ensureUser() => $_ensure(1);
}

class CreateUserMessage extends $pb.GeneratedMessage {
  factory CreateUserMessage({
    CreateUserMessage_Request? request,
    CreateUserMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  CreateUserMessage._();

  factory CreateUserMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateUserMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateUserMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<CreateUserMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: CreateUserMessage_Request.create)
    ..aOM<CreateUserMessage_Response>(2, _omitFieldNames ? '' : 'response',
        subBuilder: CreateUserMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUserMessage clone() => CreateUserMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUserMessage copyWith(void Function(CreateUserMessage) updates) =>
      super.copyWith((message) => updates(message as CreateUserMessage))
          as CreateUserMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateUserMessage create() => CreateUserMessage._();
  @$core.override
  CreateUserMessage createEmptyInstance() => create();
  static $pb.PbList<CreateUserMessage> createRepeated() =>
      $pb.PbList<CreateUserMessage>();
  @$core.pragma('dart2js:noInline')
  static CreateUserMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateUserMessage>(create);
  static CreateUserMessage? _defaultInstance;

  @$pb.TagNumber(1)
  CreateUserMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(CreateUserMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  CreateUserMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  CreateUserMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(CreateUserMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  CreateUserMessage_Response ensureResponse() => $_ensure(1);
}

class GetUserMessage_Request extends $pb.GeneratedMessage {
  factory GetUserMessage_Request({
    RequestInfo? requestInfo,
    $core.String? userId,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (userId != null) result.userId = userId;
    return result;
  }

  GetUserMessage_Request._();

  factory GetUserMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserMessage_Request clone() =>
      GetUserMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserMessage_Request copyWith(
          void Function(GetUserMessage_Request) updates) =>
      super.copyWith((message) => updates(message as GetUserMessage_Request))
          as GetUserMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserMessage_Request create() => GetUserMessage_Request._();
  @$core.override
  GetUserMessage_Request createEmptyInstance() => create();
  static $pb.PbList<GetUserMessage_Request> createRepeated() =>
      $pb.PbList<GetUserMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static GetUserMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserMessage_Request>(create);
  static GetUserMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);
}

class GetUserMessage_Response extends $pb.GeneratedMessage {
  factory GetUserMessage_Response({
    ResponseInfo? responseInfo,
    $0.UserMessage? user,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (user != null) result.user = user;
    return result;
  }

  GetUserMessage_Response._();

  factory GetUserMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..aOM<$0.UserMessage>(2, _omitFieldNames ? '' : 'user',
        subBuilder: $0.UserMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserMessage_Response clone() =>
      GetUserMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserMessage_Response copyWith(
          void Function(GetUserMessage_Response) updates) =>
      super.copyWith((message) => updates(message as GetUserMessage_Response))
          as GetUserMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserMessage_Response create() => GetUserMessage_Response._();
  @$core.override
  GetUserMessage_Response createEmptyInstance() => create();
  static $pb.PbList<GetUserMessage_Response> createRepeated() =>
      $pb.PbList<GetUserMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static GetUserMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserMessage_Response>(create);
  static GetUserMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserMessage get user => $_getN(1);
  @$pb.TagNumber(2)
  set user($0.UserMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearUser() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UserMessage ensureUser() => $_ensure(1);
}

class GetUserMessage extends $pb.GeneratedMessage {
  factory GetUserMessage({
    GetUserMessage_Request? request,
    GetUserMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  GetUserMessage._();

  factory GetUserMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<GetUserMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: GetUserMessage_Request.create)
    ..aOM<GetUserMessage_Response>(2, _omitFieldNames ? '' : 'response',
        subBuilder: GetUserMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserMessage clone() => GetUserMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserMessage copyWith(void Function(GetUserMessage) updates) =>
      super.copyWith((message) => updates(message as GetUserMessage))
          as GetUserMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserMessage create() => GetUserMessage._();
  @$core.override
  GetUserMessage createEmptyInstance() => create();
  static $pb.PbList<GetUserMessage> createRepeated() =>
      $pb.PbList<GetUserMessage>();
  @$core.pragma('dart2js:noInline')
  static GetUserMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserMessage>(create);
  static GetUserMessage? _defaultInstance;

  @$pb.TagNumber(1)
  GetUserMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(GetUserMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  GetUserMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  GetUserMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(GetUserMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  GetUserMessage_Response ensureResponse() => $_ensure(1);
}

class UpdateUserMessage_Request extends $pb.GeneratedMessage {
  factory UpdateUserMessage_Request({
    RequestInfo? requestInfo,
    $0.UserMessage? user,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (user != null) result.user = user;
    return result;
  }

  UpdateUserMessage_Request._();

  factory UpdateUserMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateUserMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateUserMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..aOM<$0.UserMessage>(2, _omitFieldNames ? '' : 'user',
        subBuilder: $0.UserMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateUserMessage_Request clone() =>
      UpdateUserMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateUserMessage_Request copyWith(
          void Function(UpdateUserMessage_Request) updates) =>
      super.copyWith((message) => updates(message as UpdateUserMessage_Request))
          as UpdateUserMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateUserMessage_Request create() => UpdateUserMessage_Request._();
  @$core.override
  UpdateUserMessage_Request createEmptyInstance() => create();
  static $pb.PbList<UpdateUserMessage_Request> createRepeated() =>
      $pb.PbList<UpdateUserMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static UpdateUserMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateUserMessage_Request>(create);
  static UpdateUserMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserMessage get user => $_getN(1);
  @$pb.TagNumber(2)
  set user($0.UserMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearUser() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UserMessage ensureUser() => $_ensure(1);
}

class UpdateUserMessage_Response extends $pb.GeneratedMessage {
  factory UpdateUserMessage_Response({
    ResponseInfo? responseInfo,
    $0.UserMessage? user,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (user != null) result.user = user;
    return result;
  }

  UpdateUserMessage_Response._();

  factory UpdateUserMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateUserMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateUserMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..aOM<$0.UserMessage>(2, _omitFieldNames ? '' : 'user',
        subBuilder: $0.UserMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateUserMessage_Response clone() =>
      UpdateUserMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateUserMessage_Response copyWith(
          void Function(UpdateUserMessage_Response) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateUserMessage_Response))
          as UpdateUserMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateUserMessage_Response create() => UpdateUserMessage_Response._();
  @$core.override
  UpdateUserMessage_Response createEmptyInstance() => create();
  static $pb.PbList<UpdateUserMessage_Response> createRepeated() =>
      $pb.PbList<UpdateUserMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static UpdateUserMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateUserMessage_Response>(create);
  static UpdateUserMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserMessage get user => $_getN(1);
  @$pb.TagNumber(2)
  set user($0.UserMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearUser() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UserMessage ensureUser() => $_ensure(1);
}

class UpdateUserMessage extends $pb.GeneratedMessage {
  factory UpdateUserMessage({
    UpdateUserMessage_Request? request,
    UpdateUserMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  UpdateUserMessage._();

  factory UpdateUserMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateUserMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateUserMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<UpdateUserMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: UpdateUserMessage_Request.create)
    ..aOM<UpdateUserMessage_Response>(2, _omitFieldNames ? '' : 'response',
        subBuilder: UpdateUserMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateUserMessage clone() => UpdateUserMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateUserMessage copyWith(void Function(UpdateUserMessage) updates) =>
      super.copyWith((message) => updates(message as UpdateUserMessage))
          as UpdateUserMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateUserMessage create() => UpdateUserMessage._();
  @$core.override
  UpdateUserMessage createEmptyInstance() => create();
  static $pb.PbList<UpdateUserMessage> createRepeated() =>
      $pb.PbList<UpdateUserMessage>();
  @$core.pragma('dart2js:noInline')
  static UpdateUserMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateUserMessage>(create);
  static UpdateUserMessage? _defaultInstance;

  @$pb.TagNumber(1)
  UpdateUserMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(UpdateUserMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  UpdateUserMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  UpdateUserMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(UpdateUserMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  UpdateUserMessage_Response ensureResponse() => $_ensure(1);
}

class SearchMessage_Request extends $pb.GeneratedMessage {
  factory SearchMessage_Request({
    RequestInfo? requestInfo,
    $core.String? query,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (query != null) result.query = query;
    return result;
  }

  SearchMessage_Request._();

  factory SearchMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'query')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchMessage_Request clone() =>
      SearchMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchMessage_Request copyWith(
          void Function(SearchMessage_Request) updates) =>
      super.copyWith((message) => updates(message as SearchMessage_Request))
          as SearchMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchMessage_Request create() => SearchMessage_Request._();
  @$core.override
  SearchMessage_Request createEmptyInstance() => create();
  static $pb.PbList<SearchMessage_Request> createRepeated() =>
      $pb.PbList<SearchMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static SearchMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchMessage_Request>(create);
  static SearchMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get query => $_getSZ(1);
  @$pb.TagNumber(2)
  set query($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuery() => $_clearField(2);
}

class SearchMessage_Response extends $pb.GeneratedMessage {
  factory SearchMessage_Response({
    ResponseInfo? responseInfo,
    $0.SearchResultsMessage? searchResults,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (searchResults != null) result.searchResults = searchResults;
    return result;
  }

  SearchMessage_Response._();

  factory SearchMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..aOM<$0.SearchResultsMessage>(2, _omitFieldNames ? '' : 'searchResults',
        subBuilder: $0.SearchResultsMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchMessage_Response clone() =>
      SearchMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchMessage_Response copyWith(
          void Function(SearchMessage_Response) updates) =>
      super.copyWith((message) => updates(message as SearchMessage_Response))
          as SearchMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchMessage_Response create() => SearchMessage_Response._();
  @$core.override
  SearchMessage_Response createEmptyInstance() => create();
  static $pb.PbList<SearchMessage_Response> createRepeated() =>
      $pb.PbList<SearchMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static SearchMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchMessage_Response>(create);
  static SearchMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.SearchResultsMessage get searchResults => $_getN(1);
  @$pb.TagNumber(2)
  set searchResults($0.SearchResultsMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasSearchResults() => $_has(1);
  @$pb.TagNumber(2)
  void clearSearchResults() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.SearchResultsMessage ensureSearchResults() => $_ensure(1);
}

class SearchMessage extends $pb.GeneratedMessage {
  factory SearchMessage({
    SearchMessage_Request? request,
    SearchMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  SearchMessage._();

  factory SearchMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<SearchMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: SearchMessage_Request.create)
    ..aOM<SearchMessage_Response>(2, _omitFieldNames ? '' : 'response',
        subBuilder: SearchMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchMessage clone() => SearchMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchMessage copyWith(void Function(SearchMessage) updates) =>
      super.copyWith((message) => updates(message as SearchMessage))
          as SearchMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchMessage create() => SearchMessage._();
  @$core.override
  SearchMessage createEmptyInstance() => create();
  static $pb.PbList<SearchMessage> createRepeated() =>
      $pb.PbList<SearchMessage>();
  @$core.pragma('dart2js:noInline')
  static SearchMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchMessage>(create);
  static SearchMessage? _defaultInstance;

  @$pb.TagNumber(1)
  SearchMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(SearchMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  SearchMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  SearchMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(SearchMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  SearchMessage_Response ensureResponse() => $_ensure(1);
}

class SearchTopMessage_Request extends $pb.GeneratedMessage {
  factory SearchTopMessage_Request({
    RequestInfo? requestInfo,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    return result;
  }

  SearchTopMessage_Request._();

  factory SearchTopMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchTopMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchTopMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTopMessage_Request clone() =>
      SearchTopMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTopMessage_Request copyWith(
          void Function(SearchTopMessage_Request) updates) =>
      super.copyWith((message) => updates(message as SearchTopMessage_Request))
          as SearchTopMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchTopMessage_Request create() => SearchTopMessage_Request._();
  @$core.override
  SearchTopMessage_Request createEmptyInstance() => create();
  static $pb.PbList<SearchTopMessage_Request> createRepeated() =>
      $pb.PbList<SearchTopMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static SearchTopMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchTopMessage_Request>(create);
  static SearchTopMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);
}

class SearchTopMessage_Response extends $pb.GeneratedMessage {
  factory SearchTopMessage_Response({
    ResponseInfo? responseInfo,
    $0.SearchResultsMessage? searchResults,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (searchResults != null) result.searchResults = searchResults;
    return result;
  }

  SearchTopMessage_Response._();

  factory SearchTopMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchTopMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchTopMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..aOM<$0.SearchResultsMessage>(2, _omitFieldNames ? '' : 'searchResults',
        subBuilder: $0.SearchResultsMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTopMessage_Response clone() =>
      SearchTopMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTopMessage_Response copyWith(
          void Function(SearchTopMessage_Response) updates) =>
      super.copyWith((message) => updates(message as SearchTopMessage_Response))
          as SearchTopMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchTopMessage_Response create() => SearchTopMessage_Response._();
  @$core.override
  SearchTopMessage_Response createEmptyInstance() => create();
  static $pb.PbList<SearchTopMessage_Response> createRepeated() =>
      $pb.PbList<SearchTopMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static SearchTopMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchTopMessage_Response>(create);
  static SearchTopMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.SearchResultsMessage get searchResults => $_getN(1);
  @$pb.TagNumber(2)
  set searchResults($0.SearchResultsMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasSearchResults() => $_has(1);
  @$pb.TagNumber(2)
  void clearSearchResults() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.SearchResultsMessage ensureSearchResults() => $_ensure(1);
}

/// This is primarily used for typeahead suggestions
class SearchTopMessage extends $pb.GeneratedMessage {
  factory SearchTopMessage({
    SearchTopMessage_Request? request,
    SearchTopMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  SearchTopMessage._();

  factory SearchTopMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchTopMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchTopMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<SearchTopMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: SearchTopMessage_Request.create)
    ..aOM<SearchTopMessage_Response>(2, _omitFieldNames ? '' : 'response',
        subBuilder: SearchTopMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTopMessage clone() => SearchTopMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTopMessage copyWith(void Function(SearchTopMessage) updates) =>
      super.copyWith((message) => updates(message as SearchTopMessage))
          as SearchTopMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchTopMessage create() => SearchTopMessage._();
  @$core.override
  SearchTopMessage createEmptyInstance() => create();
  static $pb.PbList<SearchTopMessage> createRepeated() =>
      $pb.PbList<SearchTopMessage>();
  @$core.pragma('dart2js:noInline')
  static SearchTopMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchTopMessage>(create);
  static SearchTopMessage? _defaultInstance;

  @$pb.TagNumber(1)
  SearchTopMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(SearchTopMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  SearchTopMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  SearchTopMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(SearchTopMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  SearchTopMessage_Response ensureResponse() => $_ensure(1);
}

class GetPodcastMessage_Request extends $pb.GeneratedMessage {
  factory GetPodcastMessage_Request({
    RequestInfo? requestInfo,
    $core.String? podcastId,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (podcastId != null) result.podcastId = podcastId;
    return result;
  }

  GetPodcastMessage_Request._();

  factory GetPodcastMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPodcastMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPodcastMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'podcastId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPodcastMessage_Request clone() =>
      GetPodcastMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPodcastMessage_Request copyWith(
          void Function(GetPodcastMessage_Request) updates) =>
      super.copyWith((message) => updates(message as GetPodcastMessage_Request))
          as GetPodcastMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPodcastMessage_Request create() => GetPodcastMessage_Request._();
  @$core.override
  GetPodcastMessage_Request createEmptyInstance() => create();
  static $pb.PbList<GetPodcastMessage_Request> createRepeated() =>
      $pb.PbList<GetPodcastMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static GetPodcastMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPodcastMessage_Request>(create);
  static GetPodcastMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get podcastId => $_getSZ(1);
  @$pb.TagNumber(2)
  set podcastId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPodcastId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPodcastId() => $_clearField(2);
}

class GetPodcastMessage_Response extends $pb.GeneratedMessage {
  factory GetPodcastMessage_Response({
    ResponseInfo? responseInfo,
    $0.PodcastMessage? podcast,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (podcast != null) result.podcast = podcast;
    return result;
  }

  GetPodcastMessage_Response._();

  factory GetPodcastMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPodcastMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPodcastMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..aOM<$0.PodcastMessage>(2, _omitFieldNames ? '' : 'podcast',
        subBuilder: $0.PodcastMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPodcastMessage_Response clone() =>
      GetPodcastMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPodcastMessage_Response copyWith(
          void Function(GetPodcastMessage_Response) updates) =>
      super.copyWith(
              (message) => updates(message as GetPodcastMessage_Response))
          as GetPodcastMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPodcastMessage_Response create() => GetPodcastMessage_Response._();
  @$core.override
  GetPodcastMessage_Response createEmptyInstance() => create();
  static $pb.PbList<GetPodcastMessage_Response> createRepeated() =>
      $pb.PbList<GetPodcastMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static GetPodcastMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPodcastMessage_Response>(create);
  static GetPodcastMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.PodcastMessage get podcast => $_getN(1);
  @$pb.TagNumber(2)
  set podcast($0.PodcastMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPodcast() => $_has(1);
  @$pb.TagNumber(2)
  void clearPodcast() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.PodcastMessage ensurePodcast() => $_ensure(1);
}

class GetPodcastMessage extends $pb.GeneratedMessage {
  factory GetPodcastMessage({
    GetPodcastMessage_Request? request,
    GetPodcastMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  GetPodcastMessage._();

  factory GetPodcastMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPodcastMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPodcastMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<GetPodcastMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: GetPodcastMessage_Request.create)
    ..aOM<GetPodcastMessage_Response>(2, _omitFieldNames ? '' : 'response',
        subBuilder: GetPodcastMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPodcastMessage clone() => GetPodcastMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPodcastMessage copyWith(void Function(GetPodcastMessage) updates) =>
      super.copyWith((message) => updates(message as GetPodcastMessage))
          as GetPodcastMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPodcastMessage create() => GetPodcastMessage._();
  @$core.override
  GetPodcastMessage createEmptyInstance() => create();
  static $pb.PbList<GetPodcastMessage> createRepeated() =>
      $pb.PbList<GetPodcastMessage>();
  @$core.pragma('dart2js:noInline')
  static GetPodcastMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPodcastMessage>(create);
  static GetPodcastMessage? _defaultInstance;

  @$pb.TagNumber(1)
  GetPodcastMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(GetPodcastMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  GetPodcastMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  GetPodcastMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(GetPodcastMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  GetPodcastMessage_Response ensureResponse() => $_ensure(1);
}

/// Used for getting the next page
class QueryCursor extends $pb.GeneratedMessage {
  factory QueryCursor({
    $core.String? cursor,
    $core.int? offset,
  }) {
    final result = create();
    if (cursor != null) result.cursor = cursor;
    if (offset != null) result.offset = offset;
    return result;
  }

  QueryCursor._();

  factory QueryCursor.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory QueryCursor.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QueryCursor',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cursor')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  QueryCursor clone() => QueryCursor()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  QueryCursor copyWith(void Function(QueryCursor) updates) =>
      super.copyWith((message) => updates(message as QueryCursor))
          as QueryCursor;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QueryCursor create() => QueryCursor._();
  @$core.override
  QueryCursor createEmptyInstance() => create();
  static $pb.PbList<QueryCursor> createRepeated() => $pb.PbList<QueryCursor>();
  @$core.pragma('dart2js:noInline')
  static QueryCursor getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QueryCursor>(create);
  static QueryCursor? _defaultInstance;

  /// For datastore queries
  @$pb.TagNumber(1)
  $core.String get cursor => $_getSZ(0);
  @$pb.TagNumber(1)
  set cursor($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCursor() => $_has(0);
  @$pb.TagNumber(1)
  void clearCursor() => $_clearField(1);

  /// For limit / offset queries eg. SQL/Memory
  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => $_clearField(2);
}

class ListPodcastEpisodesMessage_Request extends $pb.GeneratedMessage {
  factory ListPodcastEpisodesMessage_Request({
    RequestInfo? requestInfo,
    $core.String? podcastId,
    QueryCursor? cursor,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (podcastId != null) result.podcastId = podcastId;
    if (cursor != null) result.cursor = cursor;
    return result;
  }

  ListPodcastEpisodesMessage_Request._();

  factory ListPodcastEpisodesMessage_Request.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListPodcastEpisodesMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListPodcastEpisodesMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'podcastId')
    ..aOM<QueryCursor>(3, _omitFieldNames ? '' : 'cursor',
        subBuilder: QueryCursor.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPodcastEpisodesMessage_Request clone() =>
      ListPodcastEpisodesMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPodcastEpisodesMessage_Request copyWith(
          void Function(ListPodcastEpisodesMessage_Request) updates) =>
      super.copyWith((message) =>
              updates(message as ListPodcastEpisodesMessage_Request))
          as ListPodcastEpisodesMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPodcastEpisodesMessage_Request create() =>
      ListPodcastEpisodesMessage_Request._();
  @$core.override
  ListPodcastEpisodesMessage_Request createEmptyInstance() => create();
  static $pb.PbList<ListPodcastEpisodesMessage_Request> createRepeated() =>
      $pb.PbList<ListPodcastEpisodesMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static ListPodcastEpisodesMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListPodcastEpisodesMessage_Request>(
          create);
  static ListPodcastEpisodesMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get podcastId => $_getSZ(1);
  @$pb.TagNumber(2)
  set podcastId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPodcastId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPodcastId() => $_clearField(2);

  @$pb.TagNumber(3)
  QueryCursor get cursor => $_getN(2);
  @$pb.TagNumber(3)
  set cursor(QueryCursor value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCursor() => $_has(2);
  @$pb.TagNumber(3)
  void clearCursor() => $_clearField(3);
  @$pb.TagNumber(3)
  QueryCursor ensureCursor() => $_ensure(2);
}

class ListPodcastEpisodesMessage_Response extends $pb.GeneratedMessage {
  factory ListPodcastEpisodesMessage_Response({
    ResponseInfo? responseInfo,
    $core.Iterable<$0.EpisodeMessage>? episodes,
    $0.PodcastMessage? podcast,
    QueryCursor? cursor,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (episodes != null) result.episodes.addAll(episodes);
    if (podcast != null) result.podcast = podcast;
    if (cursor != null) result.cursor = cursor;
    return result;
  }

  ListPodcastEpisodesMessage_Response._();

  factory ListPodcastEpisodesMessage_Response.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListPodcastEpisodesMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListPodcastEpisodesMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..pc<$0.EpisodeMessage>(
        2, _omitFieldNames ? '' : 'episodes', $pb.PbFieldType.PM,
        subBuilder: $0.EpisodeMessage.create)
    ..aOM<$0.PodcastMessage>(3, _omitFieldNames ? '' : 'podcast',
        subBuilder: $0.PodcastMessage.create)
    ..aOM<QueryCursor>(4, _omitFieldNames ? '' : 'cursor',
        subBuilder: QueryCursor.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPodcastEpisodesMessage_Response clone() =>
      ListPodcastEpisodesMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPodcastEpisodesMessage_Response copyWith(
          void Function(ListPodcastEpisodesMessage_Response) updates) =>
      super.copyWith((message) =>
              updates(message as ListPodcastEpisodesMessage_Response))
          as ListPodcastEpisodesMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPodcastEpisodesMessage_Response create() =>
      ListPodcastEpisodesMessage_Response._();
  @$core.override
  ListPodcastEpisodesMessage_Response createEmptyInstance() => create();
  static $pb.PbList<ListPodcastEpisodesMessage_Response> createRepeated() =>
      $pb.PbList<ListPodcastEpisodesMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static ListPodcastEpisodesMessage_Response getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          ListPodcastEpisodesMessage_Response>(create);
  static ListPodcastEpisodesMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<$0.EpisodeMessage> get episodes => $_getList(1);

  /// TODO(duncan): Am I using this?
  @$pb.TagNumber(3)
  $0.PodcastMessage get podcast => $_getN(2);
  @$pb.TagNumber(3)
  set podcast($0.PodcastMessage value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPodcast() => $_has(2);
  @$pb.TagNumber(3)
  void clearPodcast() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.PodcastMessage ensurePodcast() => $_ensure(2);

  @$pb.TagNumber(4)
  QueryCursor get cursor => $_getN(3);
  @$pb.TagNumber(4)
  set cursor(QueryCursor value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCursor() => $_has(3);
  @$pb.TagNumber(4)
  void clearCursor() => $_clearField(4);
  @$pb.TagNumber(4)
  QueryCursor ensureCursor() => $_ensure(3);
}

/// Used to list the podcast episodes
class ListPodcastEpisodesMessage extends $pb.GeneratedMessage {
  factory ListPodcastEpisodesMessage({
    ListPodcastEpisodesMessage_Request? request,
    ListPodcastEpisodesMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  ListPodcastEpisodesMessage._();

  factory ListPodcastEpisodesMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListPodcastEpisodesMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListPodcastEpisodesMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ListPodcastEpisodesMessage_Request>(
        1, _omitFieldNames ? '' : 'request',
        subBuilder: ListPodcastEpisodesMessage_Request.create)
    ..aOM<ListPodcastEpisodesMessage_Response>(
        2, _omitFieldNames ? '' : 'response',
        subBuilder: ListPodcastEpisodesMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPodcastEpisodesMessage clone() =>
      ListPodcastEpisodesMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPodcastEpisodesMessage copyWith(
          void Function(ListPodcastEpisodesMessage) updates) =>
      super.copyWith(
              (message) => updates(message as ListPodcastEpisodesMessage))
          as ListPodcastEpisodesMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPodcastEpisodesMessage create() => ListPodcastEpisodesMessage._();
  @$core.override
  ListPodcastEpisodesMessage createEmptyInstance() => create();
  static $pb.PbList<ListPodcastEpisodesMessage> createRepeated() =>
      $pb.PbList<ListPodcastEpisodesMessage>();
  @$core.pragma('dart2js:noInline')
  static ListPodcastEpisodesMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListPodcastEpisodesMessage>(create);
  static ListPodcastEpisodesMessage? _defaultInstance;

  @$pb.TagNumber(1)
  ListPodcastEpisodesMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(ListPodcastEpisodesMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  ListPodcastEpisodesMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  ListPodcastEpisodesMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(ListPodcastEpisodesMessage_Response value) =>
      $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  ListPodcastEpisodesMessage_Response ensureResponse() => $_ensure(1);
}

class GetEpisodeMessage_Request extends $pb.GeneratedMessage {
  factory GetEpisodeMessage_Request({
    RequestInfo? requestInfo,
    $core.String? episodeId,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (episodeId != null) result.episodeId = episodeId;
    return result;
  }

  GetEpisodeMessage_Request._();

  factory GetEpisodeMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetEpisodeMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetEpisodeMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'episodeId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEpisodeMessage_Request clone() =>
      GetEpisodeMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEpisodeMessage_Request copyWith(
          void Function(GetEpisodeMessage_Request) updates) =>
      super.copyWith((message) => updates(message as GetEpisodeMessage_Request))
          as GetEpisodeMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetEpisodeMessage_Request create() => GetEpisodeMessage_Request._();
  @$core.override
  GetEpisodeMessage_Request createEmptyInstance() => create();
  static $pb.PbList<GetEpisodeMessage_Request> createRepeated() =>
      $pb.PbList<GetEpisodeMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static GetEpisodeMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetEpisodeMessage_Request>(create);
  static GetEpisodeMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get episodeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set episodeId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEpisodeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearEpisodeId() => $_clearField(2);
}

class GetEpisodeMessage_Response extends $pb.GeneratedMessage {
  factory GetEpisodeMessage_Response({
    ResponseInfo? responseInfo,
    $0.EpisodeMessage? episode,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (episode != null) result.episode = episode;
    return result;
  }

  GetEpisodeMessage_Response._();

  factory GetEpisodeMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetEpisodeMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetEpisodeMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..aOM<$0.EpisodeMessage>(2, _omitFieldNames ? '' : 'episode',
        subBuilder: $0.EpisodeMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEpisodeMessage_Response clone() =>
      GetEpisodeMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEpisodeMessage_Response copyWith(
          void Function(GetEpisodeMessage_Response) updates) =>
      super.copyWith(
              (message) => updates(message as GetEpisodeMessage_Response))
          as GetEpisodeMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetEpisodeMessage_Response create() => GetEpisodeMessage_Response._();
  @$core.override
  GetEpisodeMessage_Response createEmptyInstance() => create();
  static $pb.PbList<GetEpisodeMessage_Response> createRepeated() =>
      $pb.PbList<GetEpisodeMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static GetEpisodeMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetEpisodeMessage_Response>(create);
  static GetEpisodeMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.EpisodeMessage get episode => $_getN(1);
  @$pb.TagNumber(2)
  set episode($0.EpisodeMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEpisode() => $_has(1);
  @$pb.TagNumber(2)
  void clearEpisode() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.EpisodeMessage ensureEpisode() => $_ensure(1);
}

class GetEpisodeMessage extends $pb.GeneratedMessage {
  factory GetEpisodeMessage({
    GetEpisodeMessage_Request? request,
    GetEpisodeMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  GetEpisodeMessage._();

  factory GetEpisodeMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetEpisodeMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetEpisodeMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<GetEpisodeMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: GetEpisodeMessage_Request.create)
    ..aOM<GetEpisodeMessage_Response>(2, _omitFieldNames ? '' : 'response',
        subBuilder: GetEpisodeMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEpisodeMessage clone() => GetEpisodeMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEpisodeMessage copyWith(void Function(GetEpisodeMessage) updates) =>
      super.copyWith((message) => updates(message as GetEpisodeMessage))
          as GetEpisodeMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetEpisodeMessage create() => GetEpisodeMessage._();
  @$core.override
  GetEpisodeMessage createEmptyInstance() => create();
  static $pb.PbList<GetEpisodeMessage> createRepeated() =>
      $pb.PbList<GetEpisodeMessage>();
  @$core.pragma('dart2js:noInline')
  static GetEpisodeMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetEpisodeMessage>(create);
  static GetEpisodeMessage? _defaultInstance;

  @$pb.TagNumber(1)
  GetEpisodeMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(GetEpisodeMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  GetEpisodeMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  GetEpisodeMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(GetEpisodeMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  GetEpisodeMessage_Response ensureResponse() => $_ensure(1);
}

class AddSubscriptionMessage_Request extends $pb.GeneratedMessage {
  factory AddSubscriptionMessage_Request({
    RequestInfo? requestInfo,
    $0.UserSubscriptionMessage? subscription,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (subscription != null) result.subscription = subscription;
    return result;
  }

  AddSubscriptionMessage_Request._();

  factory AddSubscriptionMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddSubscriptionMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddSubscriptionMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..aOM<$0.UserSubscriptionMessage>(2, _omitFieldNames ? '' : 'subscription',
        subBuilder: $0.UserSubscriptionMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddSubscriptionMessage_Request clone() =>
      AddSubscriptionMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddSubscriptionMessage_Request copyWith(
          void Function(AddSubscriptionMessage_Request) updates) =>
      super.copyWith(
              (message) => updates(message as AddSubscriptionMessage_Request))
          as AddSubscriptionMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddSubscriptionMessage_Request create() =>
      AddSubscriptionMessage_Request._();
  @$core.override
  AddSubscriptionMessage_Request createEmptyInstance() => create();
  static $pb.PbList<AddSubscriptionMessage_Request> createRepeated() =>
      $pb.PbList<AddSubscriptionMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static AddSubscriptionMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddSubscriptionMessage_Request>(create);
  static AddSubscriptionMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserSubscriptionMessage get subscription => $_getN(1);
  @$pb.TagNumber(2)
  set subscription($0.UserSubscriptionMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasSubscription() => $_has(1);
  @$pb.TagNumber(2)
  void clearSubscription() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UserSubscriptionMessage ensureSubscription() => $_ensure(1);
}

class AddSubscriptionMessage_Response extends $pb.GeneratedMessage {
  factory AddSubscriptionMessage_Response({
    ResponseInfo? responseInfo,
    $0.UserSubscriptionMessage? subscription,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (subscription != null) result.subscription = subscription;
    return result;
  }

  AddSubscriptionMessage_Response._();

  factory AddSubscriptionMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddSubscriptionMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddSubscriptionMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..aOM<$0.UserSubscriptionMessage>(2, _omitFieldNames ? '' : 'subscription',
        subBuilder: $0.UserSubscriptionMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddSubscriptionMessage_Response clone() =>
      AddSubscriptionMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddSubscriptionMessage_Response copyWith(
          void Function(AddSubscriptionMessage_Response) updates) =>
      super.copyWith(
              (message) => updates(message as AddSubscriptionMessage_Response))
          as AddSubscriptionMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddSubscriptionMessage_Response create() =>
      AddSubscriptionMessage_Response._();
  @$core.override
  AddSubscriptionMessage_Response createEmptyInstance() => create();
  static $pb.PbList<AddSubscriptionMessage_Response> createRepeated() =>
      $pb.PbList<AddSubscriptionMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static AddSubscriptionMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddSubscriptionMessage_Response>(
          create);
  static AddSubscriptionMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserSubscriptionMessage get subscription => $_getN(1);
  @$pb.TagNumber(2)
  set subscription($0.UserSubscriptionMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasSubscription() => $_has(1);
  @$pb.TagNumber(2)
  void clearSubscription() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UserSubscriptionMessage ensureSubscription() => $_ensure(1);
}

class AddSubscriptionMessage extends $pb.GeneratedMessage {
  factory AddSubscriptionMessage({
    AddSubscriptionMessage_Request? request,
    AddSubscriptionMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  AddSubscriptionMessage._();

  factory AddSubscriptionMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddSubscriptionMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddSubscriptionMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<AddSubscriptionMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: AddSubscriptionMessage_Request.create)
    ..aOM<AddSubscriptionMessage_Response>(2, _omitFieldNames ? '' : 'response',
        subBuilder: AddSubscriptionMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddSubscriptionMessage clone() =>
      AddSubscriptionMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddSubscriptionMessage copyWith(
          void Function(AddSubscriptionMessage) updates) =>
      super.copyWith((message) => updates(message as AddSubscriptionMessage))
          as AddSubscriptionMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddSubscriptionMessage create() => AddSubscriptionMessage._();
  @$core.override
  AddSubscriptionMessage createEmptyInstance() => create();
  static $pb.PbList<AddSubscriptionMessage> createRepeated() =>
      $pb.PbList<AddSubscriptionMessage>();
  @$core.pragma('dart2js:noInline')
  static AddSubscriptionMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddSubscriptionMessage>(create);
  static AddSubscriptionMessage? _defaultInstance;

  @$pb.TagNumber(1)
  AddSubscriptionMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(AddSubscriptionMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  AddSubscriptionMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  AddSubscriptionMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(AddSubscriptionMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  AddSubscriptionMessage_Response ensureResponse() => $_ensure(1);
}

class RemoveSubscriptionMessage_Request extends $pb.GeneratedMessage {
  factory RemoveSubscriptionMessage_Request({
    RequestInfo? requestInfo,
    $0.UserSubscriptionMessage? subscription,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (subscription != null) result.subscription = subscription;
    return result;
  }

  RemoveSubscriptionMessage_Request._();

  factory RemoveSubscriptionMessage_Request.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveSubscriptionMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveSubscriptionMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..aOM<$0.UserSubscriptionMessage>(2, _omitFieldNames ? '' : 'subscription',
        subBuilder: $0.UserSubscriptionMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveSubscriptionMessage_Request clone() =>
      RemoveSubscriptionMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveSubscriptionMessage_Request copyWith(
          void Function(RemoveSubscriptionMessage_Request) updates) =>
      super.copyWith((message) =>
              updates(message as RemoveSubscriptionMessage_Request))
          as RemoveSubscriptionMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveSubscriptionMessage_Request create() =>
      RemoveSubscriptionMessage_Request._();
  @$core.override
  RemoveSubscriptionMessage_Request createEmptyInstance() => create();
  static $pb.PbList<RemoveSubscriptionMessage_Request> createRepeated() =>
      $pb.PbList<RemoveSubscriptionMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static RemoveSubscriptionMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveSubscriptionMessage_Request>(
          create);
  static RemoveSubscriptionMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserSubscriptionMessage get subscription => $_getN(1);
  @$pb.TagNumber(2)
  set subscription($0.UserSubscriptionMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasSubscription() => $_has(1);
  @$pb.TagNumber(2)
  void clearSubscription() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UserSubscriptionMessage ensureSubscription() => $_ensure(1);
}

class RemoveSubscriptionMessage_Response extends $pb.GeneratedMessage {
  factory RemoveSubscriptionMessage_Response({
    ResponseInfo? responseInfo,
    $0.UserSubscriptionMessage? subscription,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (subscription != null) result.subscription = subscription;
    return result;
  }

  RemoveSubscriptionMessage_Response._();

  factory RemoveSubscriptionMessage_Response.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveSubscriptionMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveSubscriptionMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..aOM<$0.UserSubscriptionMessage>(2, _omitFieldNames ? '' : 'subscription',
        subBuilder: $0.UserSubscriptionMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveSubscriptionMessage_Response clone() =>
      RemoveSubscriptionMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveSubscriptionMessage_Response copyWith(
          void Function(RemoveSubscriptionMessage_Response) updates) =>
      super.copyWith((message) =>
              updates(message as RemoveSubscriptionMessage_Response))
          as RemoveSubscriptionMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveSubscriptionMessage_Response create() =>
      RemoveSubscriptionMessage_Response._();
  @$core.override
  RemoveSubscriptionMessage_Response createEmptyInstance() => create();
  static $pb.PbList<RemoveSubscriptionMessage_Response> createRepeated() =>
      $pb.PbList<RemoveSubscriptionMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static RemoveSubscriptionMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveSubscriptionMessage_Response>(
          create);
  static RemoveSubscriptionMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserSubscriptionMessage get subscription => $_getN(1);
  @$pb.TagNumber(2)
  set subscription($0.UserSubscriptionMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasSubscription() => $_has(1);
  @$pb.TagNumber(2)
  void clearSubscription() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UserSubscriptionMessage ensureSubscription() => $_ensure(1);
}

/// Do I need this? Basically the same as Add
class RemoveSubscriptionMessage extends $pb.GeneratedMessage {
  factory RemoveSubscriptionMessage({
    RemoveSubscriptionMessage_Request? request,
    RemoveSubscriptionMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  RemoveSubscriptionMessage._();

  factory RemoveSubscriptionMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveSubscriptionMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveSubscriptionMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RemoveSubscriptionMessage_Request>(
        1, _omitFieldNames ? '' : 'request',
        subBuilder: RemoveSubscriptionMessage_Request.create)
    ..aOM<RemoveSubscriptionMessage_Response>(
        2, _omitFieldNames ? '' : 'response',
        subBuilder: RemoveSubscriptionMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveSubscriptionMessage clone() =>
      RemoveSubscriptionMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveSubscriptionMessage copyWith(
          void Function(RemoveSubscriptionMessage) updates) =>
      super.copyWith((message) => updates(message as RemoveSubscriptionMessage))
          as RemoveSubscriptionMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveSubscriptionMessage create() => RemoveSubscriptionMessage._();
  @$core.override
  RemoveSubscriptionMessage createEmptyInstance() => create();
  static $pb.PbList<RemoveSubscriptionMessage> createRepeated() =>
      $pb.PbList<RemoveSubscriptionMessage>();
  @$core.pragma('dart2js:noInline')
  static RemoveSubscriptionMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveSubscriptionMessage>(create);
  static RemoveSubscriptionMessage? _defaultInstance;

  @$pb.TagNumber(1)
  RemoveSubscriptionMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(RemoveSubscriptionMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  RemoveSubscriptionMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  RemoveSubscriptionMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(RemoveSubscriptionMessage_Response value) =>
      $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  RemoveSubscriptionMessage_Response ensureResponse() => $_ensure(1);
}

class ListSubscriptionMessage_Request extends $pb.GeneratedMessage {
  factory ListSubscriptionMessage_Request({
    RequestInfo? requestInfo,
    $core.String? userId,
    $core.bool? includePodcasts,
    QueryCursor? cursor,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (userId != null) result.userId = userId;
    if (includePodcasts != null) result.includePodcasts = includePodcasts;
    if (cursor != null) result.cursor = cursor;
    return result;
  }

  ListSubscriptionMessage_Request._();

  factory ListSubscriptionMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListSubscriptionMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListSubscriptionMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOB(3, _omitFieldNames ? '' : 'includePodcasts')
    ..aOM<QueryCursor>(4, _omitFieldNames ? '' : 'cursor',
        subBuilder: QueryCursor.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSubscriptionMessage_Request clone() =>
      ListSubscriptionMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSubscriptionMessage_Request copyWith(
          void Function(ListSubscriptionMessage_Request) updates) =>
      super.copyWith(
              (message) => updates(message as ListSubscriptionMessage_Request))
          as ListSubscriptionMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListSubscriptionMessage_Request create() =>
      ListSubscriptionMessage_Request._();
  @$core.override
  ListSubscriptionMessage_Request createEmptyInstance() => create();
  static $pb.PbList<ListSubscriptionMessage_Request> createRepeated() =>
      $pb.PbList<ListSubscriptionMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static ListSubscriptionMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListSubscriptionMessage_Request>(
          create);
  static ListSubscriptionMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get includePodcasts => $_getBF(2);
  @$pb.TagNumber(3)
  set includePodcasts($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIncludePodcasts() => $_has(2);
  @$pb.TagNumber(3)
  void clearIncludePodcasts() => $_clearField(3);

  @$pb.TagNumber(4)
  QueryCursor get cursor => $_getN(3);
  @$pb.TagNumber(4)
  set cursor(QueryCursor value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCursor() => $_has(3);
  @$pb.TagNumber(4)
  void clearCursor() => $_clearField(4);
  @$pb.TagNumber(4)
  QueryCursor ensureCursor() => $_ensure(3);
}

class ListSubscriptionMessage_Response extends $pb.GeneratedMessage {
  factory ListSubscriptionMessage_Response({
    ResponseInfo? responseInfo,
    $core.Iterable<$0.UserSubscriptionMessage>? subscriptions,
    QueryCursor? cursor,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (subscriptions != null) result.subscriptions.addAll(subscriptions);
    if (cursor != null) result.cursor = cursor;
    return result;
  }

  ListSubscriptionMessage_Response._();

  factory ListSubscriptionMessage_Response.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListSubscriptionMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListSubscriptionMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..pc<$0.UserSubscriptionMessage>(
        2, _omitFieldNames ? '' : 'subscriptions', $pb.PbFieldType.PM,
        subBuilder: $0.UserSubscriptionMessage.create)
    ..aOM<QueryCursor>(3, _omitFieldNames ? '' : 'cursor',
        subBuilder: QueryCursor.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSubscriptionMessage_Response clone() =>
      ListSubscriptionMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSubscriptionMessage_Response copyWith(
          void Function(ListSubscriptionMessage_Response) updates) =>
      super.copyWith(
              (message) => updates(message as ListSubscriptionMessage_Response))
          as ListSubscriptionMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListSubscriptionMessage_Response create() =>
      ListSubscriptionMessage_Response._();
  @$core.override
  ListSubscriptionMessage_Response createEmptyInstance() => create();
  static $pb.PbList<ListSubscriptionMessage_Response> createRepeated() =>
      $pb.PbList<ListSubscriptionMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static ListSubscriptionMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListSubscriptionMessage_Response>(
          create);
  static ListSubscriptionMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<$0.UserSubscriptionMessage> get subscriptions => $_getList(1);

  @$pb.TagNumber(3)
  QueryCursor get cursor => $_getN(2);
  @$pb.TagNumber(3)
  set cursor(QueryCursor value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCursor() => $_has(2);
  @$pb.TagNumber(3)
  void clearCursor() => $_clearField(3);
  @$pb.TagNumber(3)
  QueryCursor ensureCursor() => $_ensure(2);
}

class ListSubscriptionMessage extends $pb.GeneratedMessage {
  factory ListSubscriptionMessage({
    ListSubscriptionMessage_Request? request,
    ListSubscriptionMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  ListSubscriptionMessage._();

  factory ListSubscriptionMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListSubscriptionMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListSubscriptionMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ListSubscriptionMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: ListSubscriptionMessage_Request.create)
    ..aOM<ListSubscriptionMessage_Response>(
        2, _omitFieldNames ? '' : 'response',
        subBuilder: ListSubscriptionMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSubscriptionMessage clone() =>
      ListSubscriptionMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSubscriptionMessage copyWith(
          void Function(ListSubscriptionMessage) updates) =>
      super.copyWith((message) => updates(message as ListSubscriptionMessage))
          as ListSubscriptionMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListSubscriptionMessage create() => ListSubscriptionMessage._();
  @$core.override
  ListSubscriptionMessage createEmptyInstance() => create();
  static $pb.PbList<ListSubscriptionMessage> createRepeated() =>
      $pb.PbList<ListSubscriptionMessage>();
  @$core.pragma('dart2js:noInline')
  static ListSubscriptionMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListSubscriptionMessage>(create);
  static ListSubscriptionMessage? _defaultInstance;

  @$pb.TagNumber(1)
  ListSubscriptionMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(ListSubscriptionMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  ListSubscriptionMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  ListSubscriptionMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(ListSubscriptionMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  ListSubscriptionMessage_Response ensureResponse() => $_ensure(1);
}

class SyncSubscriptionMessage_Request extends $pb.GeneratedMessage {
  factory SyncSubscriptionMessage_Request({
    RequestInfo? requestInfo,
    $core.Iterable<$0.UserSubscriptionMessage>? subscriptions,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (subscriptions != null) result.subscriptions.addAll(subscriptions);
    return result;
  }

  SyncSubscriptionMessage_Request._();

  factory SyncSubscriptionMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SyncSubscriptionMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncSubscriptionMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..pc<$0.UserSubscriptionMessage>(
        2, _omitFieldNames ? '' : 'subscriptions', $pb.PbFieldType.PM,
        subBuilder: $0.UserSubscriptionMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncSubscriptionMessage_Request clone() =>
      SyncSubscriptionMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncSubscriptionMessage_Request copyWith(
          void Function(SyncSubscriptionMessage_Request) updates) =>
      super.copyWith(
              (message) => updates(message as SyncSubscriptionMessage_Request))
          as SyncSubscriptionMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncSubscriptionMessage_Request create() =>
      SyncSubscriptionMessage_Request._();
  @$core.override
  SyncSubscriptionMessage_Request createEmptyInstance() => create();
  static $pb.PbList<SyncSubscriptionMessage_Request> createRepeated() =>
      $pb.PbList<SyncSubscriptionMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static SyncSubscriptionMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncSubscriptionMessage_Request>(
          create);
  static SyncSubscriptionMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<$0.UserSubscriptionMessage> get subscriptions => $_getList(1);
}

class SyncSubscriptionMessage_Response extends $pb.GeneratedMessage {
  factory SyncSubscriptionMessage_Response({
    ResponseInfo? responseInfo,
    $core.Iterable<$0.UserSubscriptionMessage>? subscriptions,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (subscriptions != null) result.subscriptions.addAll(subscriptions);
    return result;
  }

  SyncSubscriptionMessage_Response._();

  factory SyncSubscriptionMessage_Response.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SyncSubscriptionMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncSubscriptionMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..pc<$0.UserSubscriptionMessage>(
        2, _omitFieldNames ? '' : 'subscriptions', $pb.PbFieldType.PM,
        subBuilder: $0.UserSubscriptionMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncSubscriptionMessage_Response clone() =>
      SyncSubscriptionMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncSubscriptionMessage_Response copyWith(
          void Function(SyncSubscriptionMessage_Response) updates) =>
      super.copyWith(
              (message) => updates(message as SyncSubscriptionMessage_Response))
          as SyncSubscriptionMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncSubscriptionMessage_Response create() =>
      SyncSubscriptionMessage_Response._();
  @$core.override
  SyncSubscriptionMessage_Response createEmptyInstance() => create();
  static $pb.PbList<SyncSubscriptionMessage_Response> createRepeated() =>
      $pb.PbList<SyncSubscriptionMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static SyncSubscriptionMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncSubscriptionMessage_Response>(
          create);
  static SyncSubscriptionMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<$0.UserSubscriptionMessage> get subscriptions => $_getList(1);
}

class SyncSubscriptionMessage extends $pb.GeneratedMessage {
  factory SyncSubscriptionMessage({
    SyncSubscriptionMessage_Request? request,
    SyncSubscriptionMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  SyncSubscriptionMessage._();

  factory SyncSubscriptionMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SyncSubscriptionMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncSubscriptionMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<SyncSubscriptionMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: SyncSubscriptionMessage_Request.create)
    ..aOM<SyncSubscriptionMessage_Response>(
        2, _omitFieldNames ? '' : 'response',
        subBuilder: SyncSubscriptionMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncSubscriptionMessage clone() =>
      SyncSubscriptionMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncSubscriptionMessage copyWith(
          void Function(SyncSubscriptionMessage) updates) =>
      super.copyWith((message) => updates(message as SyncSubscriptionMessage))
          as SyncSubscriptionMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncSubscriptionMessage create() => SyncSubscriptionMessage._();
  @$core.override
  SyncSubscriptionMessage createEmptyInstance() => create();
  static $pb.PbList<SyncSubscriptionMessage> createRepeated() =>
      $pb.PbList<SyncSubscriptionMessage>();
  @$core.pragma('dart2js:noInline')
  static SyncSubscriptionMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncSubscriptionMessage>(create);
  static SyncSubscriptionMessage? _defaultInstance;

  @$pb.TagNumber(1)
  SyncSubscriptionMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(SyncSubscriptionMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  SyncSubscriptionMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  SyncSubscriptionMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(SyncSubscriptionMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  SyncSubscriptionMessage_Response ensureResponse() => $_ensure(1);
}

class AddListenMessage_Request extends $pb.GeneratedMessage {
  factory AddListenMessage_Request({
    RequestInfo? requestInfo,
    $0.UserListenMessage? listen,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (listen != null) result.listen = listen;
    return result;
  }

  AddListenMessage_Request._();

  factory AddListenMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddListenMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddListenMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..aOM<$0.UserListenMessage>(2, _omitFieldNames ? '' : 'listen',
        subBuilder: $0.UserListenMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddListenMessage_Request clone() =>
      AddListenMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddListenMessage_Request copyWith(
          void Function(AddListenMessage_Request) updates) =>
      super.copyWith((message) => updates(message as AddListenMessage_Request))
          as AddListenMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddListenMessage_Request create() => AddListenMessage_Request._();
  @$core.override
  AddListenMessage_Request createEmptyInstance() => create();
  static $pb.PbList<AddListenMessage_Request> createRepeated() =>
      $pb.PbList<AddListenMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static AddListenMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddListenMessage_Request>(create);
  static AddListenMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserListenMessage get listen => $_getN(1);
  @$pb.TagNumber(2)
  set listen($0.UserListenMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasListen() => $_has(1);
  @$pb.TagNumber(2)
  void clearListen() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UserListenMessage ensureListen() => $_ensure(1);
}

class AddListenMessage_Response extends $pb.GeneratedMessage {
  factory AddListenMessage_Response({
    ResponseInfo? responseInfo,
    $0.UserListenMessage? listen,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (listen != null) result.listen = listen;
    return result;
  }

  AddListenMessage_Response._();

  factory AddListenMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddListenMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddListenMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..aOM<$0.UserListenMessage>(2, _omitFieldNames ? '' : 'listen',
        subBuilder: $0.UserListenMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddListenMessage_Response clone() =>
      AddListenMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddListenMessage_Response copyWith(
          void Function(AddListenMessage_Response) updates) =>
      super.copyWith((message) => updates(message as AddListenMessage_Response))
          as AddListenMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddListenMessage_Response create() => AddListenMessage_Response._();
  @$core.override
  AddListenMessage_Response createEmptyInstance() => create();
  static $pb.PbList<AddListenMessage_Response> createRepeated() =>
      $pb.PbList<AddListenMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static AddListenMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddListenMessage_Response>(create);
  static AddListenMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserListenMessage get listen => $_getN(1);
  @$pb.TagNumber(2)
  set listen($0.UserListenMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasListen() => $_has(1);
  @$pb.TagNumber(2)
  void clearListen() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UserListenMessage ensureListen() => $_ensure(1);
}

class AddListenMessage extends $pb.GeneratedMessage {
  factory AddListenMessage({
    AddListenMessage_Request? request,
    AddListenMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  AddListenMessage._();

  factory AddListenMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddListenMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddListenMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<AddListenMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: AddListenMessage_Request.create)
    ..aOM<AddListenMessage_Response>(2, _omitFieldNames ? '' : 'response',
        subBuilder: AddListenMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddListenMessage clone() => AddListenMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddListenMessage copyWith(void Function(AddListenMessage) updates) =>
      super.copyWith((message) => updates(message as AddListenMessage))
          as AddListenMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddListenMessage create() => AddListenMessage._();
  @$core.override
  AddListenMessage createEmptyInstance() => create();
  static $pb.PbList<AddListenMessage> createRepeated() =>
      $pb.PbList<AddListenMessage>();
  @$core.pragma('dart2js:noInline')
  static AddListenMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddListenMessage>(create);
  static AddListenMessage? _defaultInstance;

  @$pb.TagNumber(1)
  AddListenMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(AddListenMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  AddListenMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  AddListenMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(AddListenMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  AddListenMessage_Response ensureResponse() => $_ensure(1);
}

class RemoveListenMessage_Request extends $pb.GeneratedMessage {
  factory RemoveListenMessage_Request({
    RequestInfo? requestInfo,
    $0.UserListenMessage? listen,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (listen != null) result.listen = listen;
    return result;
  }

  RemoveListenMessage_Request._();

  factory RemoveListenMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveListenMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveListenMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..aOM<$0.UserListenMessage>(2, _omitFieldNames ? '' : 'listen',
        subBuilder: $0.UserListenMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveListenMessage_Request clone() =>
      RemoveListenMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveListenMessage_Request copyWith(
          void Function(RemoveListenMessage_Request) updates) =>
      super.copyWith(
              (message) => updates(message as RemoveListenMessage_Request))
          as RemoveListenMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveListenMessage_Request create() =>
      RemoveListenMessage_Request._();
  @$core.override
  RemoveListenMessage_Request createEmptyInstance() => create();
  static $pb.PbList<RemoveListenMessage_Request> createRepeated() =>
      $pb.PbList<RemoveListenMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static RemoveListenMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveListenMessage_Request>(create);
  static RemoveListenMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserListenMessage get listen => $_getN(1);
  @$pb.TagNumber(2)
  set listen($0.UserListenMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasListen() => $_has(1);
  @$pb.TagNumber(2)
  void clearListen() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UserListenMessage ensureListen() => $_ensure(1);
}

class RemoveListenMessage_Response extends $pb.GeneratedMessage {
  factory RemoveListenMessage_Response({
    ResponseInfo? responseInfo,
    $0.UserListenMessage? listen,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (listen != null) result.listen = listen;
    return result;
  }

  RemoveListenMessage_Response._();

  factory RemoveListenMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveListenMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveListenMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..aOM<$0.UserListenMessage>(2, _omitFieldNames ? '' : 'listen',
        subBuilder: $0.UserListenMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveListenMessage_Response clone() =>
      RemoveListenMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveListenMessage_Response copyWith(
          void Function(RemoveListenMessage_Response) updates) =>
      super.copyWith(
              (message) => updates(message as RemoveListenMessage_Response))
          as RemoveListenMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveListenMessage_Response create() =>
      RemoveListenMessage_Response._();
  @$core.override
  RemoveListenMessage_Response createEmptyInstance() => create();
  static $pb.PbList<RemoveListenMessage_Response> createRepeated() =>
      $pb.PbList<RemoveListenMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static RemoveListenMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveListenMessage_Response>(create);
  static RemoveListenMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserListenMessage get listen => $_getN(1);
  @$pb.TagNumber(2)
  set listen($0.UserListenMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasListen() => $_has(1);
  @$pb.TagNumber(2)
  void clearListen() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UserListenMessage ensureListen() => $_ensure(1);
}

class RemoveListenMessage extends $pb.GeneratedMessage {
  factory RemoveListenMessage({
    RemoveListenMessage_Request? request,
    RemoveListenMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  RemoveListenMessage._();

  factory RemoveListenMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveListenMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveListenMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RemoveListenMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: RemoveListenMessage_Request.create)
    ..aOM<RemoveListenMessage_Response>(2, _omitFieldNames ? '' : 'response',
        subBuilder: RemoveListenMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveListenMessage clone() => RemoveListenMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveListenMessage copyWith(void Function(RemoveListenMessage) updates) =>
      super.copyWith((message) => updates(message as RemoveListenMessage))
          as RemoveListenMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveListenMessage create() => RemoveListenMessage._();
  @$core.override
  RemoveListenMessage createEmptyInstance() => create();
  static $pb.PbList<RemoveListenMessage> createRepeated() =>
      $pb.PbList<RemoveListenMessage>();
  @$core.pragma('dart2js:noInline')
  static RemoveListenMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveListenMessage>(create);
  static RemoveListenMessage? _defaultInstance;

  @$pb.TagNumber(1)
  RemoveListenMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(RemoveListenMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  RemoveListenMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  RemoveListenMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(RemoveListenMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  RemoveListenMessage_Response ensureResponse() => $_ensure(1);
}

class ListListenMessage_Request extends $pb.GeneratedMessage {
  factory ListListenMessage_Request({
    RequestInfo? requestInfo,
    $core.String? userId,
    $core.bool? includeEpisodes,
    QueryCursor? cursor,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (userId != null) result.userId = userId;
    if (includeEpisodes != null) result.includeEpisodes = includeEpisodes;
    if (cursor != null) result.cursor = cursor;
    return result;
  }

  ListListenMessage_Request._();

  factory ListListenMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListListenMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListListenMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOB(3, _omitFieldNames ? '' : 'includeEpisodes')
    ..aOM<QueryCursor>(4, _omitFieldNames ? '' : 'cursor',
        subBuilder: QueryCursor.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListListenMessage_Request clone() =>
      ListListenMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListListenMessage_Request copyWith(
          void Function(ListListenMessage_Request) updates) =>
      super.copyWith((message) => updates(message as ListListenMessage_Request))
          as ListListenMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListListenMessage_Request create() => ListListenMessage_Request._();
  @$core.override
  ListListenMessage_Request createEmptyInstance() => create();
  static $pb.PbList<ListListenMessage_Request> createRepeated() =>
      $pb.PbList<ListListenMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static ListListenMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListListenMessage_Request>(create);
  static ListListenMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  /// Return the episodes in the UserListenMessage
  @$pb.TagNumber(3)
  $core.bool get includeEpisodes => $_getBF(2);
  @$pb.TagNumber(3)
  set includeEpisodes($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIncludeEpisodes() => $_has(2);
  @$pb.TagNumber(3)
  void clearIncludeEpisodes() => $_clearField(3);

  @$pb.TagNumber(4)
  QueryCursor get cursor => $_getN(3);
  @$pb.TagNumber(4)
  set cursor(QueryCursor value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCursor() => $_has(3);
  @$pb.TagNumber(4)
  void clearCursor() => $_clearField(4);
  @$pb.TagNumber(4)
  QueryCursor ensureCursor() => $_ensure(3);
}

class ListListenMessage_Response extends $pb.GeneratedMessage {
  factory ListListenMessage_Response({
    ResponseInfo? responseInfo,
    $core.Iterable<$0.UserListenMessage>? listens,
    QueryCursor? cursor,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (listens != null) result.listens.addAll(listens);
    if (cursor != null) result.cursor = cursor;
    return result;
  }

  ListListenMessage_Response._();

  factory ListListenMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListListenMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListListenMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..pc<$0.UserListenMessage>(
        2, _omitFieldNames ? '' : 'listens', $pb.PbFieldType.PM,
        subBuilder: $0.UserListenMessage.create)
    ..aOM<QueryCursor>(5, _omitFieldNames ? '' : 'cursor',
        subBuilder: QueryCursor.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListListenMessage_Response clone() =>
      ListListenMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListListenMessage_Response copyWith(
          void Function(ListListenMessage_Response) updates) =>
      super.copyWith(
              (message) => updates(message as ListListenMessage_Response))
          as ListListenMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListListenMessage_Response create() => ListListenMessage_Response._();
  @$core.override
  ListListenMessage_Response createEmptyInstance() => create();
  static $pb.PbList<ListListenMessage_Response> createRepeated() =>
      $pb.PbList<ListListenMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static ListListenMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListListenMessage_Response>(create);
  static ListListenMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<$0.UserListenMessage> get listens => $_getList(1);

  @$pb.TagNumber(5)
  QueryCursor get cursor => $_getN(2);
  @$pb.TagNumber(5)
  set cursor(QueryCursor value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCursor() => $_has(2);
  @$pb.TagNumber(5)
  void clearCursor() => $_clearField(5);
  @$pb.TagNumber(5)
  QueryCursor ensureCursor() => $_ensure(2);
}

class ListListenMessage extends $pb.GeneratedMessage {
  factory ListListenMessage({
    ListListenMessage_Request? request,
    ListListenMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  ListListenMessage._();

  factory ListListenMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListListenMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListListenMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ListListenMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: ListListenMessage_Request.create)
    ..aOM<ListListenMessage_Response>(2, _omitFieldNames ? '' : 'response',
        subBuilder: ListListenMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListListenMessage clone() => ListListenMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListListenMessage copyWith(void Function(ListListenMessage) updates) =>
      super.copyWith((message) => updates(message as ListListenMessage))
          as ListListenMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListListenMessage create() => ListListenMessage._();
  @$core.override
  ListListenMessage createEmptyInstance() => create();
  static $pb.PbList<ListListenMessage> createRepeated() =>
      $pb.PbList<ListListenMessage>();
  @$core.pragma('dart2js:noInline')
  static ListListenMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListListenMessage>(create);
  static ListListenMessage? _defaultInstance;

  @$pb.TagNumber(1)
  ListListenMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(ListListenMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  ListListenMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  ListListenMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(ListListenMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  ListListenMessage_Response ensureResponse() => $_ensure(1);
}

class SyncListenMessage_Request extends $pb.GeneratedMessage {
  factory SyncListenMessage_Request({
    RequestInfo? requestInfo,
    $core.Iterable<$0.UserListenMessage>? listens,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (listens != null) result.listens.addAll(listens);
    return result;
  }

  SyncListenMessage_Request._();

  factory SyncListenMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SyncListenMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncListenMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..pc<$0.UserListenMessage>(
        2, _omitFieldNames ? '' : 'listens', $pb.PbFieldType.PM,
        subBuilder: $0.UserListenMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncListenMessage_Request clone() =>
      SyncListenMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncListenMessage_Request copyWith(
          void Function(SyncListenMessage_Request) updates) =>
      super.copyWith((message) => updates(message as SyncListenMessage_Request))
          as SyncListenMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncListenMessage_Request create() => SyncListenMessage_Request._();
  @$core.override
  SyncListenMessage_Request createEmptyInstance() => create();
  static $pb.PbList<SyncListenMessage_Request> createRepeated() =>
      $pb.PbList<SyncListenMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static SyncListenMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncListenMessage_Request>(create);
  static SyncListenMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<$0.UserListenMessage> get listens => $_getList(1);
}

class SyncListenMessage_Response extends $pb.GeneratedMessage {
  factory SyncListenMessage_Response({
    ResponseInfo? responseInfo,
    $core.Iterable<$0.UserListenMessage>? listens,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (listens != null) result.listens.addAll(listens);
    return result;
  }

  SyncListenMessage_Response._();

  factory SyncListenMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SyncListenMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncListenMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..pc<$0.UserListenMessage>(
        2, _omitFieldNames ? '' : 'listens', $pb.PbFieldType.PM,
        subBuilder: $0.UserListenMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncListenMessage_Response clone() =>
      SyncListenMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncListenMessage_Response copyWith(
          void Function(SyncListenMessage_Response) updates) =>
      super.copyWith(
              (message) => updates(message as SyncListenMessage_Response))
          as SyncListenMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncListenMessage_Response create() => SyncListenMessage_Response._();
  @$core.override
  SyncListenMessage_Response createEmptyInstance() => create();
  static $pb.PbList<SyncListenMessage_Response> createRepeated() =>
      $pb.PbList<SyncListenMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static SyncListenMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncListenMessage_Response>(create);
  static SyncListenMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<$0.UserListenMessage> get listens => $_getList(1);
}

class SyncListenMessage extends $pb.GeneratedMessage {
  factory SyncListenMessage({
    SyncListenMessage_Request? request,
    SyncListenMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  SyncListenMessage._();

  factory SyncListenMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SyncListenMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncListenMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<SyncListenMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: SyncListenMessage_Request.create)
    ..aOM<SyncListenMessage_Response>(2, _omitFieldNames ? '' : 'response',
        subBuilder: SyncListenMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncListenMessage clone() => SyncListenMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncListenMessage copyWith(void Function(SyncListenMessage) updates) =>
      super.copyWith((message) => updates(message as SyncListenMessage))
          as SyncListenMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncListenMessage create() => SyncListenMessage._();
  @$core.override
  SyncListenMessage createEmptyInstance() => create();
  static $pb.PbList<SyncListenMessage> createRepeated() =>
      $pb.PbList<SyncListenMessage>();
  @$core.pragma('dart2js:noInline')
  static SyncListenMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncListenMessage>(create);
  static SyncListenMessage? _defaultInstance;

  @$pb.TagNumber(1)
  SyncListenMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(SyncListenMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  SyncListenMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  SyncListenMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(SyncListenMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  SyncListenMessage_Response ensureResponse() => $_ensure(1);
}

class GetFeedMessage_Request extends $pb.GeneratedMessage {
  factory GetFeedMessage_Request({
    RequestInfo? requestInfo,
    $core.String? userId,
    $fixnum.Int64? beforeTimestampMs,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (userId != null) result.userId = userId;
    if (beforeTimestampMs != null) result.beforeTimestampMs = beforeTimestampMs;
    return result;
  }

  GetFeedMessage_Request._();

  factory GetFeedMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFeedMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFeedMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aInt64(3, _omitFieldNames ? '' : 'beforeTimestampMs')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFeedMessage_Request clone() =>
      GetFeedMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFeedMessage_Request copyWith(
          void Function(GetFeedMessage_Request) updates) =>
      super.copyWith((message) => updates(message as GetFeedMessage_Request))
          as GetFeedMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFeedMessage_Request create() => GetFeedMessage_Request._();
  @$core.override
  GetFeedMessage_Request createEmptyInstance() => create();
  static $pb.PbList<GetFeedMessage_Request> createRepeated() =>
      $pb.PbList<GetFeedMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static GetFeedMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFeedMessage_Request>(create);
  static GetFeedMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  /// Used for requesting the n+1 page of feed items
  @$pb.TagNumber(3)
  $fixnum.Int64 get beforeTimestampMs => $_getI64(2);
  @$pb.TagNumber(3)
  set beforeTimestampMs($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBeforeTimestampMs() => $_has(2);
  @$pb.TagNumber(3)
  void clearBeforeTimestampMs() => $_clearField(3);
}

class GetFeedMessage_Response extends $pb.GeneratedMessage {
  factory GetFeedMessage_Response({
    ResponseInfo? responseInfo,
    $0.UserFeedMessage? feed,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (feed != null) result.feed = feed;
    return result;
  }

  GetFeedMessage_Response._();

  factory GetFeedMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFeedMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFeedMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..aOM<$0.UserFeedMessage>(2, _omitFieldNames ? '' : 'feed',
        subBuilder: $0.UserFeedMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFeedMessage_Response clone() =>
      GetFeedMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFeedMessage_Response copyWith(
          void Function(GetFeedMessage_Response) updates) =>
      super.copyWith((message) => updates(message as GetFeedMessage_Response))
          as GetFeedMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFeedMessage_Response create() => GetFeedMessage_Response._();
  @$core.override
  GetFeedMessage_Response createEmptyInstance() => create();
  static $pb.PbList<GetFeedMessage_Response> createRepeated() =>
      $pb.PbList<GetFeedMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static GetFeedMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFeedMessage_Response>(create);
  static GetFeedMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserFeedMessage get feed => $_getN(1);
  @$pb.TagNumber(2)
  set feed($0.UserFeedMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasFeed() => $_has(1);
  @$pb.TagNumber(2)
  void clearFeed() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UserFeedMessage ensureFeed() => $_ensure(1);
}

class GetFeedMessage extends $pb.GeneratedMessage {
  factory GetFeedMessage({
    GetFeedMessage_Request? request,
    GetFeedMessage_Response? reponse,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (reponse != null) result.reponse = reponse;
    return result;
  }

  GetFeedMessage._();

  factory GetFeedMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFeedMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFeedMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<GetFeedMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: GetFeedMessage_Request.create)
    ..aOM<GetFeedMessage_Response>(2, _omitFieldNames ? '' : 'reponse',
        subBuilder: GetFeedMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFeedMessage clone() => GetFeedMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFeedMessage copyWith(void Function(GetFeedMessage) updates) =>
      super.copyWith((message) => updates(message as GetFeedMessage))
          as GetFeedMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFeedMessage create() => GetFeedMessage._();
  @$core.override
  GetFeedMessage createEmptyInstance() => create();
  static $pb.PbList<GetFeedMessage> createRepeated() =>
      $pb.PbList<GetFeedMessage>();
  @$core.pragma('dart2js:noInline')
  static GetFeedMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFeedMessage>(create);
  static GetFeedMessage? _defaultInstance;

  @$pb.TagNumber(1)
  GetFeedMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(GetFeedMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  GetFeedMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  GetFeedMessage_Response get reponse => $_getN(1);
  @$pb.TagNumber(2)
  set reponse(GetFeedMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasReponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearReponse() => $_clearField(2);
  @$pb.TagNumber(2)
  GetFeedMessage_Response ensureReponse() => $_ensure(1);
}

class AddFollowMessage_Request extends $pb.GeneratedMessage {
  factory AddFollowMessage_Request({
    RequestInfo? requestInfo,
    $0.UserFollowMessage? follow,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (follow != null) result.follow = follow;
    return result;
  }

  AddFollowMessage_Request._();

  factory AddFollowMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddFollowMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddFollowMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..aOM<$0.UserFollowMessage>(2, _omitFieldNames ? '' : 'follow',
        subBuilder: $0.UserFollowMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddFollowMessage_Request clone() =>
      AddFollowMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddFollowMessage_Request copyWith(
          void Function(AddFollowMessage_Request) updates) =>
      super.copyWith((message) => updates(message as AddFollowMessage_Request))
          as AddFollowMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddFollowMessage_Request create() => AddFollowMessage_Request._();
  @$core.override
  AddFollowMessage_Request createEmptyInstance() => create();
  static $pb.PbList<AddFollowMessage_Request> createRepeated() =>
      $pb.PbList<AddFollowMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static AddFollowMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddFollowMessage_Request>(create);
  static AddFollowMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserFollowMessage get follow => $_getN(1);
  @$pb.TagNumber(2)
  set follow($0.UserFollowMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasFollow() => $_has(1);
  @$pb.TagNumber(2)
  void clearFollow() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UserFollowMessage ensureFollow() => $_ensure(1);
}

class AddFollowMessage_Response extends $pb.GeneratedMessage {
  factory AddFollowMessage_Response({
    ResponseInfo? responseInfo,
    $0.UserFollowMessage? follow,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (follow != null) result.follow = follow;
    return result;
  }

  AddFollowMessage_Response._();

  factory AddFollowMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddFollowMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddFollowMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..aOM<$0.UserFollowMessage>(2, _omitFieldNames ? '' : 'follow',
        subBuilder: $0.UserFollowMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddFollowMessage_Response clone() =>
      AddFollowMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddFollowMessage_Response copyWith(
          void Function(AddFollowMessage_Response) updates) =>
      super.copyWith((message) => updates(message as AddFollowMessage_Response))
          as AddFollowMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddFollowMessage_Response create() => AddFollowMessage_Response._();
  @$core.override
  AddFollowMessage_Response createEmptyInstance() => create();
  static $pb.PbList<AddFollowMessage_Response> createRepeated() =>
      $pb.PbList<AddFollowMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static AddFollowMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddFollowMessage_Response>(create);
  static AddFollowMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserFollowMessage get follow => $_getN(1);
  @$pb.TagNumber(2)
  set follow($0.UserFollowMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasFollow() => $_has(1);
  @$pb.TagNumber(2)
  void clearFollow() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UserFollowMessage ensureFollow() => $_ensure(1);
}

class AddFollowMessage extends $pb.GeneratedMessage {
  factory AddFollowMessage({
    AddFollowMessage_Request? request,
    AddFollowMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  AddFollowMessage._();

  factory AddFollowMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddFollowMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddFollowMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<AddFollowMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: AddFollowMessage_Request.create)
    ..aOM<AddFollowMessage_Response>(2, _omitFieldNames ? '' : 'response',
        subBuilder: AddFollowMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddFollowMessage clone() => AddFollowMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddFollowMessage copyWith(void Function(AddFollowMessage) updates) =>
      super.copyWith((message) => updates(message as AddFollowMessage))
          as AddFollowMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddFollowMessage create() => AddFollowMessage._();
  @$core.override
  AddFollowMessage createEmptyInstance() => create();
  static $pb.PbList<AddFollowMessage> createRepeated() =>
      $pb.PbList<AddFollowMessage>();
  @$core.pragma('dart2js:noInline')
  static AddFollowMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddFollowMessage>(create);
  static AddFollowMessage? _defaultInstance;

  @$pb.TagNumber(1)
  AddFollowMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(AddFollowMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  AddFollowMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  AddFollowMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(AddFollowMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  AddFollowMessage_Response ensureResponse() => $_ensure(1);
}

class RemoveFollowMessage_Request extends $pb.GeneratedMessage {
  factory RemoveFollowMessage_Request({
    RequestInfo? requestInfo,
    $0.UserFollowMessage? follow,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (follow != null) result.follow = follow;
    return result;
  }

  RemoveFollowMessage_Request._();

  factory RemoveFollowMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveFollowMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveFollowMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..aOM<$0.UserFollowMessage>(2, _omitFieldNames ? '' : 'follow',
        subBuilder: $0.UserFollowMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveFollowMessage_Request clone() =>
      RemoveFollowMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveFollowMessage_Request copyWith(
          void Function(RemoveFollowMessage_Request) updates) =>
      super.copyWith(
              (message) => updates(message as RemoveFollowMessage_Request))
          as RemoveFollowMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveFollowMessage_Request create() =>
      RemoveFollowMessage_Request._();
  @$core.override
  RemoveFollowMessage_Request createEmptyInstance() => create();
  static $pb.PbList<RemoveFollowMessage_Request> createRepeated() =>
      $pb.PbList<RemoveFollowMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static RemoveFollowMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveFollowMessage_Request>(create);
  static RemoveFollowMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserFollowMessage get follow => $_getN(1);
  @$pb.TagNumber(2)
  set follow($0.UserFollowMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasFollow() => $_has(1);
  @$pb.TagNumber(2)
  void clearFollow() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UserFollowMessage ensureFollow() => $_ensure(1);
}

class RemoveFollowMessage_Response extends $pb.GeneratedMessage {
  factory RemoveFollowMessage_Response({
    ResponseInfo? responseInfo,
    $0.UserFollowMessage? follow,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (follow != null) result.follow = follow;
    return result;
  }

  RemoveFollowMessage_Response._();

  factory RemoveFollowMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveFollowMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveFollowMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..aOM<$0.UserFollowMessage>(2, _omitFieldNames ? '' : 'follow',
        subBuilder: $0.UserFollowMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveFollowMessage_Response clone() =>
      RemoveFollowMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveFollowMessage_Response copyWith(
          void Function(RemoveFollowMessage_Response) updates) =>
      super.copyWith(
              (message) => updates(message as RemoveFollowMessage_Response))
          as RemoveFollowMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveFollowMessage_Response create() =>
      RemoveFollowMessage_Response._();
  @$core.override
  RemoveFollowMessage_Response createEmptyInstance() => create();
  static $pb.PbList<RemoveFollowMessage_Response> createRepeated() =>
      $pb.PbList<RemoveFollowMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static RemoveFollowMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveFollowMessage_Response>(create);
  static RemoveFollowMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserFollowMessage get follow => $_getN(1);
  @$pb.TagNumber(2)
  set follow($0.UserFollowMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasFollow() => $_has(1);
  @$pb.TagNumber(2)
  void clearFollow() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UserFollowMessage ensureFollow() => $_ensure(1);
}

class RemoveFollowMessage extends $pb.GeneratedMessage {
  factory RemoveFollowMessage({
    RemoveFollowMessage_Request? request,
    RemoveFollowMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  RemoveFollowMessage._();

  factory RemoveFollowMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveFollowMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveFollowMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RemoveFollowMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: RemoveFollowMessage_Request.create)
    ..aOM<RemoveFollowMessage_Response>(2, _omitFieldNames ? '' : 'response',
        subBuilder: RemoveFollowMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveFollowMessage clone() => RemoveFollowMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveFollowMessage copyWith(void Function(RemoveFollowMessage) updates) =>
      super.copyWith((message) => updates(message as RemoveFollowMessage))
          as RemoveFollowMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveFollowMessage create() => RemoveFollowMessage._();
  @$core.override
  RemoveFollowMessage createEmptyInstance() => create();
  static $pb.PbList<RemoveFollowMessage> createRepeated() =>
      $pb.PbList<RemoveFollowMessage>();
  @$core.pragma('dart2js:noInline')
  static RemoveFollowMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveFollowMessage>(create);
  static RemoveFollowMessage? _defaultInstance;

  @$pb.TagNumber(1)
  RemoveFollowMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(RemoveFollowMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  RemoveFollowMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  RemoveFollowMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(RemoveFollowMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  RemoveFollowMessage_Response ensureResponse() => $_ensure(1);
}

class ListFollowMessage_Request extends $pb.GeneratedMessage {
  factory ListFollowMessage_Request({
    RequestInfo? requestInfo,
    $core.String? userId,
    QueryCursor? cursor,
    $core.bool? includeUsers,
    $core.bool? isFollowed,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (userId != null) result.userId = userId;
    if (cursor != null) result.cursor = cursor;
    if (includeUsers != null) result.includeUsers = includeUsers;
    if (isFollowed != null) result.isFollowed = isFollowed;
    return result;
  }

  ListFollowMessage_Request._();

  factory ListFollowMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListFollowMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListFollowMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOM<QueryCursor>(3, _omitFieldNames ? '' : 'cursor',
        subBuilder: QueryCursor.create)
    ..aOB(4, _omitFieldNames ? '' : 'includeUsers')
    ..aOB(5, _omitFieldNames ? '' : 'isFollowed')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListFollowMessage_Request clone() =>
      ListFollowMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListFollowMessage_Request copyWith(
          void Function(ListFollowMessage_Request) updates) =>
      super.copyWith((message) => updates(message as ListFollowMessage_Request))
          as ListFollowMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListFollowMessage_Request create() => ListFollowMessage_Request._();
  @$core.override
  ListFollowMessage_Request createEmptyInstance() => create();
  static $pb.PbList<ListFollowMessage_Request> createRepeated() =>
      $pb.PbList<ListFollowMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static ListFollowMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListFollowMessage_Request>(create);
  static ListFollowMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  QueryCursor get cursor => $_getN(2);
  @$pb.TagNumber(3)
  set cursor(QueryCursor value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCursor() => $_has(2);
  @$pb.TagNumber(3)
  void clearCursor() => $_clearField(3);
  @$pb.TagNumber(3)
  QueryCursor ensureCursor() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.bool get includeUsers => $_getBF(3);
  @$pb.TagNumber(4)
  set includeUsers($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIncludeUsers() => $_has(3);
  @$pb.TagNumber(4)
  void clearIncludeUsers() => $_clearField(4);

  /// Whether or not to return following or followed users
  @$pb.TagNumber(5)
  $core.bool get isFollowed => $_getBF(4);
  @$pb.TagNumber(5)
  set isFollowed($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsFollowed() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsFollowed() => $_clearField(5);
}

class ListFollowMessage_Response extends $pb.GeneratedMessage {
  factory ListFollowMessage_Response({
    ResponseInfo? responseInfo,
    $core.Iterable<$0.UserFollowMessage>? follows,
    QueryCursor? cursor,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (follows != null) result.follows.addAll(follows);
    if (cursor != null) result.cursor = cursor;
    return result;
  }

  ListFollowMessage_Response._();

  factory ListFollowMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListFollowMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListFollowMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..pc<$0.UserFollowMessage>(
        2, _omitFieldNames ? '' : 'follows', $pb.PbFieldType.PM,
        subBuilder: $0.UserFollowMessage.create)
    ..aOM<QueryCursor>(3, _omitFieldNames ? '' : 'cursor',
        subBuilder: QueryCursor.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListFollowMessage_Response clone() =>
      ListFollowMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListFollowMessage_Response copyWith(
          void Function(ListFollowMessage_Response) updates) =>
      super.copyWith(
              (message) => updates(message as ListFollowMessage_Response))
          as ListFollowMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListFollowMessage_Response create() => ListFollowMessage_Response._();
  @$core.override
  ListFollowMessage_Response createEmptyInstance() => create();
  static $pb.PbList<ListFollowMessage_Response> createRepeated() =>
      $pb.PbList<ListFollowMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static ListFollowMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListFollowMessage_Response>(create);
  static ListFollowMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<$0.UserFollowMessage> get follows => $_getList(1);

  @$pb.TagNumber(3)
  QueryCursor get cursor => $_getN(2);
  @$pb.TagNumber(3)
  set cursor(QueryCursor value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCursor() => $_has(2);
  @$pb.TagNumber(3)
  void clearCursor() => $_clearField(3);
  @$pb.TagNumber(3)
  QueryCursor ensureCursor() => $_ensure(2);
}

class ListFollowMessage extends $pb.GeneratedMessage {
  factory ListFollowMessage({
    ListFollowMessage_Request? request,
    ListFollowMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  ListFollowMessage._();

  factory ListFollowMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListFollowMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListFollowMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ListFollowMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: ListFollowMessage_Request.create)
    ..aOM<ListFollowMessage_Response>(2, _omitFieldNames ? '' : 'response',
        subBuilder: ListFollowMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListFollowMessage clone() => ListFollowMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListFollowMessage copyWith(void Function(ListFollowMessage) updates) =>
      super.copyWith((message) => updates(message as ListFollowMessage))
          as ListFollowMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListFollowMessage create() => ListFollowMessage._();
  @$core.override
  ListFollowMessage createEmptyInstance() => create();
  static $pb.PbList<ListFollowMessage> createRepeated() =>
      $pb.PbList<ListFollowMessage>();
  @$core.pragma('dart2js:noInline')
  static ListFollowMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListFollowMessage>(create);
  static ListFollowMessage? _defaultInstance;

  @$pb.TagNumber(1)
  ListFollowMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(ListFollowMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  ListFollowMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  ListFollowMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(ListFollowMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  ListFollowMessage_Response ensureResponse() => $_ensure(1);
}

class GetPublicUserMessage_Request extends $pb.GeneratedMessage {
  factory GetPublicUserMessage_Request({
    RequestInfo? requestInfo,
    $core.String? userId,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (userId != null) result.userId = userId;
    return result;
  }

  GetPublicUserMessage_Request._();

  factory GetPublicUserMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPublicUserMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPublicUserMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPublicUserMessage_Request clone() =>
      GetPublicUserMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPublicUserMessage_Request copyWith(
          void Function(GetPublicUserMessage_Request) updates) =>
      super.copyWith(
              (message) => updates(message as GetPublicUserMessage_Request))
          as GetPublicUserMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPublicUserMessage_Request create() =>
      GetPublicUserMessage_Request._();
  @$core.override
  GetPublicUserMessage_Request createEmptyInstance() => create();
  static $pb.PbList<GetPublicUserMessage_Request> createRepeated() =>
      $pb.PbList<GetPublicUserMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static GetPublicUserMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPublicUserMessage_Request>(create);
  static GetPublicUserMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);
}

class GetPublicUserMessage_Response extends $pb.GeneratedMessage {
  factory GetPublicUserMessage_Response({
    ResponseInfo? responseInfo,
    $0.PublicUserMessage? user,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (user != null) result.user = user;
    return result;
  }

  GetPublicUserMessage_Response._();

  factory GetPublicUserMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPublicUserMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPublicUserMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..aOM<$0.PublicUserMessage>(2, _omitFieldNames ? '' : 'user',
        subBuilder: $0.PublicUserMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPublicUserMessage_Response clone() =>
      GetPublicUserMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPublicUserMessage_Response copyWith(
          void Function(GetPublicUserMessage_Response) updates) =>
      super.copyWith(
              (message) => updates(message as GetPublicUserMessage_Response))
          as GetPublicUserMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPublicUserMessage_Response create() =>
      GetPublicUserMessage_Response._();
  @$core.override
  GetPublicUserMessage_Response createEmptyInstance() => create();
  static $pb.PbList<GetPublicUserMessage_Response> createRepeated() =>
      $pb.PbList<GetPublicUserMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static GetPublicUserMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPublicUserMessage_Response>(create);
  static GetPublicUserMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.PublicUserMessage get user => $_getN(1);
  @$pb.TagNumber(2)
  set user($0.PublicUserMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearUser() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.PublicUserMessage ensureUser() => $_ensure(1);
}

class GetPublicUserMessage extends $pb.GeneratedMessage {
  factory GetPublicUserMessage({
    GetPublicUserMessage_Request? request,
    GetPublicUserMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  GetPublicUserMessage._();

  factory GetPublicUserMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPublicUserMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPublicUserMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<GetPublicUserMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: GetPublicUserMessage_Request.create)
    ..aOM<GetPublicUserMessage_Response>(2, _omitFieldNames ? '' : 'response',
        subBuilder: GetPublicUserMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPublicUserMessage clone() =>
      GetPublicUserMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPublicUserMessage copyWith(void Function(GetPublicUserMessage) updates) =>
      super.copyWith((message) => updates(message as GetPublicUserMessage))
          as GetPublicUserMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPublicUserMessage create() => GetPublicUserMessage._();
  @$core.override
  GetPublicUserMessage createEmptyInstance() => create();
  static $pb.PbList<GetPublicUserMessage> createRepeated() =>
      $pb.PbList<GetPublicUserMessage>();
  @$core.pragma('dart2js:noInline')
  static GetPublicUserMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPublicUserMessage>(create);
  static GetPublicUserMessage? _defaultInstance;

  @$pb.TagNumber(1)
  GetPublicUserMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(GetPublicUserMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  GetPublicUserMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  GetPublicUserMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(GetPublicUserMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  GetPublicUserMessage_Response ensureResponse() => $_ensure(1);
}

class EditUserMessage_Request extends $pb.GeneratedMessage {
  factory EditUserMessage_Request({
    RequestInfo? requestInfo,
    $0.UserMessage? user,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (user != null) result.user = user;
    return result;
  }

  EditUserMessage_Request._();

  factory EditUserMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EditUserMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EditUserMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..aOM<$0.UserMessage>(2, _omitFieldNames ? '' : 'user',
        subBuilder: $0.UserMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EditUserMessage_Request clone() =>
      EditUserMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EditUserMessage_Request copyWith(
          void Function(EditUserMessage_Request) updates) =>
      super.copyWith((message) => updates(message as EditUserMessage_Request))
          as EditUserMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EditUserMessage_Request create() => EditUserMessage_Request._();
  @$core.override
  EditUserMessage_Request createEmptyInstance() => create();
  static $pb.PbList<EditUserMessage_Request> createRepeated() =>
      $pb.PbList<EditUserMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static EditUserMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EditUserMessage_Request>(create);
  static EditUserMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserMessage get user => $_getN(1);
  @$pb.TagNumber(2)
  set user($0.UserMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearUser() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UserMessage ensureUser() => $_ensure(1);
}

class EditUserMessage_Response extends $pb.GeneratedMessage {
  factory EditUserMessage_Response({
    ResponseInfo? responseInfo,
    $0.UserMessage? user,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (user != null) result.user = user;
    return result;
  }

  EditUserMessage_Response._();

  factory EditUserMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EditUserMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EditUserMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..aOM<$0.UserMessage>(2, _omitFieldNames ? '' : 'user',
        subBuilder: $0.UserMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EditUserMessage_Response clone() =>
      EditUserMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EditUserMessage_Response copyWith(
          void Function(EditUserMessage_Response) updates) =>
      super.copyWith((message) => updates(message as EditUserMessage_Response))
          as EditUserMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EditUserMessage_Response create() => EditUserMessage_Response._();
  @$core.override
  EditUserMessage_Response createEmptyInstance() => create();
  static $pb.PbList<EditUserMessage_Response> createRepeated() =>
      $pb.PbList<EditUserMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static EditUserMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EditUserMessage_Response>(create);
  static EditUserMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserMessage get user => $_getN(1);
  @$pb.TagNumber(2)
  set user($0.UserMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearUser() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UserMessage ensureUser() => $_ensure(1);
}

class EditUserMessage extends $pb.GeneratedMessage {
  factory EditUserMessage({
    EditUserMessage_Request? request,
    EditUserMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  EditUserMessage._();

  factory EditUserMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EditUserMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EditUserMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<EditUserMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: EditUserMessage_Request.create)
    ..aOM<EditUserMessage_Response>(2, _omitFieldNames ? '' : 'response',
        subBuilder: EditUserMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EditUserMessage clone() => EditUserMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EditUserMessage copyWith(void Function(EditUserMessage) updates) =>
      super.copyWith((message) => updates(message as EditUserMessage))
          as EditUserMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EditUserMessage create() => EditUserMessage._();
  @$core.override
  EditUserMessage createEmptyInstance() => create();
  static $pb.PbList<EditUserMessage> createRepeated() =>
      $pb.PbList<EditUserMessage>();
  @$core.pragma('dart2js:noInline')
  static EditUserMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EditUserMessage>(create);
  static EditUserMessage? _defaultInstance;

  @$pb.TagNumber(1)
  EditUserMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(EditUserMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  EditUserMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  EditUserMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(EditUserMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  EditUserMessage_Response ensureResponse() => $_ensure(1);
}

class RemoveUserMessage_Request extends $pb.GeneratedMessage {
  factory RemoveUserMessage_Request({
    RequestInfo? requestInfo,
    $core.String? userId,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (userId != null) result.userId = userId;
    return result;
  }

  RemoveUserMessage_Request._();

  factory RemoveUserMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveUserMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveUserMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveUserMessage_Request clone() =>
      RemoveUserMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveUserMessage_Request copyWith(
          void Function(RemoveUserMessage_Request) updates) =>
      super.copyWith((message) => updates(message as RemoveUserMessage_Request))
          as RemoveUserMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveUserMessage_Request create() => RemoveUserMessage_Request._();
  @$core.override
  RemoveUserMessage_Request createEmptyInstance() => create();
  static $pb.PbList<RemoveUserMessage_Request> createRepeated() =>
      $pb.PbList<RemoveUserMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static RemoveUserMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveUserMessage_Request>(create);
  static RemoveUserMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);
}

class RemoveUserMessage_Response extends $pb.GeneratedMessage {
  factory RemoveUserMessage_Response({
    ResponseInfo? responseInfo,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    return result;
  }

  RemoveUserMessage_Response._();

  factory RemoveUserMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveUserMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveUserMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveUserMessage_Response clone() =>
      RemoveUserMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveUserMessage_Response copyWith(
          void Function(RemoveUserMessage_Response) updates) =>
      super.copyWith(
              (message) => updates(message as RemoveUserMessage_Response))
          as RemoveUserMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveUserMessage_Response create() => RemoveUserMessage_Response._();
  @$core.override
  RemoveUserMessage_Response createEmptyInstance() => create();
  static $pb.PbList<RemoveUserMessage_Response> createRepeated() =>
      $pb.PbList<RemoveUserMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static RemoveUserMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveUserMessage_Response>(create);
  static RemoveUserMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);
}

class RemoveUserMessage extends $pb.GeneratedMessage {
  factory RemoveUserMessage({
    RemoveUserMessage_Request? request,
    RemoveUserMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  RemoveUserMessage._();

  factory RemoveUserMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveUserMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveUserMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RemoveUserMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: RemoveUserMessage_Request.create)
    ..aOM<RemoveUserMessage_Response>(2, _omitFieldNames ? '' : 'response',
        subBuilder: RemoveUserMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveUserMessage clone() => RemoveUserMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveUserMessage copyWith(void Function(RemoveUserMessage) updates) =>
      super.copyWith((message) => updates(message as RemoveUserMessage))
          as RemoveUserMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveUserMessage create() => RemoveUserMessage._();
  @$core.override
  RemoveUserMessage createEmptyInstance() => create();
  static $pb.PbList<RemoveUserMessage> createRepeated() =>
      $pb.PbList<RemoveUserMessage>();
  @$core.pragma('dart2js:noInline')
  static RemoveUserMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveUserMessage>(create);
  static RemoveUserMessage? _defaultInstance;

  @$pb.TagNumber(1)
  RemoveUserMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(RemoveUserMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  RemoveUserMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  RemoveUserMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(RemoveUserMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  RemoveUserMessage_Response ensureResponse() => $_ensure(1);
}

class ListUserMessage_Request extends $pb.GeneratedMessage {
  factory ListUserMessage_Request({
    RequestInfo? requestInfo,
    $core.Iterable<$core.String>? userIds,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (userIds != null) result.userIds.addAll(userIds);
    return result;
  }

  ListUserMessage_Request._();

  factory ListUserMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListUserMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListUserMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..pPS(2, _omitFieldNames ? '' : 'userIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUserMessage_Request clone() =>
      ListUserMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUserMessage_Request copyWith(
          void Function(ListUserMessage_Request) updates) =>
      super.copyWith((message) => updates(message as ListUserMessage_Request))
          as ListUserMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListUserMessage_Request create() => ListUserMessage_Request._();
  @$core.override
  ListUserMessage_Request createEmptyInstance() => create();
  static $pb.PbList<ListUserMessage_Request> createRepeated() =>
      $pb.PbList<ListUserMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static ListUserMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListUserMessage_Request>(create);
  static ListUserMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get userIds => $_getList(1);
}

class ListUserMessage_Response extends $pb.GeneratedMessage {
  factory ListUserMessage_Response({
    ResponseInfo? responseInfo,
    $core.Iterable<$0.PublicUserMessage>? users,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (users != null) result.users.addAll(users);
    return result;
  }

  ListUserMessage_Response._();

  factory ListUserMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListUserMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListUserMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..pc<$0.PublicUserMessage>(
        2, _omitFieldNames ? '' : 'users', $pb.PbFieldType.PM,
        subBuilder: $0.PublicUserMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUserMessage_Response clone() =>
      ListUserMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUserMessage_Response copyWith(
          void Function(ListUserMessage_Response) updates) =>
      super.copyWith((message) => updates(message as ListUserMessage_Response))
          as ListUserMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListUserMessage_Response create() => ListUserMessage_Response._();
  @$core.override
  ListUserMessage_Response createEmptyInstance() => create();
  static $pb.PbList<ListUserMessage_Response> createRepeated() =>
      $pb.PbList<ListUserMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static ListUserMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListUserMessage_Response>(create);
  static ListUserMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<$0.PublicUserMessage> get users => $_getList(1);
}

class ListUserMessage extends $pb.GeneratedMessage {
  factory ListUserMessage({
    ListUserMessage_Request? request,
    ListUserMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  ListUserMessage._();

  factory ListUserMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListUserMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListUserMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ListUserMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: ListUserMessage_Request.create)
    ..aOM<ListUserMessage_Response>(2, _omitFieldNames ? '' : 'response',
        subBuilder: ListUserMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUserMessage clone() => ListUserMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUserMessage copyWith(void Function(ListUserMessage) updates) =>
      super.copyWith((message) => updates(message as ListUserMessage))
          as ListUserMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListUserMessage create() => ListUserMessage._();
  @$core.override
  ListUserMessage createEmptyInstance() => create();
  static $pb.PbList<ListUserMessage> createRepeated() =>
      $pb.PbList<ListUserMessage>();
  @$core.pragma('dart2js:noInline')
  static ListUserMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListUserMessage>(create);
  static ListUserMessage? _defaultInstance;

  @$pb.TagNumber(1)
  ListUserMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(ListUserMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  ListUserMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  ListUserMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(ListUserMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  ListUserMessage_Response ensureResponse() => $_ensure(1);
}

class UploadImageMessage_Request extends $pb.GeneratedMessage {
  factory UploadImageMessage_Request({
    RequestInfo? requestInfo,
    $core.List<$core.int>? imageBytes,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (imageBytes != null) result.imageBytes = imageBytes;
    return result;
  }

  UploadImageMessage_Request._();

  factory UploadImageMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadImageMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadImageMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'imageBytes', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadImageMessage_Request clone() =>
      UploadImageMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadImageMessage_Request copyWith(
          void Function(UploadImageMessage_Request) updates) =>
      super.copyWith(
              (message) => updates(message as UploadImageMessage_Request))
          as UploadImageMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadImageMessage_Request create() => UploadImageMessage_Request._();
  @$core.override
  UploadImageMessage_Request createEmptyInstance() => create();
  static $pb.PbList<UploadImageMessage_Request> createRepeated() =>
      $pb.PbList<UploadImageMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static UploadImageMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadImageMessage_Request>(create);
  static UploadImageMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get imageBytes => $_getN(1);
  @$pb.TagNumber(2)
  set imageBytes($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasImageBytes() => $_has(1);
  @$pb.TagNumber(2)
  void clearImageBytes() => $_clearField(2);
}

class UploadImageMessage_Response extends $pb.GeneratedMessage {
  factory UploadImageMessage_Response({
    ResponseInfo? responseInfo,
    $core.String? imageUrl,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (imageUrl != null) result.imageUrl = imageUrl;
    return result;
  }

  UploadImageMessage_Response._();

  factory UploadImageMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadImageMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadImageMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'imageUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadImageMessage_Response clone() =>
      UploadImageMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadImageMessage_Response copyWith(
          void Function(UploadImageMessage_Response) updates) =>
      super.copyWith(
              (message) => updates(message as UploadImageMessage_Response))
          as UploadImageMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadImageMessage_Response create() =>
      UploadImageMessage_Response._();
  @$core.override
  UploadImageMessage_Response createEmptyInstance() => create();
  static $pb.PbList<UploadImageMessage_Response> createRepeated() =>
      $pb.PbList<UploadImageMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static UploadImageMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadImageMessage_Response>(create);
  static UploadImageMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get imageUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set imageUrl($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasImageUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearImageUrl() => $_clearField(2);
}

class UploadImageMessage extends $pb.GeneratedMessage {
  factory UploadImageMessage({
    UploadImageMessage_Request? request,
    UploadImageMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  UploadImageMessage._();

  factory UploadImageMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadImageMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadImageMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<UploadImageMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: UploadImageMessage_Request.create)
    ..aOM<UploadImageMessage_Response>(2, _omitFieldNames ? '' : 'response',
        subBuilder: UploadImageMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadImageMessage clone() => UploadImageMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadImageMessage copyWith(void Function(UploadImageMessage) updates) =>
      super.copyWith((message) => updates(message as UploadImageMessage))
          as UploadImageMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadImageMessage create() => UploadImageMessage._();
  @$core.override
  UploadImageMessage createEmptyInstance() => create();
  static $pb.PbList<UploadImageMessage> createRepeated() =>
      $pb.PbList<UploadImageMessage>();
  @$core.pragma('dart2js:noInline')
  static UploadImageMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadImageMessage>(create);
  static UploadImageMessage? _defaultInstance;

  @$pb.TagNumber(1)
  UploadImageMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(UploadImageMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  UploadImageMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  UploadImageMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(UploadImageMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  UploadImageMessage_Response ensureResponse() => $_ensure(1);
}

class FindContactsMessage_Request extends $pb.GeneratedMessage {
  factory FindContactsMessage_Request({
    RequestInfo? requestInfo,
    $core.Iterable<$core.String>? phoneNumbers,
    QueryCursor? cursor,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (phoneNumbers != null) result.phoneNumbers.addAll(phoneNumbers);
    if (cursor != null) result.cursor = cursor;
    return result;
  }

  FindContactsMessage_Request._();

  factory FindContactsMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FindContactsMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FindContactsMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..pPS(2, _omitFieldNames ? '' : 'phoneNumbers')
    ..aOM<QueryCursor>(3, _omitFieldNames ? '' : 'cursor',
        subBuilder: QueryCursor.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FindContactsMessage_Request clone() =>
      FindContactsMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FindContactsMessage_Request copyWith(
          void Function(FindContactsMessage_Request) updates) =>
      super.copyWith(
              (message) => updates(message as FindContactsMessage_Request))
          as FindContactsMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FindContactsMessage_Request create() =>
      FindContactsMessage_Request._();
  @$core.override
  FindContactsMessage_Request createEmptyInstance() => create();
  static $pb.PbList<FindContactsMessage_Request> createRepeated() =>
      $pb.PbList<FindContactsMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static FindContactsMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FindContactsMessage_Request>(create);
  static FindContactsMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get phoneNumbers => $_getList(1);

  @$pb.TagNumber(3)
  QueryCursor get cursor => $_getN(2);
  @$pb.TagNumber(3)
  set cursor(QueryCursor value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCursor() => $_has(2);
  @$pb.TagNumber(3)
  void clearCursor() => $_clearField(3);
  @$pb.TagNumber(3)
  QueryCursor ensureCursor() => $_ensure(2);
}

class FindContactsMessage_Response extends $pb.GeneratedMessage {
  factory FindContactsMessage_Response({
    ResponseInfo? responseInfo,
    $core.Iterable<$0.PublicUserMessage>? users,
    QueryCursor? cursor,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (users != null) result.users.addAll(users);
    if (cursor != null) result.cursor = cursor;
    return result;
  }

  FindContactsMessage_Response._();

  factory FindContactsMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FindContactsMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FindContactsMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..pc<$0.PublicUserMessage>(
        2, _omitFieldNames ? '' : 'users', $pb.PbFieldType.PM,
        subBuilder: $0.PublicUserMessage.create)
    ..aOM<QueryCursor>(3, _omitFieldNames ? '' : 'cursor',
        subBuilder: QueryCursor.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FindContactsMessage_Response clone() =>
      FindContactsMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FindContactsMessage_Response copyWith(
          void Function(FindContactsMessage_Response) updates) =>
      super.copyWith(
              (message) => updates(message as FindContactsMessage_Response))
          as FindContactsMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FindContactsMessage_Response create() =>
      FindContactsMessage_Response._();
  @$core.override
  FindContactsMessage_Response createEmptyInstance() => create();
  static $pb.PbList<FindContactsMessage_Response> createRepeated() =>
      $pb.PbList<FindContactsMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static FindContactsMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FindContactsMessage_Response>(create);
  static FindContactsMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<$0.PublicUserMessage> get users => $_getList(1);

  @$pb.TagNumber(3)
  QueryCursor get cursor => $_getN(2);
  @$pb.TagNumber(3)
  set cursor(QueryCursor value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCursor() => $_has(2);
  @$pb.TagNumber(3)
  void clearCursor() => $_clearField(3);
  @$pb.TagNumber(3)
  QueryCursor ensureCursor() => $_ensure(2);
}

class FindContactsMessage extends $pb.GeneratedMessage {
  factory FindContactsMessage({
    FindContactsMessage_Request? request,
    FindContactsMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  FindContactsMessage._();

  factory FindContactsMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FindContactsMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FindContactsMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<FindContactsMessage_Request>(1, _omitFieldNames ? '' : 'request',
        subBuilder: FindContactsMessage_Request.create)
    ..aOM<FindContactsMessage_Response>(2, _omitFieldNames ? '' : 'response',
        subBuilder: FindContactsMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FindContactsMessage clone() => FindContactsMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FindContactsMessage copyWith(void Function(FindContactsMessage) updates) =>
      super.copyWith((message) => updates(message as FindContactsMessage))
          as FindContactsMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FindContactsMessage create() => FindContactsMessage._();
  @$core.override
  FindContactsMessage createEmptyInstance() => create();
  static $pb.PbList<FindContactsMessage> createRepeated() =>
      $pb.PbList<FindContactsMessage>();
  @$core.pragma('dart2js:noInline')
  static FindContactsMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FindContactsMessage>(create);
  static FindContactsMessage? _defaultInstance;

  @$pb.TagNumber(1)
  FindContactsMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(FindContactsMessage_Request value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  FindContactsMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  FindContactsMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(FindContactsMessage_Response value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  FindContactsMessage_Response ensureResponse() => $_ensure(1);
}

class SearchContactsMessage_Request extends $pb.GeneratedMessage {
  factory SearchContactsMessage_Request({
    RequestInfo? requestInfo,
    QueryCursor? cursor,
    $core.String? query,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (cursor != null) result.cursor = cursor;
    if (query != null) result.query = query;
    return result;
  }

  SearchContactsMessage_Request._();

  factory SearchContactsMessage_Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchContactsMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchContactsMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..aOM<QueryCursor>(2, _omitFieldNames ? '' : 'cursor',
        subBuilder: QueryCursor.create)
    ..aOS(3, _omitFieldNames ? '' : 'query')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchContactsMessage_Request clone() =>
      SearchContactsMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchContactsMessage_Request copyWith(
          void Function(SearchContactsMessage_Request) updates) =>
      super.copyWith(
              (message) => updates(message as SearchContactsMessage_Request))
          as SearchContactsMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchContactsMessage_Request create() =>
      SearchContactsMessage_Request._();
  @$core.override
  SearchContactsMessage_Request createEmptyInstance() => create();
  static $pb.PbList<SearchContactsMessage_Request> createRepeated() =>
      $pb.PbList<SearchContactsMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static SearchContactsMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchContactsMessage_Request>(create);
  static SearchContactsMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  QueryCursor get cursor => $_getN(1);
  @$pb.TagNumber(2)
  set cursor(QueryCursor value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCursor() => $_has(1);
  @$pb.TagNumber(2)
  void clearCursor() => $_clearField(2);
  @$pb.TagNumber(2)
  QueryCursor ensureCursor() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get query => $_getSZ(2);
  @$pb.TagNumber(3)
  set query($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasQuery() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuery() => $_clearField(3);
}

class SearchContactsMessage_Response extends $pb.GeneratedMessage {
  factory SearchContactsMessage_Response({
    ResponseInfo? responseInfo,
    $core.Iterable<$0.PublicUserMessage>? users,
    QueryCursor? cursor,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (users != null) result.users.addAll(users);
    if (cursor != null) result.cursor = cursor;
    return result;
  }

  SearchContactsMessage_Response._();

  factory SearchContactsMessage_Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchContactsMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchContactsMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..pc<$0.PublicUserMessage>(
        2, _omitFieldNames ? '' : 'users', $pb.PbFieldType.PM,
        subBuilder: $0.PublicUserMessage.create)
    ..aOM<QueryCursor>(3, _omitFieldNames ? '' : 'cursor',
        subBuilder: QueryCursor.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchContactsMessage_Response clone() =>
      SearchContactsMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchContactsMessage_Response copyWith(
          void Function(SearchContactsMessage_Response) updates) =>
      super.copyWith(
              (message) => updates(message as SearchContactsMessage_Response))
          as SearchContactsMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchContactsMessage_Response create() =>
      SearchContactsMessage_Response._();
  @$core.override
  SearchContactsMessage_Response createEmptyInstance() => create();
  static $pb.PbList<SearchContactsMessage_Response> createRepeated() =>
      $pb.PbList<SearchContactsMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static SearchContactsMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchContactsMessage_Response>(create);
  static SearchContactsMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<$0.PublicUserMessage> get users => $_getList(1);

  @$pb.TagNumber(3)
  QueryCursor get cursor => $_getN(2);
  @$pb.TagNumber(3)
  set cursor(QueryCursor value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCursor() => $_has(2);
  @$pb.TagNumber(3)
  void clearCursor() => $_clearField(3);
  @$pb.TagNumber(3)
  QueryCursor ensureCursor() => $_ensure(2);
}

class SearchContactsMessage extends $pb.GeneratedMessage {
  factory SearchContactsMessage() => create();

  SearchContactsMessage._();

  factory SearchContactsMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchContactsMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchContactsMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchContactsMessage clone() =>
      SearchContactsMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchContactsMessage copyWith(
          void Function(SearchContactsMessage) updates) =>
      super.copyWith((message) => updates(message as SearchContactsMessage))
          as SearchContactsMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchContactsMessage create() => SearchContactsMessage._();
  @$core.override
  SearchContactsMessage createEmptyInstance() => create();
  static $pb.PbList<SearchContactsMessage> createRepeated() =>
      $pb.PbList<SearchContactsMessage>();
  @$core.pragma('dart2js:noInline')
  static SearchContactsMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchContactsMessage>(create);
  static SearchContactsMessage? _defaultInstance;
}

class SearchTopContactsMessage_Request extends $pb.GeneratedMessage {
  factory SearchTopContactsMessage_Request({
    RequestInfo? requestInfo,
    $core.Iterable<$0.UserContactMessage>? contacts,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (contacts != null) result.contacts.addAll(contacts);
    return result;
  }

  SearchTopContactsMessage_Request._();

  factory SearchTopContactsMessage_Request.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchTopContactsMessage_Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchTopContactsMessage.Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo',
        subBuilder: RequestInfo.create)
    ..pc<$0.UserContactMessage>(
        2, _omitFieldNames ? '' : 'contacts', $pb.PbFieldType.PM,
        subBuilder: $0.UserContactMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTopContactsMessage_Request clone() =>
      SearchTopContactsMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTopContactsMessage_Request copyWith(
          void Function(SearchTopContactsMessage_Request) updates) =>
      super.copyWith(
              (message) => updates(message as SearchTopContactsMessage_Request))
          as SearchTopContactsMessage_Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchTopContactsMessage_Request create() =>
      SearchTopContactsMessage_Request._();
  @$core.override
  SearchTopContactsMessage_Request createEmptyInstance() => create();
  static $pb.PbList<SearchTopContactsMessage_Request> createRepeated() =>
      $pb.PbList<SearchTopContactsMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static SearchTopContactsMessage_Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchTopContactsMessage_Request>(
          create);
  static SearchTopContactsMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<$0.UserContactMessage> get contacts => $_getList(1);
}

class SearchTopContactsMessage_Response extends $pb.GeneratedMessage {
  factory SearchTopContactsMessage_Response({
    ResponseInfo? responseInfo,
    $core.Iterable<$0.PublicUserMessage>? users,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (users != null) result.users.addAll(users);
    return result;
  }

  SearchTopContactsMessage_Response._();

  factory SearchTopContactsMessage_Response.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchTopContactsMessage_Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchTopContactsMessage.Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo',
        subBuilder: ResponseInfo.create)
    ..pc<$0.PublicUserMessage>(
        2, _omitFieldNames ? '' : 'users', $pb.PbFieldType.PM,
        subBuilder: $0.PublicUserMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTopContactsMessage_Response clone() =>
      SearchTopContactsMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTopContactsMessage_Response copyWith(
          void Function(SearchTopContactsMessage_Response) updates) =>
      super.copyWith((message) =>
              updates(message as SearchTopContactsMessage_Response))
          as SearchTopContactsMessage_Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchTopContactsMessage_Response create() =>
      SearchTopContactsMessage_Response._();
  @$core.override
  SearchTopContactsMessage_Response createEmptyInstance() => create();
  static $pb.PbList<SearchTopContactsMessage_Response> createRepeated() =>
      $pb.PbList<SearchTopContactsMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static SearchTopContactsMessage_Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchTopContactsMessage_Response>(
          create);
  static SearchTopContactsMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<$0.PublicUserMessage> get users => $_getList(1);
}

class SearchTopContactsMessage extends $pb.GeneratedMessage {
  factory SearchTopContactsMessage() => create();

  SearchTopContactsMessage._();

  factory SearchTopContactsMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchTopContactsMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchTopContactsMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTopContactsMessage clone() =>
      SearchTopContactsMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTopContactsMessage copyWith(
          void Function(SearchTopContactsMessage) updates) =>
      super.copyWith((message) => updates(message as SearchTopContactsMessage))
          as SearchTopContactsMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchTopContactsMessage create() => SearchTopContactsMessage._();
  @$core.override
  SearchTopContactsMessage createEmptyInstance() => create();
  static $pb.PbList<SearchTopContactsMessage> createRepeated() =>
      $pb.PbList<SearchTopContactsMessage>();
  @$core.pragma('dart2js:noInline')
  static SearchTopContactsMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchTopContactsMessage>(create);
  static SearchTopContactsMessage? _defaultInstance;
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
