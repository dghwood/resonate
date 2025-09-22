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

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class ResponseInfo extends $pb.GeneratedMessage {
  factory ResponseInfo({
    $core.bool? success,
    $core.String? errorMessage,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorMessage != null) result.errorMessage = errorMessage;
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
}

class RequestInfo extends $pb.GeneratedMessage {
  factory RequestInfo({
    $core.String? userId,
    $0.TokenMessage? accessToken,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (accessToken != null) result.accessToken = accessToken;
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
    ..aOM<$0.TokenMessage>(2, _omitFieldNames ? '' : 'accessToken',
        subBuilder: $0.TokenMessage.create)
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
  $0.TokenMessage get accessToken => $_getN(1);
  @$pb.TagNumber(2)
  set accessToken($0.TokenMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAccessToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccessToken() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.TokenMessage ensureAccessToken() => $_ensure(1);
}

class RefreshAuthMessage_Request extends $pb.GeneratedMessage {
  factory RefreshAuthMessage_Request({
    RequestInfo? requestInfo,
    $0.TokenMessage? refreshToken,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (refreshToken != null) result.refreshToken = refreshToken;
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
    ..aOM<$0.TokenMessage>(2, _omitFieldNames ? '' : 'refreshToken',
        subBuilder: $0.TokenMessage.create)
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

class RefreshAuthMessage_Response extends $pb.GeneratedMessage {
  factory RefreshAuthMessage_Response({
    ResponseInfo? responseInfo,
    $0.TokenMessage? accessToken,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (accessToken != null) result.accessToken = accessToken;
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
    ..aOM<$0.TokenMessage>(2, _omitFieldNames ? '' : 'accessToken',
        subBuilder: $0.TokenMessage.create)
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

  @$pb.TagNumber(2)
  $0.TokenMessage get accessToken => $_getN(1);
  @$pb.TagNumber(2)
  set accessToken($0.TokenMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAccessToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccessToken() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.TokenMessage ensureAccessToken() => $_ensure(1);
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
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (email != null) result.email = email;
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
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (email != null) result.email = email;
    if (password != null) result.password = password;
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
}

class LoginUserMessage_Response extends $pb.GeneratedMessage {
  factory LoginUserMessage_Response({
    ResponseInfo? responseInfo,
    $0.TokenMessage? accessToken,
    $0.TokenMessage? refreshToken,
    $0.UserMessage? user,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (accessToken != null) result.accessToken = accessToken;
    if (refreshToken != null) result.refreshToken = refreshToken;
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
    ..aOM<$0.TokenMessage>(2, _omitFieldNames ? '' : 'accessToken',
        subBuilder: $0.TokenMessage.create)
    ..aOM<$0.TokenMessage>(3, _omitFieldNames ? '' : 'refreshToken',
        subBuilder: $0.TokenMessage.create)
    ..aOM<$0.UserMessage>(4, _omitFieldNames ? '' : 'user',
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

  @$pb.TagNumber(2)
  $0.TokenMessage get accessToken => $_getN(1);
  @$pb.TagNumber(2)
  set accessToken($0.TokenMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAccessToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccessToken() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.TokenMessage ensureAccessToken() => $_ensure(1);

  @$pb.TagNumber(3)
  $0.TokenMessage get refreshToken => $_getN(2);
  @$pb.TagNumber(3)
  set refreshToken($0.TokenMessage value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRefreshToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearRefreshToken() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.TokenMessage ensureRefreshToken() => $_ensure(2);

  @$pb.TagNumber(4)
  $0.UserMessage get user => $_getN(3);
  @$pb.TagNumber(4)
  set user($0.UserMessage value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasUser() => $_has(3);
  @$pb.TagNumber(4)
  void clearUser() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.UserMessage ensureUser() => $_ensure(3);
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

class ListPodcastEpisodesMessage_Request extends $pb.GeneratedMessage {
  factory ListPodcastEpisodesMessage_Request({
    RequestInfo? requestInfo,
    $core.String? podcastId,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (podcastId != null) result.podcastId = podcastId;
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
}

class ListPodcastEpisodesMessage_Response extends $pb.GeneratedMessage {
  factory ListPodcastEpisodesMessage_Response({
    ResponseInfo? responseInfo,
    $core.Iterable<$0.EpisodeMessage>? episodes,
    $0.PodcastMessage? podcast,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (episodes != null) result.episodes.addAll(episodes);
    if (podcast != null) result.podcast = podcast;
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

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
