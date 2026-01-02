import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/base.dart';
import 'package:resonate/api/command.dart';
import 'package:resonate/api/contacts.dart';
import 'package:resonate/api/download.dart';
import 'package:resonate/api/feed.dart';
import 'package:resonate/api/listens.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/api/settings.dart';
import 'package:resonate/api/subscription.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/services/http/http.dart';
import 'package:resonate/services/secure_database/secure_database.dart';
import 'package:resonate/utils/cookie.dart';

Logger _log = Logger('api/auth');

String secureStorageUserIdKey = 'user';
String secureStorageUserKey(String userId) => '$userId-user';

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
  LoginRequestApiServer({
    required AbstractHttpService client,
    required AuthUser authUser,
  }) : super(
         LoginRequestApiRequest(),
         LoginRequestApiResponse(),
         'api/login/request',
         client: client,
         authUser: authUser,
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
  LoginUserApiServer({
    required AbstractHttpService client,
    required AuthUser authUser,
  }) : super(
         LoginUserApiRequest(),
         LoginUserApiResponse(),
         'api/login',
         client: client,
         authUser: authUser,
       );
}

class LoginApi {
  LoginApi({
    required AbstractHttpService httpService,
    required SecureProtoDatabase secureDatabase,
    required AuthUser authUser,
  }) : _requestServer = LoginRequestApiServer(
         client: httpService,
         authUser: authUser,
       ),
       _userServer = LoginUserApiServer(
         client: httpService,
         authUser: authUser,
       ),
       _secureDatabase = secureDatabase;

  final LoginRequestApiServer _requestServer;
  final LoginUserApiServer _userServer;
  final SecureProtoDatabase _secureDatabase;

  Future<ApiResult<bool>> request(String phoneNumber) async {
    var request = LoginRequestApiRequest();
    request.requestPb.phoneNumber = phoneNumber;

    var response = LoginRequestApiResponse();
    try {
      await _requestServer.execute(request, response);
      _log.info(response.responseInfo);
    } on Exception catch (e) {
      _log.info("request error $e");
      return ApiResult.error(e);
    }
    return ApiResult.ok(true);
  }

  Future<ApiResult<UserStorage>> login(
    String phoneNumber,
    String password,
  ) async {
    var request = LoginUserApiRequest();
    request.requestPb.phoneNumber = phoneNumber;
    request.requestPb.password = password;

    var response = LoginUserApiResponse();
    try {
      await _userServer.execute(request, response);
      var user = User.fromMessage(response.responsePb.user);
      var userStorage = UserStorage(
        user: User.fromMessage(response.responsePb.user),
      );
      await _secureDatabase.writeKey("user", user.id);
      // Do i need this to be able to support multiple users.
      // This should have ~16mb of space, so should be good enough.
      await _secureDatabase.write(
        secureStorageUserKey(user.id),
        userStorage.user,
      );

      // Store them in the secureStorage
      return ApiResult.ok(userStorage);
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
  }
}

class EditUserApiRequest extends ApiRequest<EditUserMessage_Request> {
  EditUserApiRequest()
    : super(EditUserMessage_Request(requestInfo: RequestInfo()));

  @override
  set requestInfo(RequestInfo info) =>
      requestPb.requestInfo.mergeFromMessage(info);
}

class EditUserApiResponse extends ApiResponse<EditUserMessage_Response> {
  EditUserApiResponse() : super(EditUserMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;
}

class EditUserApiServer
    extends ServerApi<EditUserApiRequest, EditUserApiResponse> {
  EditUserApiServer({
    required AbstractHttpService client,
    required AuthUser authUser,
  }) : super(
         EditUserApiRequest(),
         EditUserApiResponse(),
         'api/users/edit',
         client: client,
         authUser: authUser,
       );
}

class EditUserApi {
  EditUserApi({
    required AbstractHttpService httpClient,
    required SecureProtoDatabase secureDatabase,
    required AuthUser authUser,
  }) : _server = EditUserApiServer(client: httpClient, authUser: authUser),
       _secureDatabase = secureDatabase;

  final EditUserApiServer _server;
  final SecureProtoDatabase _secureDatabase;

  Future<ApiResult<User>> edit(User user) async {
    // The user message here, should only contain edited fields
    // not the full user object.
    var server = await editServer(user);
    switch (server) {
      case ApiOk():
        // Now we have the updates from the server
        // we can save locally.
        var serverUser = server.value;
        var local = await editLocal(serverUser);
        switch (local) {
          case ApiOk():
            return ApiResult.ok(serverUser);
          case ApiError():
            return ApiResult.error(local.error);
        }
      case ApiError():
        return ApiResult.error(server.error);
    }
  }

