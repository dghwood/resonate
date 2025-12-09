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

  Future<ApiResult<bool>> _refresh() async {
    var request = RefreshAuthApiRequest();
    var response = RefreshAuthApiResponse();
    try {
      await _server.execute(request, response);
      return ApiResult.ok(true);
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
  }

  Future<ApiResult<bool>>? _singleRefresh;
  Future<ApiResult<bool>> refresh() async {
    if (_singleRefresh != null) {
      return _singleRefresh!;
    }
    _singleRefresh = _refresh();
    // Any additional calls during this time
    // will return the single future value.
    var value = await _singleRefresh!;
    _singleRefresh = null;
    return value;
  }
}
