//
//  Generated code. Do not modify.
//  source: proto/api.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class ResponseInfo extends $pb.GeneratedMessage {
  factory ResponseInfo({
    $core.bool? success,
    $core.String? errorMessage,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (errorMessage != null) {
      $result.errorMessage = errorMessage;
    }
    return $result;
  }
  ResponseInfo._() : super();
  factory ResponseInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResponseInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResponseInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorMessage')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResponseInfo clone() => ResponseInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResponseInfo copyWith(void Function(ResponseInfo) updates) => super.copyWith((message) => updates(message as ResponseInfo)) as ResponseInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResponseInfo create() => ResponseInfo._();
  ResponseInfo createEmptyInstance() => create();
  static $pb.PbList<ResponseInfo> createRepeated() => $pb.PbList<ResponseInfo>();
  @$core.pragma('dart2js:noInline')
  static ResponseInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResponseInfo>(create);
  static ResponseInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorMessage => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorMessage($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorMessage() => $_clearField(2);
}

class RequestInfo extends $pb.GeneratedMessage {
  factory RequestInfo({
    $core.String? userId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    return $result;
  }
  RequestInfo._() : super();
  factory RequestInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RequestInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestInfo clone() => RequestInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestInfo copyWith(void Function(RequestInfo) updates) => super.copyWith((message) => updates(message as RequestInfo)) as RequestInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestInfo create() => RequestInfo._();
  RequestInfo createEmptyInstance() => create();
  static $pb.PbList<RequestInfo> createRepeated() => $pb.PbList<RequestInfo>();
  @$core.pragma('dart2js:noInline')
  static RequestInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestInfo>(create);
  static RequestInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class CreateUserMessage_Request extends $pb.GeneratedMessage {
  factory CreateUserMessage_Request({
    RequestInfo? requestInfo,
    $0.UserMessage? user,
  }) {
    final $result = create();
    if (requestInfo != null) {
      $result.requestInfo = requestInfo;
    }
    if (user != null) {
      $result.user = user;
    }
    return $result;
  }
  CreateUserMessage_Request._() : super();
  factory CreateUserMessage_Request.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUserMessage_Request.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateUserMessage.Request', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo', subBuilder: RequestInfo.create)
    ..aOM<$0.UserMessage>(2, _omitFieldNames ? '' : 'user', subBuilder: $0.UserMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUserMessage_Request clone() => CreateUserMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUserMessage_Request copyWith(void Function(CreateUserMessage_Request) updates) => super.copyWith((message) => updates(message as CreateUserMessage_Request)) as CreateUserMessage_Request;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateUserMessage_Request create() => CreateUserMessage_Request._();
  CreateUserMessage_Request createEmptyInstance() => create();
  static $pb.PbList<CreateUserMessage_Request> createRepeated() => $pb.PbList<CreateUserMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static CreateUserMessage_Request getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUserMessage_Request>(create);
  static CreateUserMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserMessage get user => $_getN(1);
  @$pb.TagNumber(2)
  set user($0.UserMessage v) { $_setField(2, v); }
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
    final $result = create();
    if (responseInfo != null) {
      $result.responseInfo = responseInfo;
    }
    if (user != null) {
      $result.user = user;
    }
    return $result;
  }
  CreateUserMessage_Response._() : super();
  factory CreateUserMessage_Response.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUserMessage_Response.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateUserMessage.Response', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo', subBuilder: ResponseInfo.create)
    ..aOM<$0.UserMessage>(2, _omitFieldNames ? '' : 'user', subBuilder: $0.UserMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUserMessage_Response clone() => CreateUserMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUserMessage_Response copyWith(void Function(CreateUserMessage_Response) updates) => super.copyWith((message) => updates(message as CreateUserMessage_Response)) as CreateUserMessage_Response;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateUserMessage_Response create() => CreateUserMessage_Response._();
  CreateUserMessage_Response createEmptyInstance() => create();
  static $pb.PbList<CreateUserMessage_Response> createRepeated() => $pb.PbList<CreateUserMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static CreateUserMessage_Response getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUserMessage_Response>(create);
  static CreateUserMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserMessage get user => $_getN(1);
  @$pb.TagNumber(2)
  set user($0.UserMessage v) { $_setField(2, v); }
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
    final $result = create();
    if (request != null) {
      $result.request = request;
    }
    if (response != null) {
      $result.response = response;
    }
    return $result;
  }
  CreateUserMessage._() : super();
  factory CreateUserMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUserMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateUserMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOM<CreateUserMessage_Request>(1, _omitFieldNames ? '' : 'request', subBuilder: CreateUserMessage_Request.create)
    ..aOM<CreateUserMessage_Response>(2, _omitFieldNames ? '' : 'response', subBuilder: CreateUserMessage_Response.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUserMessage clone() => CreateUserMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUserMessage copyWith(void Function(CreateUserMessage) updates) => super.copyWith((message) => updates(message as CreateUserMessage)) as CreateUserMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateUserMessage create() => CreateUserMessage._();
  CreateUserMessage createEmptyInstance() => create();
  static $pb.PbList<CreateUserMessage> createRepeated() => $pb.PbList<CreateUserMessage>();
  @$core.pragma('dart2js:noInline')
  static CreateUserMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUserMessage>(create);
  static CreateUserMessage? _defaultInstance;

  @$pb.TagNumber(1)
  CreateUserMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(CreateUserMessage_Request v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  CreateUserMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  CreateUserMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(CreateUserMessage_Response v) { $_setField(2, v); }
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
    final $result = create();
    if (requestInfo != null) {
      $result.requestInfo = requestInfo;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    return $result;
  }
  GetUserMessage_Request._() : super();
  factory GetUserMessage_Request.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserMessage_Request.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserMessage.Request', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo', subBuilder: RequestInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserMessage_Request clone() => GetUserMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserMessage_Request copyWith(void Function(GetUserMessage_Request) updates) => super.copyWith((message) => updates(message as GetUserMessage_Request)) as GetUserMessage_Request;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserMessage_Request create() => GetUserMessage_Request._();
  GetUserMessage_Request createEmptyInstance() => create();
  static $pb.PbList<GetUserMessage_Request> createRepeated() => $pb.PbList<GetUserMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static GetUserMessage_Request getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserMessage_Request>(create);
  static GetUserMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
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
    final $result = create();
    if (responseInfo != null) {
      $result.responseInfo = responseInfo;
    }
    if (user != null) {
      $result.user = user;
    }
    return $result;
  }
  GetUserMessage_Response._() : super();
  factory GetUserMessage_Response.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserMessage_Response.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserMessage.Response', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo', subBuilder: ResponseInfo.create)
    ..aOM<$0.UserMessage>(2, _omitFieldNames ? '' : 'user', subBuilder: $0.UserMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserMessage_Response clone() => GetUserMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserMessage_Response copyWith(void Function(GetUserMessage_Response) updates) => super.copyWith((message) => updates(message as GetUserMessage_Response)) as GetUserMessage_Response;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserMessage_Response create() => GetUserMessage_Response._();
  GetUserMessage_Response createEmptyInstance() => create();
  static $pb.PbList<GetUserMessage_Response> createRepeated() => $pb.PbList<GetUserMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static GetUserMessage_Response getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserMessage_Response>(create);
  static GetUserMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserMessage get user => $_getN(1);
  @$pb.TagNumber(2)
  set user($0.UserMessage v) { $_setField(2, v); }
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
    final $result = create();
    if (request != null) {
      $result.request = request;
    }
    if (response != null) {
      $result.response = response;
    }
    return $result;
  }
  GetUserMessage._() : super();
  factory GetUserMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOM<GetUserMessage_Request>(1, _omitFieldNames ? '' : 'request', subBuilder: GetUserMessage_Request.create)
    ..aOM<GetUserMessage_Response>(2, _omitFieldNames ? '' : 'response', subBuilder: GetUserMessage_Response.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserMessage clone() => GetUserMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserMessage copyWith(void Function(GetUserMessage) updates) => super.copyWith((message) => updates(message as GetUserMessage)) as GetUserMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserMessage create() => GetUserMessage._();
  GetUserMessage createEmptyInstance() => create();
  static $pb.PbList<GetUserMessage> createRepeated() => $pb.PbList<GetUserMessage>();
  @$core.pragma('dart2js:noInline')
  static GetUserMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserMessage>(create);
  static GetUserMessage? _defaultInstance;

  @$pb.TagNumber(1)
  GetUserMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(GetUserMessage_Request v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  GetUserMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  GetUserMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(GetUserMessage_Response v) { $_setField(2, v); }
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
    final $result = create();
    if (requestInfo != null) {
      $result.requestInfo = requestInfo;
    }
    if (user != null) {
      $result.user = user;
    }
    return $result;
  }
  UpdateUserMessage_Request._() : super();
  factory UpdateUserMessage_Request.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateUserMessage_Request.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateUserMessage.Request', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo', subBuilder: RequestInfo.create)
    ..aOM<$0.UserMessage>(2, _omitFieldNames ? '' : 'user', subBuilder: $0.UserMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateUserMessage_Request clone() => UpdateUserMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateUserMessage_Request copyWith(void Function(UpdateUserMessage_Request) updates) => super.copyWith((message) => updates(message as UpdateUserMessage_Request)) as UpdateUserMessage_Request;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateUserMessage_Request create() => UpdateUserMessage_Request._();
  UpdateUserMessage_Request createEmptyInstance() => create();
  static $pb.PbList<UpdateUserMessage_Request> createRepeated() => $pb.PbList<UpdateUserMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static UpdateUserMessage_Request getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateUserMessage_Request>(create);
  static UpdateUserMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserMessage get user => $_getN(1);
  @$pb.TagNumber(2)
  set user($0.UserMessage v) { $_setField(2, v); }
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
    final $result = create();
    if (responseInfo != null) {
      $result.responseInfo = responseInfo;
    }
    if (user != null) {
      $result.user = user;
    }
    return $result;
  }
  UpdateUserMessage_Response._() : super();
  factory UpdateUserMessage_Response.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateUserMessage_Response.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateUserMessage.Response', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo', subBuilder: ResponseInfo.create)
    ..aOM<$0.UserMessage>(2, _omitFieldNames ? '' : 'user', subBuilder: $0.UserMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateUserMessage_Response clone() => UpdateUserMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateUserMessage_Response copyWith(void Function(UpdateUserMessage_Response) updates) => super.copyWith((message) => updates(message as UpdateUserMessage_Response)) as UpdateUserMessage_Response;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateUserMessage_Response create() => UpdateUserMessage_Response._();
  UpdateUserMessage_Response createEmptyInstance() => create();
  static $pb.PbList<UpdateUserMessage_Response> createRepeated() => $pb.PbList<UpdateUserMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static UpdateUserMessage_Response getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateUserMessage_Response>(create);
  static UpdateUserMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserMessage get user => $_getN(1);
  @$pb.TagNumber(2)
  set user($0.UserMessage v) { $_setField(2, v); }
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
    final $result = create();
    if (request != null) {
      $result.request = request;
    }
    if (response != null) {
      $result.response = response;
    }
    return $result;
  }
  UpdateUserMessage._() : super();
  factory UpdateUserMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateUserMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateUserMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOM<UpdateUserMessage_Request>(1, _omitFieldNames ? '' : 'request', subBuilder: UpdateUserMessage_Request.create)
    ..aOM<UpdateUserMessage_Response>(2, _omitFieldNames ? '' : 'response', subBuilder: UpdateUserMessage_Response.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateUserMessage clone() => UpdateUserMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateUserMessage copyWith(void Function(UpdateUserMessage) updates) => super.copyWith((message) => updates(message as UpdateUserMessage)) as UpdateUserMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateUserMessage create() => UpdateUserMessage._();
  UpdateUserMessage createEmptyInstance() => create();
  static $pb.PbList<UpdateUserMessage> createRepeated() => $pb.PbList<UpdateUserMessage>();
  @$core.pragma('dart2js:noInline')
  static UpdateUserMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateUserMessage>(create);
  static UpdateUserMessage? _defaultInstance;

  @$pb.TagNumber(1)
  UpdateUserMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(UpdateUserMessage_Request v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  UpdateUserMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  UpdateUserMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(UpdateUserMessage_Response v) { $_setField(2, v); }
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
    final $result = create();
    if (requestInfo != null) {
      $result.requestInfo = requestInfo;
    }
    if (query != null) {
      $result.query = query;
    }
    return $result;
  }
  SearchMessage_Request._() : super();
  factory SearchMessage_Request.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchMessage_Request.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SearchMessage.Request', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo', subBuilder: RequestInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'query')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchMessage_Request clone() => SearchMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchMessage_Request copyWith(void Function(SearchMessage_Request) updates) => super.copyWith((message) => updates(message as SearchMessage_Request)) as SearchMessage_Request;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchMessage_Request create() => SearchMessage_Request._();
  SearchMessage_Request createEmptyInstance() => create();
  static $pb.PbList<SearchMessage_Request> createRepeated() => $pb.PbList<SearchMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static SearchMessage_Request getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchMessage_Request>(create);
  static SearchMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get query => $_getSZ(1);
  @$pb.TagNumber(2)
  set query($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuery() => $_clearField(2);
}

class SearchMessage_Response extends $pb.GeneratedMessage {
  factory SearchMessage_Response({
    ResponseInfo? responseInfo,
    $core.Iterable<$0.PodcastMessage>? podcasts,
    $core.Iterable<$0.UserMessage>? users,
    $core.Iterable<$0.EpisodeMessage>? episodes,
  }) {
    final $result = create();
    if (responseInfo != null) {
      $result.responseInfo = responseInfo;
    }
    if (podcasts != null) {
      $result.podcasts.addAll(podcasts);
    }
    if (users != null) {
      $result.users.addAll(users);
    }
    if (episodes != null) {
      $result.episodes.addAll(episodes);
    }
    return $result;
  }
  SearchMessage_Response._() : super();
  factory SearchMessage_Response.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchMessage_Response.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SearchMessage.Response', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo', subBuilder: ResponseInfo.create)
    ..pc<$0.PodcastMessage>(2, _omitFieldNames ? '' : 'podcasts', $pb.PbFieldType.PM, subBuilder: $0.PodcastMessage.create)
    ..pc<$0.UserMessage>(3, _omitFieldNames ? '' : 'users', $pb.PbFieldType.PM, subBuilder: $0.UserMessage.create)
    ..pc<$0.EpisodeMessage>(4, _omitFieldNames ? '' : 'episodes', $pb.PbFieldType.PM, subBuilder: $0.EpisodeMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchMessage_Response clone() => SearchMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchMessage_Response copyWith(void Function(SearchMessage_Response) updates) => super.copyWith((message) => updates(message as SearchMessage_Response)) as SearchMessage_Response;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchMessage_Response create() => SearchMessage_Response._();
  SearchMessage_Response createEmptyInstance() => create();
  static $pb.PbList<SearchMessage_Response> createRepeated() => $pb.PbList<SearchMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static SearchMessage_Response getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchMessage_Response>(create);
  static SearchMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<$0.PodcastMessage> get podcasts => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<$0.UserMessage> get users => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<$0.EpisodeMessage> get episodes => $_getList(3);
}

class SearchMessage extends $pb.GeneratedMessage {
  factory SearchMessage({
    SearchMessage_Request? request,
    SearchMessage_Response? response,
  }) {
    final $result = create();
    if (request != null) {
      $result.request = request;
    }
    if (response != null) {
      $result.response = response;
    }
    return $result;
  }
  SearchMessage._() : super();
  factory SearchMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SearchMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOM<SearchMessage_Request>(1, _omitFieldNames ? '' : 'request', subBuilder: SearchMessage_Request.create)
    ..aOM<SearchMessage_Response>(2, _omitFieldNames ? '' : 'response', subBuilder: SearchMessage_Response.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchMessage clone() => SearchMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchMessage copyWith(void Function(SearchMessage) updates) => super.copyWith((message) => updates(message as SearchMessage)) as SearchMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchMessage create() => SearchMessage._();
  SearchMessage createEmptyInstance() => create();
  static $pb.PbList<SearchMessage> createRepeated() => $pb.PbList<SearchMessage>();
  @$core.pragma('dart2js:noInline')
  static SearchMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchMessage>(create);
  static SearchMessage? _defaultInstance;

  @$pb.TagNumber(1)
  SearchMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(SearchMessage_Request v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  SearchMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  SearchMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(SearchMessage_Response v) { $_setField(2, v); }
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
    final $result = create();
    if (requestInfo != null) {
      $result.requestInfo = requestInfo;
    }
    if (podcastId != null) {
      $result.podcastId = podcastId;
    }
    return $result;
  }
  GetPodcastMessage_Request._() : super();
  factory GetPodcastMessage_Request.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPodcastMessage_Request.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPodcastMessage.Request', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo', subBuilder: RequestInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'podcastId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPodcastMessage_Request clone() => GetPodcastMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPodcastMessage_Request copyWith(void Function(GetPodcastMessage_Request) updates) => super.copyWith((message) => updates(message as GetPodcastMessage_Request)) as GetPodcastMessage_Request;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPodcastMessage_Request create() => GetPodcastMessage_Request._();
  GetPodcastMessage_Request createEmptyInstance() => create();
  static $pb.PbList<GetPodcastMessage_Request> createRepeated() => $pb.PbList<GetPodcastMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static GetPodcastMessage_Request getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPodcastMessage_Request>(create);
  static GetPodcastMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get podcastId => $_getSZ(1);
  @$pb.TagNumber(2)
  set podcastId($core.String v) { $_setString(1, v); }
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
    final $result = create();
    if (responseInfo != null) {
      $result.responseInfo = responseInfo;
    }
    if (podcast != null) {
      $result.podcast = podcast;
    }
    return $result;
  }
  GetPodcastMessage_Response._() : super();
  factory GetPodcastMessage_Response.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPodcastMessage_Response.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPodcastMessage.Response', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo', subBuilder: ResponseInfo.create)
    ..aOM<$0.PodcastMessage>(2, _omitFieldNames ? '' : 'podcast', subBuilder: $0.PodcastMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPodcastMessage_Response clone() => GetPodcastMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPodcastMessage_Response copyWith(void Function(GetPodcastMessage_Response) updates) => super.copyWith((message) => updates(message as GetPodcastMessage_Response)) as GetPodcastMessage_Response;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPodcastMessage_Response create() => GetPodcastMessage_Response._();
  GetPodcastMessage_Response createEmptyInstance() => create();
  static $pb.PbList<GetPodcastMessage_Response> createRepeated() => $pb.PbList<GetPodcastMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static GetPodcastMessage_Response getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPodcastMessage_Response>(create);
  static GetPodcastMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.PodcastMessage get podcast => $_getN(1);
  @$pb.TagNumber(2)
  set podcast($0.PodcastMessage v) { $_setField(2, v); }
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
    final $result = create();
    if (request != null) {
      $result.request = request;
    }
    if (response != null) {
      $result.response = response;
    }
    return $result;
  }
  GetPodcastMessage._() : super();
  factory GetPodcastMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPodcastMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPodcastMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOM<GetPodcastMessage_Request>(1, _omitFieldNames ? '' : 'request', subBuilder: GetPodcastMessage_Request.create)
    ..aOM<GetPodcastMessage_Response>(2, _omitFieldNames ? '' : 'response', subBuilder: GetPodcastMessage_Response.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPodcastMessage clone() => GetPodcastMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPodcastMessage copyWith(void Function(GetPodcastMessage) updates) => super.copyWith((message) => updates(message as GetPodcastMessage)) as GetPodcastMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPodcastMessage create() => GetPodcastMessage._();
  GetPodcastMessage createEmptyInstance() => create();
  static $pb.PbList<GetPodcastMessage> createRepeated() => $pb.PbList<GetPodcastMessage>();
  @$core.pragma('dart2js:noInline')
  static GetPodcastMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPodcastMessage>(create);
  static GetPodcastMessage? _defaultInstance;

  @$pb.TagNumber(1)
  GetPodcastMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(GetPodcastMessage_Request v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  GetPodcastMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  GetPodcastMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(GetPodcastMessage_Response v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  GetPodcastMessage_Response ensureResponse() => $_ensure(1);
}

class GetEpisodeMessage_Request extends $pb.GeneratedMessage {
  factory GetEpisodeMessage_Request({
    RequestInfo? requestInfo,
    $core.String? episodeId,
  }) {
    final $result = create();
    if (requestInfo != null) {
      $result.requestInfo = requestInfo;
    }
    if (episodeId != null) {
      $result.episodeId = episodeId;
    }
    return $result;
  }
  GetEpisodeMessage_Request._() : super();
  factory GetEpisodeMessage_Request.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetEpisodeMessage_Request.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetEpisodeMessage.Request', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo', subBuilder: RequestInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'episodeId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetEpisodeMessage_Request clone() => GetEpisodeMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetEpisodeMessage_Request copyWith(void Function(GetEpisodeMessage_Request) updates) => super.copyWith((message) => updates(message as GetEpisodeMessage_Request)) as GetEpisodeMessage_Request;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetEpisodeMessage_Request create() => GetEpisodeMessage_Request._();
  GetEpisodeMessage_Request createEmptyInstance() => create();
  static $pb.PbList<GetEpisodeMessage_Request> createRepeated() => $pb.PbList<GetEpisodeMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static GetEpisodeMessage_Request getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetEpisodeMessage_Request>(create);
  static GetEpisodeMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get episodeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set episodeId($core.String v) { $_setString(1, v); }
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
    final $result = create();
    if (responseInfo != null) {
      $result.responseInfo = responseInfo;
    }
    if (episode != null) {
      $result.episode = episode;
    }
    return $result;
  }
  GetEpisodeMessage_Response._() : super();
  factory GetEpisodeMessage_Response.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetEpisodeMessage_Response.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetEpisodeMessage.Response', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo', subBuilder: ResponseInfo.create)
    ..aOM<$0.EpisodeMessage>(2, _omitFieldNames ? '' : 'episode', subBuilder: $0.EpisodeMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetEpisodeMessage_Response clone() => GetEpisodeMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetEpisodeMessage_Response copyWith(void Function(GetEpisodeMessage_Response) updates) => super.copyWith((message) => updates(message as GetEpisodeMessage_Response)) as GetEpisodeMessage_Response;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetEpisodeMessage_Response create() => GetEpisodeMessage_Response._();
  GetEpisodeMessage_Response createEmptyInstance() => create();
  static $pb.PbList<GetEpisodeMessage_Response> createRepeated() => $pb.PbList<GetEpisodeMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static GetEpisodeMessage_Response getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetEpisodeMessage_Response>(create);
  static GetEpisodeMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.EpisodeMessage get episode => $_getN(1);
  @$pb.TagNumber(2)
  set episode($0.EpisodeMessage v) { $_setField(2, v); }
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
    final $result = create();
    if (request != null) {
      $result.request = request;
    }
    if (response != null) {
      $result.response = response;
    }
    return $result;
  }
  GetEpisodeMessage._() : super();
  factory GetEpisodeMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetEpisodeMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetEpisodeMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOM<GetEpisodeMessage_Request>(1, _omitFieldNames ? '' : 'request', subBuilder: GetEpisodeMessage_Request.create)
    ..aOM<GetEpisodeMessage_Response>(2, _omitFieldNames ? '' : 'response', subBuilder: GetEpisodeMessage_Response.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetEpisodeMessage clone() => GetEpisodeMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetEpisodeMessage copyWith(void Function(GetEpisodeMessage) updates) => super.copyWith((message) => updates(message as GetEpisodeMessage)) as GetEpisodeMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetEpisodeMessage create() => GetEpisodeMessage._();
  GetEpisodeMessage createEmptyInstance() => create();
  static $pb.PbList<GetEpisodeMessage> createRepeated() => $pb.PbList<GetEpisodeMessage>();
  @$core.pragma('dart2js:noInline')
  static GetEpisodeMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetEpisodeMessage>(create);
  static GetEpisodeMessage? _defaultInstance;

  @$pb.TagNumber(1)
  GetEpisodeMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(GetEpisodeMessage_Request v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  GetEpisodeMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  GetEpisodeMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(GetEpisodeMessage_Response v) { $_setField(2, v); }
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
    final $result = create();
    if (requestInfo != null) {
      $result.requestInfo = requestInfo;
    }
    if (subscription != null) {
      $result.subscription = subscription;
    }
    return $result;
  }
  AddSubscriptionMessage_Request._() : super();
  factory AddSubscriptionMessage_Request.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddSubscriptionMessage_Request.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddSubscriptionMessage.Request', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo', subBuilder: RequestInfo.create)
    ..aOM<$0.UserSubscriptionMessage>(2, _omitFieldNames ? '' : 'subscription', subBuilder: $0.UserSubscriptionMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddSubscriptionMessage_Request clone() => AddSubscriptionMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddSubscriptionMessage_Request copyWith(void Function(AddSubscriptionMessage_Request) updates) => super.copyWith((message) => updates(message as AddSubscriptionMessage_Request)) as AddSubscriptionMessage_Request;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddSubscriptionMessage_Request create() => AddSubscriptionMessage_Request._();
  AddSubscriptionMessage_Request createEmptyInstance() => create();
  static $pb.PbList<AddSubscriptionMessage_Request> createRepeated() => $pb.PbList<AddSubscriptionMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static AddSubscriptionMessage_Request getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddSubscriptionMessage_Request>(create);
  static AddSubscriptionMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserSubscriptionMessage get subscription => $_getN(1);
  @$pb.TagNumber(2)
  set subscription($0.UserSubscriptionMessage v) { $_setField(2, v); }
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
    final $result = create();
    if (responseInfo != null) {
      $result.responseInfo = responseInfo;
    }
    if (subscription != null) {
      $result.subscription = subscription;
    }
    return $result;
  }
  AddSubscriptionMessage_Response._() : super();
  factory AddSubscriptionMessage_Response.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddSubscriptionMessage_Response.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddSubscriptionMessage.Response', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo', subBuilder: ResponseInfo.create)
    ..aOM<$0.UserSubscriptionMessage>(2, _omitFieldNames ? '' : 'subscription', subBuilder: $0.UserSubscriptionMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddSubscriptionMessage_Response clone() => AddSubscriptionMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddSubscriptionMessage_Response copyWith(void Function(AddSubscriptionMessage_Response) updates) => super.copyWith((message) => updates(message as AddSubscriptionMessage_Response)) as AddSubscriptionMessage_Response;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddSubscriptionMessage_Response create() => AddSubscriptionMessage_Response._();
  AddSubscriptionMessage_Response createEmptyInstance() => create();
  static $pb.PbList<AddSubscriptionMessage_Response> createRepeated() => $pb.PbList<AddSubscriptionMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static AddSubscriptionMessage_Response getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddSubscriptionMessage_Response>(create);
  static AddSubscriptionMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserSubscriptionMessage get subscription => $_getN(1);
  @$pb.TagNumber(2)
  set subscription($0.UserSubscriptionMessage v) { $_setField(2, v); }
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
    final $result = create();
    if (request != null) {
      $result.request = request;
    }
    if (response != null) {
      $result.response = response;
    }
    return $result;
  }
  AddSubscriptionMessage._() : super();
  factory AddSubscriptionMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddSubscriptionMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddSubscriptionMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOM<AddSubscriptionMessage_Request>(1, _omitFieldNames ? '' : 'request', subBuilder: AddSubscriptionMessage_Request.create)
    ..aOM<AddSubscriptionMessage_Response>(2, _omitFieldNames ? '' : 'response', subBuilder: AddSubscriptionMessage_Response.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddSubscriptionMessage clone() => AddSubscriptionMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddSubscriptionMessage copyWith(void Function(AddSubscriptionMessage) updates) => super.copyWith((message) => updates(message as AddSubscriptionMessage)) as AddSubscriptionMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddSubscriptionMessage create() => AddSubscriptionMessage._();
  AddSubscriptionMessage createEmptyInstance() => create();
  static $pb.PbList<AddSubscriptionMessage> createRepeated() => $pb.PbList<AddSubscriptionMessage>();
  @$core.pragma('dart2js:noInline')
  static AddSubscriptionMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddSubscriptionMessage>(create);
  static AddSubscriptionMessage? _defaultInstance;

  @$pb.TagNumber(1)
  AddSubscriptionMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(AddSubscriptionMessage_Request v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  AddSubscriptionMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  AddSubscriptionMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(AddSubscriptionMessage_Response v) { $_setField(2, v); }
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
    final $result = create();
    if (requestInfo != null) {
      $result.requestInfo = requestInfo;
    }
    if (subscription != null) {
      $result.subscription = subscription;
    }
    return $result;
  }
  RemoveSubscriptionMessage_Request._() : super();
  factory RemoveSubscriptionMessage_Request.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveSubscriptionMessage_Request.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RemoveSubscriptionMessage.Request', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOM<RequestInfo>(1, _omitFieldNames ? '' : 'requestInfo', subBuilder: RequestInfo.create)
    ..aOM<$0.UserSubscriptionMessage>(2, _omitFieldNames ? '' : 'subscription', subBuilder: $0.UserSubscriptionMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveSubscriptionMessage_Request clone() => RemoveSubscriptionMessage_Request()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveSubscriptionMessage_Request copyWith(void Function(RemoveSubscriptionMessage_Request) updates) => super.copyWith((message) => updates(message as RemoveSubscriptionMessage_Request)) as RemoveSubscriptionMessage_Request;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveSubscriptionMessage_Request create() => RemoveSubscriptionMessage_Request._();
  RemoveSubscriptionMessage_Request createEmptyInstance() => create();
  static $pb.PbList<RemoveSubscriptionMessage_Request> createRepeated() => $pb.PbList<RemoveSubscriptionMessage_Request>();
  @$core.pragma('dart2js:noInline')
  static RemoveSubscriptionMessage_Request getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveSubscriptionMessage_Request>(create);
  static RemoveSubscriptionMessage_Request? _defaultInstance;

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  RequestInfo ensureRequestInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserSubscriptionMessage get subscription => $_getN(1);
  @$pb.TagNumber(2)
  set subscription($0.UserSubscriptionMessage v) { $_setField(2, v); }
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
    final $result = create();
    if (responseInfo != null) {
      $result.responseInfo = responseInfo;
    }
    if (subscription != null) {
      $result.subscription = subscription;
    }
    return $result;
  }
  RemoveSubscriptionMessage_Response._() : super();
  factory RemoveSubscriptionMessage_Response.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveSubscriptionMessage_Response.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RemoveSubscriptionMessage.Response', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, _omitFieldNames ? '' : 'responseInfo', subBuilder: ResponseInfo.create)
    ..aOM<$0.UserSubscriptionMessage>(2, _omitFieldNames ? '' : 'subscription', subBuilder: $0.UserSubscriptionMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveSubscriptionMessage_Response clone() => RemoveSubscriptionMessage_Response()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveSubscriptionMessage_Response copyWith(void Function(RemoveSubscriptionMessage_Response) updates) => super.copyWith((message) => updates(message as RemoveSubscriptionMessage_Response)) as RemoveSubscriptionMessage_Response;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveSubscriptionMessage_Response create() => RemoveSubscriptionMessage_Response._();
  RemoveSubscriptionMessage_Response createEmptyInstance() => create();
  static $pb.PbList<RemoveSubscriptionMessage_Response> createRepeated() => $pb.PbList<RemoveSubscriptionMessage_Response>();
  @$core.pragma('dart2js:noInline')
  static RemoveSubscriptionMessage_Response getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveSubscriptionMessage_Response>(create);
  static RemoveSubscriptionMessage_Response? _defaultInstance;

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  ResponseInfo ensureResponseInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UserSubscriptionMessage get subscription => $_getN(1);
  @$pb.TagNumber(2)
  set subscription($0.UserSubscriptionMessage v) { $_setField(2, v); }
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
    final $result = create();
    if (request != null) {
      $result.request = request;
    }
    if (response != null) {
      $result.response = response;
    }
    return $result;
  }
  RemoveSubscriptionMessage._() : super();
  factory RemoveSubscriptionMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveSubscriptionMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RemoveSubscriptionMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'resonate.api'), createEmptyInstance: create)
    ..aOM<RemoveSubscriptionMessage_Request>(1, _omitFieldNames ? '' : 'request', subBuilder: RemoveSubscriptionMessage_Request.create)
    ..aOM<RemoveSubscriptionMessage_Response>(2, _omitFieldNames ? '' : 'response', subBuilder: RemoveSubscriptionMessage_Response.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveSubscriptionMessage clone() => RemoveSubscriptionMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveSubscriptionMessage copyWith(void Function(RemoveSubscriptionMessage) updates) => super.copyWith((message) => updates(message as RemoveSubscriptionMessage)) as RemoveSubscriptionMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveSubscriptionMessage create() => RemoveSubscriptionMessage._();
  RemoveSubscriptionMessage createEmptyInstance() => create();
  static $pb.PbList<RemoveSubscriptionMessage> createRepeated() => $pb.PbList<RemoveSubscriptionMessage>();
  @$core.pragma('dart2js:noInline')
  static RemoveSubscriptionMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveSubscriptionMessage>(create);
  static RemoveSubscriptionMessage? _defaultInstance;

  @$pb.TagNumber(1)
  RemoveSubscriptionMessage_Request get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(RemoveSubscriptionMessage_Request v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  RemoveSubscriptionMessage_Request ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  RemoveSubscriptionMessage_Response get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(RemoveSubscriptionMessage_Response v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  RemoveSubscriptionMessage_Response ensureResponse() => $_ensure(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
