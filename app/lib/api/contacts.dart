import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/base.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pb.dart' hide QueryCursor;
import 'package:resonate/services/contacts.dart';
import 'package:resonate/services/http.dart';
import 'package:resonate/utils/search.dart';

final Logger _log = Logger('api/episode');

/* Contacts */

class SearchContactsApiRequest
    extends ApiRequest<SearchContactsMessage_Request> {
  SearchContactsApiRequest({
    Iterable<UserContact>? contacts,
    QueryCursor? cursor,
    String? query,
  }) : super(
         SearchContactsMessage_Request(
           query: query,
           cursor: cursor?.toMessage(),
           requestInfo: RequestInfo(),
         ),
       );

  @override
  set requestInfo(RequestInfo info) =>
      requestPb.requestInfo.mergeFromMessage(info);
}

class SearchContactsApiResponse
    extends ApiResponse<SearchContactsMessage_Response> {
  SearchContactsApiResponse() : super(SearchContactsMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;

  QueryCursor get cursor => QueryCursor.fromMessage(responsePb.cursor);
  Iterable<PublicUser> get users =>
      responsePb.users.map((u) => PublicUser.fromMessage(u));
}

class SearchContactsApiServer
    extends ServerApi<SearchContactsApiRequest, SearchContactsApiResponse> {
  SearchContactsApiServer({
    required AbstractHttpService client,
    required AuthUser authUser,
  }) : super(
         SearchContactsApiRequest(),
         SearchContactsApiResponse(),
         'api/users/search',
         client: client,
         authUser: authUser,
       );
}

class SearchTopContactsApiRequest
    extends ApiRequest<SearchTopContactsMessage_Request> {
  SearchTopContactsApiRequest({Iterable<UserContact>? contacts})
    : super(
        SearchTopContactsMessage_Request(
          contacts: contacts?.map((e) => e.toMessage()),
          requestInfo: RequestInfo(),
        ),
      );

  @override
  set requestInfo(RequestInfo info) =>
      requestPb.requestInfo.mergeFromMessage(info);
}

class SearchTopContactsApiResponse
    extends ApiResponse<SearchTopContactsMessage_Response> {
  SearchTopContactsApiResponse() : super(SearchTopContactsMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;

  Iterable<PublicUser> get users =>
      responsePb.users.map((u) => PublicUser.fromMessage(u));
}

class SearchTopContactsApiServer
    extends
        ServerApi<SearchTopContactsApiRequest, SearchTopContactsApiResponse> {
  SearchTopContactsApiServer({
    required AbstractHttpService client,
    required AuthUser authUser,
  }) : super(
         SearchTopContactsApiRequest(),
         SearchTopContactsApiResponse(),
         'api/users/top',
         client: client,
         authUser: authUser,
       );
}

class SearchContactsApi {
  SearchContactsApi({
    required AbstractHttpService client,
    required AuthUser authUser,
    required AbstractContactsService contactsSerivce,
  }) : _contactsService = contactsSerivce,
       _server = SearchContactsApiServer(client: client, authUser: authUser),
       _topServer = SearchTopContactsApiServer(
         authUser: authUser,
         client: client,
       );

  final SearchContactsApiServer _server;
  final SearchTopContactsApiServer _topServer;
  final AbstractContactsService _contactsService;

  Future<ApiResult<bool>> hasPermission() async {
    try {
      return ApiResult.ok(await _contactsService.hasPermission);
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
  }

  Future<ApiResult<bool>> requestPermission() async {
    try {
      var result = await _contactsService.requestPermission();
      return ApiResult.ok(result);
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
  }

  // TODO(duncan): This might end up stale..
  final List<PublicUser> _contacts = [];

  Future<IterableApiResult<Iterable<PublicUser>>> autocomplete(
    String query,
  ) async {
    if (query.isEmpty) return IterableApiResult.ok(_contacts);
    if (_contacts.isEmpty) {
      var result = await top();
      if (result is! ApiOk) return result;
    }

    // Implement simple search
    return IterableApiResult.ok(
      _contacts.where((user) => SearchableUserModel(user).search(query)),
    );
  }

  // Returns top users, or your contacts? or merged?
  Future<IterableApiResult<Iterable<PublicUser>>> top() async {
    if (_contacts.isNotEmpty) return IterableApiResult.ok(_contacts);
    Iterable<UserContact> contacts = [];

    try {
      // This will error out if no permission
      contacts = await _contactsService.getContacts();
    } on Exception catch (e) {
      _log.info(e);
    }

    try {
      var request = SearchTopContactsApiRequest(contacts: contacts);
      var response = SearchTopContactsApiResponse();
      await _topServer.execute(request, response);
      var users = response.users;

      _contacts.clear();
      _contacts.addAll(users);
      return IterableApiResult.ok(response.users);
    } on Exception catch (e) {
      return IterableApiResult.error(e);
    }
  }

  Future<IterableApiResult<Iterable<PublicUser>>> search(
    String query, {
    QueryCursor? cursor,
  }) async {
    try {
      var request = SearchContactsApiRequest(query: query, cursor: cursor);
      var response = SearchContactsApiResponse();
      await _server.execute(request, response);

      return IterableApiResult.ok(
        response.users,
        next: () => search(query, cursor: response.cursor),
      );
    } on Exception catch (e) {
      return IterableApiResult.error(e);
    }
  }
}
