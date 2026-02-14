import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;
import 'api.pb.dart';
import 'common.pb.dart' as $0;

class ImportOpmlMessage_Request extends $pb.GeneratedMessage {
  factory ImportOpmlMessage_Request({
    RequestInfo? requestInfo,
    $core.List<$core.int>? opmlBytes,
  }) {
    final result = create();
    if (requestInfo != null) result.requestInfo = requestInfo;
    if (opmlBytes != null) result.opmlBytes = opmlBytes;
    return result;
  }
  ImportOpmlMessage_Request._();
  factory ImportOpmlMessage_Request.create() => ImportOpmlMessage_Request._();
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ImportOpmlMessage.Request', package: const $pb.PackageName('resonate.api'), createEmptyInstance: create)
    ..aOM<RequestInfo>(1, 'requestInfo', subBuilder: RequestInfo.create)
    ..a<$core.List<$core.int>>(2, 'opmlBytes', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.override
  $pb.BuilderInfo get info_ => _i;
  static ImportOpmlMessage_Request create() => ImportOpmlMessage_Request._();
  @$core.override
  ImportOpmlMessage_Request createEmptyInstance() => create();

  @$pb.TagNumber(1)
  RequestInfo get requestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set requestInfo(RequestInfo value) => $_setField(1, value);

  @$pb.TagNumber(2)
  $core.List<$core.int> get opmlBytes => $_getN(1);
  @$pb.TagNumber(2)
  set opmlBytes($core.List<$core.int> value) => $_setBytes(1, value);
}

class ImportOpmlMessage_Response extends $pb.GeneratedMessage {
  factory ImportOpmlMessage_Response({
    ResponseInfo? responseInfo,
    $core.Iterable<$0.UserSubscriptionMessage>? subscriptions,
  }) {
    final result = create();
    if (responseInfo != null) result.responseInfo = responseInfo;
    if (subscriptions != null) result.subscriptions.addAll(subscriptions);
    return result;
  }
  ImportOpmlMessage_Response._();
  factory ImportOpmlMessage_Response.create() => ImportOpmlMessage_Response._();
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ImportOpmlMessage.Response', package: const $pb.PackageName('resonate.api'), createEmptyInstance: create)
    ..aOM<ResponseInfo>(1, 'responseInfo', subBuilder: ResponseInfo.create)
    ..pc<$0.UserSubscriptionMessage>(2, 'subscriptions', $pb.PbFieldType.PM, subBuilder: $0.UserSubscriptionMessage.create)
    ..hasRequiredFields = false;

  @$core.override
  $pb.BuilderInfo get info_ => _i;
  static ImportOpmlMessage_Response create() => ImportOpmlMessage_Response._();
  @$core.override
  ImportOpmlMessage_Response createEmptyInstance() => create();

  @$pb.TagNumber(1)
  ResponseInfo get responseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set responseInfo(ResponseInfo value) => $_setField(1, value);

  @$pb.TagNumber(2)
  $core.Iterable<$0.UserSubscriptionMessage> get subscriptions => $_getList(1);
}

class ImportOpmlMessage extends $pb.GeneratedMessage {
  factory ImportOpmlMessage({
    ImportOpmlMessage_Request? request,
    ImportOpmlMessage_Response? response,
  }) {
    final result = create();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }
  ImportOpmlMessage._();
  factory ImportOpmlMessage.create() => ImportOpmlMessage._();
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ImportOpmlMessage', package: const $pb.PackageName('resonate.api'), createEmptyInstance: create)
    ..aOM<ImportOpmlMessage_Request>(1, 'request', subBuilder: ImportOpmlMessage_Request.create)
    ..aOM<ImportOpmlMessage_Response>(2, 'response', subBuilder: ImportOpmlMessage_Response.create)
    ..hasRequiredFields = false;

  @$core.override
  $pb.BuilderInfo get info_ => _i;
  static ImportOpmlMessage create() => ImportOpmlMessage._();
  @$core.override
  ImportOpmlMessage createEmptyInstance() => create();
}
