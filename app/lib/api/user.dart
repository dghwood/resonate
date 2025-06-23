import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:resonate/api/base.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/services/http.dart';

class UserNotSignedInError implements Exception {
  UserNotSignedInError(this.messsage);
  final String message;
}

class UserApi {
  UserApi({
    required AbstractHttpService httpService,
    required AbstractDatabaseService databaseService,
  }) : _httpService = httpService,
       _databaseService = databaseService;

  final AbstractHttpService _httpService;
  final AbstractDatabaseService _databaseService;

  auth.User? get _firebaseUser => auth.FirebaseAuth.instance.currentUser;

  bool get isSignedIn => _firebaseUser != null;

  Future<String> authToken() async {
    if (!isSignedIn) return;
    var user = _firebaseUser!;
    var token = await user.getIdToken(true);
    if (token != null) return token;
  }
}

class CreateUserApiRequest extends ApiRequest<CreateUserMessage_Request> {
  CreateUserApiRequest(super.requestPb);

  @override
  RequestInfo get requestInfo => requestPb.requestInfo;
}

class CreateUserApiResponse extends ApiResponse<CreateUserMessage_Response> {
  CreateUserApiResponse(super.requestPb);

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;
}

class CreateUserApi
    extends ServerApi<CreateUserApiRequest, CreateUserApiResponse> {
  CreateUserApi({AbstractHttpService? client})
    : super(
        CreateUserApiRequest(CreateUserMessage_Request()),
        CreateUserApiResponse(CreateUserMessage_Response()),
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
  GetUserApiRequest(super.requestPb);

  @override
  RequestInfo get requestInfo => requestPb.requestInfo;
}

class GetUserApiResponse extends ApiResponse<GetUserMessage_Response> {
  GetUserApiResponse(super.requestPb);

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;
}

class GetUserApi extends ServerApi<GetUserApiRequest, GetUserApiResponse> {
  GetUserApi({AbstractHttpService? client})
    : super(
        GetUserApiRequest(GetUserMessage_Request()),
        GetUserApiResponse(GetUserMessage_Response()),
        'api/user/get',
        client: client,
      );
}
