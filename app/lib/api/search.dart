import 'package:resonate/api/base.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/services/http.dart';

class SearchApiRequest extends ApiRequest<SearchMessage_Request> {
  SearchApiRequest(super.requestPb);

  @override
  RequestInfo get requestInfo => requestPb.requestInfo;
}

class SearchApiResponse extends ApiResponse<SearchMessage_Response> {
  SearchApiResponse(super.requestPb);

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;
}

class SearchApi extends ServerApi<SearchApiRequest, SearchApiResponse> {
  SearchApi({AbstractHttpService? client})
    : super(
        SearchApiRequest(SearchMessage_Request()),
        SearchApiResponse(SearchMessage_Response()),
        'api/search',
        client: client,
      );
}
