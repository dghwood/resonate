import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/base.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pb.dart' hide QueryCursor;
import 'package:resonate/services/contacts.dart';
import 'package:resonate/services/http.dart';

final Logger _log = Logger('api/episode');

class FindContactsApiRequest extends ApiRequest<FindContactsMessage_Request> {
  FindContactsApiRequest({Iterable<String>? phoneNumbers, QueryCursor? cursor})
    : super(
        FindContactsMessage_Request(
          phoneNumbers: phoneNumbers,
          cursor: cursor?.toMessage(),
          requestInfo: RequestInfo(),
        ),
      );

  @override
  set requestInfo(RequestInfo info) =>
      requestPb.requestInfo.mergeFromMessage(info);
}

class FindContactsApiResponse
    extends ApiResponse<FindContactsMessage_Response> {
  FindContactsApiResponse() : super(FindContactsMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;

  QueryCursor get cursor => QueryCursor.fromMessage(responsePb.cursor);
  Iterable<PublicUser> get users =>
      responsePb.users.map((u) => PublicUser.fromMessage(u));
}

class FindContactsApiServer
    extends ServerApi<FindContactsApiRequest, FindContactsApiResponse> {
  FindContactsApiServer({
    AbstractHttpService? client,
    required AuthUser authUser,
  }) : super(
         FindContactsApiRequest(),
         FindContactsApiResponse(),
         'api/find/users',
         client: client,
         authUser: authUser,
       );
}

class FindUsersApi {
  FindUsersApi({
    required AbstractHttpService client,
    required AuthUser authUser,
    required AbstractContactsService contactsSerivce,
  }) : _contactsService = contactsSerivce,
       _server = FindContactsApiServer(client: client, authUser: authUser);

  final FindContactsApiServer _server;
  final AbstractContactsService _contactsService;

  Future<IterableApiResult<Iterable<PublicUser>>> requestAndFind() async {
    try {
      return find(await _contactsService.getPhoneNumbers());
    } on Exception catch (e) {
      return IterableApiResult.error(e);
    }
  }

  Future<IterableApiResult<Iterable<PublicUser>>> find(
    Iterable<String> phoneNumbers, {
    QueryCursor? cursor,
  }) async {
    var request = FindContactsApiRequest(
      phoneNumbers: phoneNumbers,
      cursor: cursor,
    );
    var response = FindContactsApiResponse();
    try {
      await _server.execute(request, response);

      return IterableApiResult.ok(
        response.users,
        next: () => find(phoneNumbers, cursor: response.cursor),
      );
    } on Exception catch (e) {
      return IterableApiResult.error(e);
    }
  }
}
