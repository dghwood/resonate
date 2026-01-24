import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:protobuf/protobuf.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/refresh.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/proto/errors.pbenum.dart';
import 'package:resonate/services/http/http.dart';
import 'package:resonate/utils/constants.dart';

Logger _log = Logger("api/base");

class ApiException implements Exception {
  ApiException(this.errorEnum, {this.message});
  final String? message;
  final ErrorEnum errorEnum;

  @override
  String toString() {
    return 'ApiException: $errorEnum::$message';
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
    required AuthUser authUser,
    required AbstractHttpService client,
    bool requiresLogin = true,
  }) : _client = client,
       _path = path,
       _authUser = authUser;

  final AuthUser? _authUser;
  final AbstractHttpService _client;
  final String _path;

  final String _baseUrl = BASE_URL;

  @override
  Future<void> execute(Req request, Res response, {int numAttempts = 0}) async {
    if (numAttempts > 3) {
      throw ApiException(
        ErrorEnum.ERROR_INVALID_CREDENTIALS,
        message: 'Invalid credentials',
      );
    }
    var requestInfo = RequestInfo(clientVersion: CLIENT_VERSION);
    final url = Uri.parse('$_baseUrl/$_path');
    if (_authUser != null) {
      // Note: AuthTokens are implemented via the HTTP Service cookies.
      requestInfo.userId = _authUser.user?.id ?? '';
      _log.info("requesting $url");
    }
    request.requestInfo = requestInfo;
    var resp = await _client.post(
      url,
      // headers: {'Resonate': 'its me, Mario!', 'Authorization': authToken},
      body: request.writeToBuffer(),
    );

    response.fromBuffer(resp);
    if (!response.responseInfo.success) {
      var error = response.responseInfo.error;
      switch (error) {
        case ErrorEnum.ERROR_TIME_EXPIRED:
          var result = await _refreshAccessToken();
          switch (result) {
            case ApiOk():
              // retry the request
              await execute(request, response, numAttempts: numAttempts + 1);
            case ApiError():
              // Signout..
              _authUser?.signout();
              throw ApiException(
                response.responseInfo.error,
                message: response.responseInfo.errorMessage,
              );
          }
        default:
          throw ApiException(
            response.responseInfo.error,
            message: response.responseInfo.errorMessage,
          );
      }
    }
  }

  Future<ApiResult<bool>> _refreshAccessToken() async {
    if (_authUser == null) return ApiResult.error(Exception('no auth user'));
    var api = RefreshTokenApi(authUser: _authUser, client: _client);
    return await api.refresh();
  }
}

class LocalApi<Req extends ApiRequest, Res extends ApiResponse>
    extends Api<Req, Res> {
  LocalApi(super.request, super.response);

  @override
  Future<void> execute(Req request, Res response) async {}
}
