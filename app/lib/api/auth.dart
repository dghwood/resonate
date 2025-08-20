import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/base.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/api/subscription.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/services/http.dart';
import 'package:resonate/services/secure_database.dart';
import 'package:resonate/storage/subscriptions.dart';

Logger _log = Logger('api/auth');

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
    required SecureProtoDatabase secureDatabase,
  }) : _requestServer = LoginRequestApiServer(client: httpService),
       _userServer = LoginUserApiServer(client: httpService),
       _secureDatabase = secureDatabase;

  final LoginRequestApiServer _requestServer;
  final LoginUserApiServer _userServer;
  final SecureProtoDatabase _secureDatabase;

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

  Future<ApiResult<UserStorage>> login(String email, String password) async {
    var request = LoginUserApiRequest();
    request.requestPb.email = email;
    request.requestPb.password = password;

    var response = LoginUserApiResponse();
    try {
      await _userServer.execute(request, response);
      var user = User.fromMessage(response.responsePb.user);
      var userStorage = UserStorage(
        user: User.fromMessage(response.responsePb.user),
        accessToken: Token.fromMessage(response.responsePb.accessToken),
        refreshToken: Token.fromMessage(response.responsePb.refreshToken),
      );
      await _secureDatabase.writeKey("user", user.id);
      // Do i need this to be able to support multiple users.
      // This should have ~16mb of space, so should be good enough.
      await _secureDatabase.write(userStorage.id, userStorage);

      // Store them in the secureStorage
      return ApiResult.ok(userStorage);
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
  }
}

enum AuthUserStatus { signedIn, signedOut, loading }

/* AuthUser 

  This is the primary entity for the user of the app. 
*/
class AuthUser extends ChangeNotifier {
  AuthUser({
    required AbstractHttpService httpService,
    required SecureProtoDatabase secureDatabase,
    required AbstractDatabaseService databaseService,
  }) : _loginApi = LoginApi(
         httpService: httpService,
         secureDatabase: secureDatabase,
       ),
       _databaseService = databaseService,
       _secureDatabase = secureDatabase {
    subscriptionApi = SubscriptionApi(
      client: httpService,
      databaseService: databaseService,
      authUser: this,
    );
    loadFromStorage();
  }

  late final SubscriptionApi subscriptionApi;

  // load from secure storage
  Future<void> loadFromStorage() async {
    try {
      _status = AuthUserStatus.loading;
      // These error out if they doesn't exist
      var userId = await _secureDatabase.readKey('user');
      await _secureDatabase.read(userId, _userStorage);
      await _setupPostLogin();
    } on Exception catch (_) {
      _status = AuthUserStatus.signedOut;
      return;
    }
  }

  final LoginApi _loginApi;
  final SecureProtoDatabase _secureDatabase;
  final AbstractDatabaseService _databaseService;

  final UserStorage _userStorage = UserStorage();
  User? get user => isSignedInForDb ? _userStorage.user : null;
  Token? get accessToken => isSignedInForDb ? _userStorage.accessToken : null;
  Token? get refreshToken => isSignedInForDb ? _userStorage.refreshToken : null;

  AuthUserStatus __status = AuthUserStatus.signedOut;
  set _status(AuthUserStatus newStatus) {
    if (_status == newStatus) return; // No change
    __status = newStatus;
    notifyListeners();
  }

  AuthUserStatus get _status => __status;
  AuthUserStatus get status => __status;

  bool get isSignedIn => _status == AuthUserStatus.signedIn;
  // Temporarily set to allow DB to see the user signed in before we update the
  // notifier status
  bool _isSignedInForDb = false;
  bool get isSignedInForDb =>
      _isSignedInForDb || _status == AuthUserStatus.signedIn;

  Future<void> _setupPostLogin() async {
    await _databaseService.init(this);
    _isSignedInForDb = true;
    // This loads the user subscriptions into memory
    await subscriptionApi.init();
    _isSignedInForDb = false;
    _status = AuthUserStatus.signedIn;
  }

  Future<ApiResult<bool>> signout() async {
    _log.info('signout');
    try {
      var userId = _userStorage.user.id;
      await _secureDatabase.delete(userId);
      _userStorage.reset();
      _status = AuthUserStatus.signedOut;
      return ApiResult.ok(true);
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
  }

  Future<ApiResult<bool>> login(String email, String password) async {
    _log.info('login');
    _status = AuthUserStatus.loading;
    var result = await _loginApi.login(email, password);
    switch (result) {
      case ApiOk():
        _log.info('loggedIn');
        _userStorage.fromMessage(result.value.toMessage());
        await _setupPostLogin();
        return ApiResult.ok(true);
      case ApiError():
        _log.info('loggedInError');
        _status = AuthUserStatus.signedOut;
        return ApiResult.error(result.error);
    }
  }

  Future<ApiResult<bool>> requestPassword(String email) async {
    return await _loginApi.request(email);
  }
}
