import 'package:flutter/material.dart';
import 'package:resonate/api/base.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/services/http.dart';
import 'package:resonate/services/secure_database.dart';

class LoginRequestApiRequest extends ApiRequest<LoginRequestMessage_Request> {
  LoginRequestApiRequest()
    : super(LoginRequestMessage_Request(requestInfo: RequestInfo()));

  @override
  set requestInfo(RequestInfo info) =>
      requestPb.requestInfo.mergeFromMessage(info);
}

class LoginRequestApiResponse
    extends ApiResponse<LoginRequestMessage_Response> {
  LoginRequestApiResponse() : super(LoginRequestMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;
}

class LoginRequestApiServer
    extends ServerApi<LoginRequestApiRequest, LoginRequestApiResponse> {
  LoginRequestApiServer({AbstractHttpService? client})
    : super(
        LoginRequestApiRequest(),
        LoginRequestApiResponse(),
        'api/login/request',
        client: client,
      );
}

class LoginUserApiRequest extends ApiRequest<LoginUserMessage_Request> {
  LoginUserApiRequest()
    : super(LoginUserMessage_Request(requestInfo: RequestInfo()));

  @override
  set requestInfo(RequestInfo info) =>
      requestPb.requestInfo.mergeFromMessage(info);
}

class LoginUserApiResponse extends ApiResponse<LoginUserMessage_Response> {
  LoginUserApiResponse() : super(LoginUserMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;
}

class LoginUserApiServer
    extends ServerApi<LoginUserApiRequest, LoginUserApiResponse> {
  LoginUserApiServer({AbstractHttpService? client})
    : super(
        LoginUserApiRequest(),
        LoginUserApiResponse(),
        'api/login',
        client: client,
      );
}

class LoginApi {
  LoginApi({
    required AbstractHttpService httpService,
    required AbstractSecureDatabase secureDatabase,
  }) : _requestServer = LoginRequestApiServer(client: httpService),
       _userServer = LoginUserApiServer(client: httpService),
       _secureDatabase = secureDatabase;

  final LoginRequestApiServer _requestServer;
  final LoginUserApiServer _userServer;
  final AbstractSecureDatabase _secureDatabase;

  Future<ApiResult<bool>> request(String email) async {
    var request = LoginRequestApiRequest();
    request.requestPb.email = email;

    var response = LoginRequestApiResponse();
    try {
      await _requestServer.execute(request, response);
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
    return ApiResult.ok(true);
  }

  Future<ApiResult<User>> login(String email, String password) async {
    var request = LoginUserApiRequest();
    request.requestPb.email = email;
    request.requestPb.password = password;

    var response = LoginUserApiResponse();
    try {
      await _userServer.execute(request, response);
      var accessToken = response.responsePb.accessToken;
      var refreshToken = response.responsePb.refreshToken;
      // Do i need this to be able to support multiple users.
      await _secureDatabase.write("accessToken", accessToken);
      await _secureDatabase.write("refreshKey", refreshToken);
      // Store them in the secureStorage
      return ApiResult.ok(User.fromMessage(response.responsePb.user));
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
  }
}

enum AuthUserStatus { signedIn, signedOut, loading }

class AuthUser {
  AuthUser({
    required LoginApi loginApi,
    required AbstractSecureDatabase secureDatabase,
  }) : _loginApi = loginApi,
       _secureDatabase = secureDatabase {
    loadFromStorage();
  }

  // load from secure storage
  void loadFromStorage() async {
    try {
      var accessToken = await _secureDatabase.read("accessToken");
      var refreshToken = await _secureDatabase.read("refreshKey");
      if (accessToken == null || refreshToken == null) return;
      _status = AuthUserStatus.signedIn; // signin
      // Where do I load the user from?
    } on Exception catch (_) {
      return;
    }
  }

  final LoginApi _loginApi;
  final AbstractSecureDatabase _secureDatabase;
  User? _user;

  AuthUserStatus _status = AuthUserStatus.signedOut;
  bool get isSignedIn => _status == AuthUserStatus.signedIn;

  Future<ApiResult<User>> login(String email, String password) async {
    _status = AuthUserStatus.loading;
    var result = await _loginApi.login(email, password);
    switch (result) {
      case ApiOk():
        _user = result.value;
        _status = AuthUserStatus.signedIn;
        return result;
      case ApiError():
        _status = AuthUserStatus.signedOut;
        return result;
    }
  }

  Future<ApiResult<bool>> requestPassword(String email) async {
    return await _loginApi.request(email);
  }
}
