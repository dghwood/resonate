import 'package:resonate/api/base.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/services/http.dart';

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
