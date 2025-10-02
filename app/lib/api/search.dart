import 'package:resonate/api/auth.dart';
import 'package:resonate/api/base.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/services/http.dart';

class SearchApiRequest extends ApiRequest<SearchMessage_Request> {
  SearchApiRequest() : super(SearchMessage_Request(requestInfo: RequestInfo()));

  @override
  set requestInfo(RequestInfo info) {
    requestPb.requestInfo.mergeFromMessage(info);
  }
}

class SearchApiResponse extends ApiResponse<SearchMessage_Response> {
  SearchApiResponse() : super(SearchMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;
}

class SearchApiServer extends ServerApi<SearchApiRequest, SearchApiResponse> {
  SearchApiServer({AbstractHttpService? client, required AuthUser authUser})
    : super(
        SearchApiRequest(),
        SearchApiResponse(),
        'api/search/query',
        authUser: authUser,
        client: client,
      );
}

class SearchApi {
  SearchApi({required AbstractHttpService client, required AuthUser authUser})
    : _server = SearchApiServer(authUser: authUser, client: client);

  final SearchApiServer _server;

  // I feel like this needs to return various types..
  Future<ApiResult<SearchResults>> search(
    String query, {
    String mode = 'PODCASTS',
  }) async {
    var request = SearchApiRequest();
    request.requestPb.query = query;
    // Update the request type.. eg. Podcasts
    var response = SearchApiResponse();

    try {
      await _server.execute(request, response);
      return ApiResult.ok(
        SearchResults.fromMessage(response.responsePb.searchResults),
      );
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
  }
}
