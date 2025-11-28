import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/base.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/services/http.dart';

final Logger _log = Logger('PublicUserApi');

class PublicUserApi {
  PublicUserApi({
    required AbstractHttpService httpService,
    required AuthUser authUser,
  }) : _server = GetPublicUserApiServer(
         client: httpService,
         authUser: authUser,
       );

  final GetPublicUserApiServer _server;

  Future<ApiResult<PublicUser>> get(String userId) async {
    var request = GetPublicUserApiRequest(userId: userId);
    var response = GetPublicUserApiResponse();
    try {
      await _server.execute(request, response);
      return ApiResult.ok(response.user);
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
  }
}

class GetPublicUserApiRequest extends ApiRequest<GetPublicUserMessage_Request> {
  GetPublicUserApiRequest({String? userId})
    : super(
        GetPublicUserMessage_Request(
          userId: userId,
          requestInfo: RequestInfo(),
        ),
      );

  @override
  set requestInfo(RequestInfo info) =>
      requestPb.requestInfo.mergeFromMessage(info);
}

class GetPublicUserApiResponse
    extends ApiResponse<GetPublicUserMessage_Response> {
  GetPublicUserApiResponse() : super(GetPublicUserMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;

  PublicUser get user => PublicUser.fromMessage(responsePb.user);
}

class GetPublicUserApiServer
    extends ServerApi<GetPublicUserApiRequest, GetPublicUserApiResponse> {
  GetPublicUserApiServer({
    required AbstractHttpService client,
    required AuthUser authUser,
  }) : super(
         GetPublicUserApiRequest(),
         GetPublicUserApiResponse(),
         'api/users/get',
         authUser: authUser,
         client: client,
       );
}
