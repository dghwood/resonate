import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/base.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/errors/errors.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/services/http.dart';

final Logger _log = Logger('UserApi');

class UserApi {
  UserApi({
    required AbstractHttpService httpService,
    required AbstractDatabaseService databaseService,
    required User user,
  }) : _databaseService = databaseService,
       _getUserApi = GetUserApi(client: httpService, user: user),
       _createUserApi = CreateUserApi(client: httpService, user: user);

  // This should be a UserDatabase
  final AbstractDatabaseService _databaseService;
  final CreateUserApi _createUserApi;
  final GetUserApi _getUserApi;

  Stream<ApiResult<User>> create() async* {
    var request = CreateUserApiRequest();
    var response = CreateUserApiResponse();
    try {
      await _createUserApi.execute(request, response);
      var user = User.fromMessage(response.responsePb.user);
      yield ApiResult.ok(user!);
      // TODO(duncanwood): Store in DB?
    } on Exception catch (e) {
      yield ApiResult.error(e);
    }
  }

  Stream<ApiResult<User>> get(String userId) async* {
    var request = GetUserApiRequest();
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
  CreateUserApiRequest()
    : super(CreateUserMessage_Request(requestInfo: RequestInfo()));

  @override
  set requestInfo(RequestInfo info) {
    _log.info('Setting requestInfo');
    requestPb.requestInfo.mergeFromMessage(info);
  }
}

class CreateUserApiResponse extends ApiResponse<CreateUserMessage_Response> {
  CreateUserApiResponse() : super(CreateUserMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;
}

class CreateUserApi
    extends ServerApi<CreateUserApiRequest, CreateUserApiResponse> {
  CreateUserApi({AbstractHttpService? client, required User user})
    : super(
        CreateUserApiRequest(),
        CreateUserApiResponse(),
        'api/user/create',
        user: user,
        client: client,
      );
}

class UpdateUserApiRequest extends ApiRequest<UpdateUserMessage_Request> {
  UpdateUserApiRequest()
    : super(UpdateUserMessage_Request(requestInfo: RequestInfo()));

  @override
  set requestInfo(RequestInfo info) =>
      requestPb.requestInfo.mergeFromMessage(info);
}

class UpdateUserApiResponse extends ApiResponse<UpdateUserMessage_Response> {
  UpdateUserApiResponse() : super(UpdateUserMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;
}

class UpdateUserApi
    extends ServerApi<UpdateUserApiRequest, UpdateUserApiResponse> {
  UpdateUserApi({AbstractHttpService? client, required User user})
    : super(
        UpdateUserApiRequest(),
        UpdateUserApiResponse(),
        'api/user/update',
        user: user,
        client: client,
      );
}

class GetUserApiRequest extends ApiRequest<GetUserMessage_Request> {
  GetUserApiRequest()
    : super(GetUserMessage_Request(requestInfo: RequestInfo()));

  @override
  set requestInfo(RequestInfo info) =>
      requestPb.requestInfo.mergeFromMessage(info);
}

class GetUserApiResponse extends ApiResponse<GetUserMessage_Response> {
  GetUserApiResponse() : super(GetUserMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;
}

class GetUserApi extends ServerApi<GetUserApiRequest, GetUserApiResponse> {
  GetUserApi({AbstractHttpService? client, required User user})
    : super(
        GetUserApiRequest(),
        GetUserApiResponse(),
        'api/user/get',
        user: user,
        client: client,
      );
}
