import 'dart:typed_data';

import 'package:resonate/api/base.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/services/http.dart';

class GetPodcastApiRequest extends ApiRequest<GetPodcastMessage_Request> {
  GetPodcastApiRequest() : super(GetPodcastMessage_Request());

  @override
  RequestInfo get requestInfo => requestPb.requestInfo;
}

class GetPodcastApiResponse extends ApiResponse<GetPodcastMessage_Response> {
  GetPodcastApiResponse() : super(GetPodcastMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;

  void fromPodcastBuffer(Uint8List buffer) {
    responsePb.mergeFromBuffer(buffer);
  }
}

class GetPodcastApiServer
    extends ServerApi<GetPodcastApiRequest, GetPodcastApiResponse> {
  GetPodcastApiServer({AbstractHttpService? client})
    : super(
        GetPodcastApiRequest(),
        GetPodcastApiResponse(),
        'api/podcast/get',
        client: client,
      );
}

// class GetPodcastApiLocal
//     extends Api<GetPodcastApiRequest, GetPodcastApiResponse> {
//   GetPodcastApiLocal({AbstractDatabaseService? databaseService})
//     : _databaseService = databaseService ?? DatabaseService('podcast'),
//       super(GetPodcastApiRequest(), GetPodcastApiResponse());

//   final AbstractDatabaseService _databaseService;

//   @override
//   Future<void> execute(
//     GetPodcastApiRequest request,
//     GetPodcastApiResponse response,
//   ) async {
//     await _databaseService.init();
//     var resp = await _databaseService.getValue(request.requestPb.podcastId);
//     response.fromPodcastBuffer(resp);
//   }
// }

// class GetPodcastApi extends Api<GetPodcastApiRequest, GetPodcastApiResponse> {
//   GetPodcastApi(
//     Api<GetPodcastApiRequest, GetPodcastApiResponse> localApi,
//     Api<GetPodcastApiRequest, GetPodcastApiResponse> serverApi,
//   ) : _localApi = localApi,
//       _serverApi = serverApi,
//       super(GetPodcastApiRequest(), GetPodcastApiResponse());

//   final Api<GetPodcastApiRequest, GetPodcastApiResponse> _localApi;
//   final Api<GetPodcastApiRequest, GetPodcastApiResponse> _serverApi;

//   @override
//   Future<void> execute(
//     GetPodcastApiRequest request,
//     GetPodcastApiResponse response,
//   ) async {
//     try {
//       await _localApi.execute(request, response);
//     } catch (e) {
//       await _serverApi.execute(request, response);
//       response.responsePb.podcast;
//     }
//   }
// }
