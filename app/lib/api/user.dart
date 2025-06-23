import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:provider/provider.dart';
import 'package:resonate/api/base.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/services/http.dart';

class UserNotSignedInError implements Exception {
  UserNotSignedInError();

  @override
  String toString() => 'User not signed in';
}

class UserApi {
  UserApi({
    required AbstractHttpService httpService,
    required AbstractDatabaseService databaseService,
  }) : _databaseService = databaseService,
       _getUserApi = GetUserApi(client: httpService),
       _createUserApi = CreateUserApi(client: httpService);

  // This should be a UserDatabase
  final AbstractDatabaseService _databaseService;
  final CreateUserApi _createUserApi;
  final GetUserApi _getUserApi;

  User? _user;
  User? get user => isSignedIn ? _user : null;

  auth.User? get _firebaseUser => auth.FirebaseAuth.instance.currentUser;

  bool get isSignedIn => _firebaseUser != null;

  Future<String> authToken() async {
    if (!isSignedIn) throw UserNotSignedInError();

    var user = _firebaseUser!;
    var token = await user.getIdToken(true);
    if (token != null) return token;
    // This probably makes sense.
    throw UserNotSignedInError();
  }

  User _fromFirebaseUser(auth.User user) {
    return User(
      id: 'firebase::${user.uid}',
      name: user.displayName,
      email: user.email,
      imageUrl: user.photoURL,
    );
  }

  Stream<ApiResult<User>> create() async* {
    if (!isSignedIn) throw UserNotSignedInError();
    var request = CreateUserApiRequest();
    request.requestPb.user = _fromFirebaseUser(_firebaseUser!).toMessage();

    var response = CreateUserApiResponse();
    try {
      await _createUserApi.execute(request, response);
      _user = User.fromMessage(response.responsePb.user);
      yield ApiResult.ok(_user!);
      // TODO(duncanwood): Store in DB?
    } on Exception catch (e) {
      yield ApiResult.error(e);
    }
  }

  Stream<ApiResult<User>> get(String userId) async* {
    var request = GetUserApiRequest();
    request.requestPb.userId = userId;
    var response = GetUserApiResponse();
    try {
      await _getUserApi.execute(request, response);
      var user = User.fromMessage(response.responsePb.user);
      yield ApiResult.ok(user);
    } on Exception catch (e) {
      yield ApiResult.error(e);
    }
  }
}

class CreateUserApiRequest extends ApiRequest<CreateUserMessage_Request> {
  CreateUserApiRequest() : super(CreateUserMessage_Request());

  @override
  RequestInfo get requestInfo => requestPb.requestInfo;
}

class CreateUserApiResponse extends ApiResponse<CreateUserMessage_Response> {
  CreateUserApiResponse() : super(CreateUserMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;
}

class CreateUserApi
    extends ServerApi<CreateUserApiRequest, CreateUserApiResponse> {
  CreateUserApi({AbstractHttpService? client})
    : super(
        CreateUserApiRequest(),
        CreateUserApiResponse(),
        'api/user/create',
        client: client,
      );
}

class UpdateUserApiRequest extends ApiRequest<UpdateUserMessage_Request> {
  UpdateUserApiRequest(super.requestPb);

  @override
  RequestInfo get requestInfo => requestPb.requestInfo;
}

class UpdateUserApiResponse extends ApiResponse<UpdateUserMessage_Response> {
  UpdateUserApiResponse(super.requestPb);

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;
}

class UpdateUserApi
    extends ServerApi<UpdateUserApiRequest, UpdateUserApiResponse> {
  UpdateUserApi({AbstractHttpService? client})
    : super(
        UpdateUserApiRequest(UpdateUserMessage_Request()),
        UpdateUserApiResponse(UpdateUserMessage_Response()),
        'api/user/update',
        client: client,
      );
}

class GetUserApiRequest extends ApiRequest<GetUserMessage_Request> {
  GetUserApiRequest() : super(GetUserMessage_Request());

  @override
  RequestInfo get requestInfo => requestPb.requestInfo;
}

class GetUserApiResponse extends ApiResponse<GetUserMessage_Response> {
  GetUserApiResponse() : super(GetUserMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;
}

class GetUserApi extends ServerApi<GetUserApiRequest, GetUserApiResponse> {
  GetUserApi({AbstractHttpService? client})
    : super(
        GetUserApiRequest(),
        GetUserApiResponse(),
        'api/user/get',
        client: client,
      );
}
