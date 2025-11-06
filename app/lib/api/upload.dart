import 'dart:typed_data';

import 'package:resonate/api/auth.dart';
import 'package:resonate/api/base.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/services/http.dart';

class UploadApiRequest extends ApiRequest<UploadImageMessage_Request> {
  UploadApiRequest({Uint8List? imageBytes})
    : super(
        UploadImageMessage_Request(
          imageBytes: imageBytes,
          requestInfo: RequestInfo(),
        ),
      );

  @override
  set requestInfo(RequestInfo info) {
    requestPb.requestInfo.mergeFromMessage(info);
  }
}

class UploadApiResponse extends ApiResponse<UploadImageMessage_Response> {
  UploadApiResponse() : super(UploadImageMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;

  String get imageUrl => responsePb.imageUrl;
}

class UploadApiServer extends ServerApi<UploadApiRequest, UploadApiResponse> {
  UploadApiServer({AbstractHttpService? client, required AuthUser authUser})
    : super('api/upload/image', authUser: authUser, client: client);
}

class UploadApi {
  UploadApi({required AbstractHttpService client, required AuthUser authUser})
    : _server = UploadApiServer(client: client, authUser: authUser);

  final UploadApiServer _server;

  Future<ApiResult<String>> upload(Uint8List bytes) async {
    var request = UploadApiRequest(imageBytes: bytes);
    var response = UploadApiResponse();

    try {
      await _server.execute(request, response);
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
    return ApiResult.ok(response.imageUrl);
  }
}
