import 'dart:typed_data';

import 'package:logging/logging.dart';
import 'package:protobuf/protobuf.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/services/http.dart';

Logger _log = Logger("api/base");

class ApiException implements Exception {
  ApiException(this.message);
  final String message;

  @override
  String toString() {
    return 'ApiException: $message';
  }
}

class ApiRequest<Req extends GeneratedMessage> {
  ApiRequest(this.requestPb);
  final Req requestPb;

  Uint8List writeToBuffer() {
    return requestPb.writeToBuffer();
  }

  set requestInfo(RequestInfo info) {
    throw UnimplementedError('requestInfo must be implemented by subclasses');
  }
}

class ApiResponse<Res extends GeneratedMessage> {
  ApiResponse(this.responsePb);
  final Res responsePb;

  void fromBuffer(Uint8List buffer) {
    responsePb.mergeFromBuffer(buffer);
  }

  ResponseInfo get responseInfo {
    throw UnimplementedError('responseInfo must be implemented by subclasses');
  }
}

class Api<Req extends ApiRequest, Res extends ApiResponse> {
  Api(this.baseRequest, this.baseResponse);

  final Req baseRequest;
  final Res baseResponse;

  Future<void> execute(Req request, Res response) {
    throw UnimplementedError('execute() must be implemented by subclasses');
  }
}

class ServerApi<Req extends ApiRequest, Res extends ApiResponse>
    extends Api<Req, Res> {
  ServerApi(
    super.request,
    super.response,
    path, {
    // Setting this means
    AuthUser? authUser,
    AbstractHttpService? client,
    bool requiresLogin = true,
  }) : _client = client ?? HttpService(),
       _path = path,
       _authUser = authUser;

  final AuthUser? _authUser;
  final AbstractHttpService _client;
  final String _path;
  // TODO(duncan): This needs to be configurable
  final String _baseUrl = 'http://localhost:8080';

  @override
  Future<void> execute(Req request, Res response) async {
    var requestInfo = RequestInfo();
    final url = Uri.parse('$_baseUrl/$_path');
    var authToken = "";
    if (_authUser != null) {
      requestInfo.accessToken = _authUser.accessToken!.toMessage();
      requestInfo.userId = _authUser.user?.id ?? '';
      _log.info("requesting $url");
    }
    request.requestInfo = requestInfo;
    var resp = await _client.post(
      url,
      headers: {'Resonate': 'its me, Mario!', 'Authorization': authToken},
      body: request.writeToBuffer(),
    );
    response.fromBuffer(resp);
    if (!response.responseInfo.success) {
      throw ApiException(response.responseInfo.errorMessage);
    }
  }
}

class ApiClient<Req extends ApiRequest, Res extends ApiResponse>
    extends Api<Req, Res> {
  ApiClient(
    super.request,
    super.response, {
    Api<Req, Res>? serverApi,
    Api<Req, Res>? localApi,
  }) : _serverApi = serverApi,
       _localApi = localApi;

  final Api<Req, Res>? _serverApi;
  final Api<Req, Res>? _localApi;

  @override
  Future<void> execute(Req request, Res response) async {
    await _serverApi?.execute(request, response);
  }
}
