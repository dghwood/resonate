// import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/base.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/services/http/http.dart';

// Logger _log = Logger('api/episode');

class RefreshAuthApiRequest extends ApiRequest<RefreshAuthMessage_Request> {
  RefreshAuthApiRequest()
    : super(RefreshAuthMessage_Request(requestInfo: RequestInfo()));

  @override
  set requestInfo(RequestInfo info) =>
      requestPb.requestInfo.mergeFromMessage(info);
}

class RefreshAuthApiResponse extends ApiResponse<RefreshAuthMessage_Response> {
  RefreshAuthApiResponse() : super(RefreshAuthMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;
}

class RefreshTokenApiServer
    extends ServerApi<RefreshAuthApiRequest, RefreshAuthApiResponse> {
  RefreshTokenApiServer({
    required AbstractHttpService client,
    required AuthUser authUser,
  }) : super(
         RefreshAuthApiRequest(),
         RefreshAuthApiResponse(),
         'api/login/refresh',
         client: client,
         authUser: authUser,
       );
}

// This needs a lock essentially, to stop many requests trying to refresh
// at the same time.

class RefreshTokenApi {
  RefreshTokenApi({
    required AbstractHttpService client,
    required AuthUser authUser,
  }) : _server = RefreshTokenApiServer(authUser: authUser, client: client);

  final RefreshTokenApiServer _server;
  bool _isLoading = false;

  Future<ApiResult<bool>> refresh() async {
    _isLoading = true;
    var request = RefreshAuthApiRequest();
    var response = RefreshAuthApiResponse();
    try {
      await _server.execute(request, response);
      _isLoading = false;
      return ApiResult.ok(true);
    } on Exception catch (e) {
      _isLoading = false;
      return ApiResult.error(e);
    }
  }
}