  Future<ApiResult<User>> editLocal(User user) async {
    try {
      var userId = await _secureDatabase.readKey(secureStorageUserIdKey);
      if (userId != user.id) {
        throw Exception('User id mismatch');
      }
      await _secureDatabase.write(secureStorageUserKey(user.id), user);
      return ApiResult.ok(user);
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
  }

  Future<ApiResult<User>> editServer(User user) async {
    var request = EditUserApiRequest();
    request.requestPb.user = user.toMessage();
    var response = EditUserApiResponse();
    try {
      await _server.execute(request, response);
      return ApiResult.ok(User.fromMessage(response.responsePb.user));
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
  }) : _databaseService = databaseService,
       _secureDatabase = secureDatabase {
    _loginApi = LoginApi(
      authUser: this,
      httpService: httpService,
      secureDatabase: secureDatabase,
    );
    subscriptionApi = SubscriptionApi(
      client: httpService,
      databaseService: databaseService,
      authUser: this,
    );
    listenApi = ListenApi(
      authUser: this,
      databaseService: databaseService,
      httpService: httpService,
    );
    _editUserApi = EditUserApi(
      httpClient: httpService,
      secureDatabase: secureDatabase,
      authUser: this,
    );
    feedApi = GetFeedApi(
      httpService: httpService,
      databaseService: databaseService,
      authUser: this,
      subscriptionApi: subscriptionApi,
    );
    // _settingsApi = SettingsApi(databaseService: databaseService);
    downloadApi = DownloadApi(authUser: this, databaseService: databaseService);
    loadFromStorage();
  }

  late final SubscriptionApi subscriptionApi;
  late final ListenApi listenApi;
  late final DownloadApi downloadApi;
  late final EditUserApi _editUserApi;
  late final GetFeedApi feedApi;

  final User _user = User();

  // load from secure storage
  Future<void> loadFromStorage() async {
    try {
      setStatusAndNotify(AuthUserStatus.loading);
      // check whether the cookies are avaiable
      // this will be true for app
      if (!hasAuthCookie()) {
        throw Exception('No cookies available');
      }
      // These error out if they doesn't exist
      var userId = await _secureDatabase.readKey(secureStorageUserIdKey);
      await _secureDatabase.read(secureStorageUserKey(userId), _user);

      _log.info('user: $_user');
      setStatusAndNotify(AuthUserStatus.signedIn);
    } on Exception catch (_) {
      setStatusAndNotify(AuthUserStatus.signedOut);
      return;
    }
  }

  late final LoginApi _loginApi;
  final SecureProtoDatabase _secureDatabase;
  final AbstractDatabaseService _databaseService;

  final UserStorage _userStorage = UserStorage();
  User? get user => _status == AuthUserStatus.signedIn ? _user : null;

  AuthUserStatus _status = AuthUserStatus.signedOut;
  void setStatusAndNotify(AuthUserStatus status) {
    // if (_status == status) return;
    _status = status;
    notifyListeners();
  }

  AuthUserStatus get status => _status;

  bool get isSignedIn => _status == AuthUserStatus.signedIn;

  Future<ApiResult<bool>> signout() async {
    _log.info('signout');
    try {
      var userId = _userStorage.user.id;
      await _secureDatabase.delete(userId);
      _userStorage.reset();
      setStatusAndNotify(AuthUserStatus.signedOut);
      return ApiResult.ok(true);
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
  }

  Future<ApiResult<bool>> login(String phoneNumber, String password) async {
    _log.info('login');
    // Don't let this notify listeners.
    _status = AuthUserStatus.loading;
    var result = await _loginApi.login(phoneNumber, password);
    switch (result) {
      case ApiOk():
        _log.info('loggedIn');
        _user.fromMessage(result.value.user.toMessage());

        _log.info('user: $_user');
        _status = AuthUserStatus.signedIn;
        return ApiResult.ok(true);
      case ApiError():
        _log.info('loggedInError::${result.error}');
        _status = AuthUserStatus.signedOut;
        return ApiResult.error(result.error);
    }
  }

  Future<ApiResult<User>> edit(User user) async {
    _log.info('edit $user');
    // This should be able to change all the fields
    // so this user object, should just contain
    // changed fields.
    var result = await _editUserApi.edit(user);
    switch (result) {
      case ApiOk():
        _user.fromMessage(result.value.toMessage());
        return ApiResult.ok(_user);
      case ApiError():
        return ApiResult.error(result.error);
    }
  }

  ApiResultNotifier1<User, User> editCommand() {
    return ApiResultNotifier1<User, User>(edit);
  }

  ApiResultNotifier2<bool, String, String> loginCommand() {
    return ApiResultNotifier2<bool, String, String>(login);
  }

  ApiResultNotifier1<bool, String> requestPasswordCommand() {
    return ApiResultNotifier1<bool, String>(_loginApi.request);
  }
}
