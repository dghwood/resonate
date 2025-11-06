import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/base.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pb.dart' hide QueryCursor;
import 'package:resonate/services/database.dart';
import 'package:resonate/services/http.dart';
import 'package:resonate/storage/follows.dart';

final Logger _log = Logger('/api/follow');

class FollowApi {
  FollowApi({
    required AbstractHttpService client,
    required AuthUser authUser,
    required AbstractDatabaseService databaseService,
  }) : _authUser = authUser,
       _removeServer = RemoveFollowApiServer(
         client: client,
         authUser: authUser,
       ),
       _listServer = ListFollowApiServer(client: client, authUser: authUser),
       _followsDatabase = FollowsDatabase(databaseService),
       _addServer = AddFollowApiServer(client: client, authUser: authUser);

  final AddFollowApiServer _addServer;
  final FollowsDatabase _followsDatabase;
  final RemoveFollowApiServer _removeServer;
  final ListFollowApiServer _listServer;
  final AuthUser _authUser;

  UserFollow _createFollow(String userId) {
    return UserFollow(
      userId: _authUser.user!.id,
      followedUserId: userId,
      metadata: StorageMetadata.now(),
    );
  }

  Future<ApiResult<UserFollow>> add(PublicUser user) async {
    var follow = _createFollow(user.id);
    var request = AddFollowApiRequest(follow: follow);
    var response = AddFollowApiResponse();

    try {
      await _addServer.execute(request, response);
      follow = response.follow;
      await _followsDatabase.put(follow);
      _followDb[follow.followedUserId] = follow;
      return ApiResult.ok(response.follow);
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
  }

  Future<ApiResult<UserFollow>> remove(PublicUser user) async {
    var currentFollow = _followDb[user.id];
    if (currentFollow == null) {
      return ApiResult.error(Exception('Follow not found'));
    }
    var follow = UserFollow.copy(currentFollow);
    follow.metadata.markDeleted();

    var request = RemoveFollowApiRequest(follow: follow);
    var response = RemoveFollowApiResponse();

    try {
      await _removeServer.execute(request, response);
      follow = response.follow;
      await _followsDatabase.put(follow);
      _followDb.remove(follow.followedUserId);
      return ApiResult.ok(response.follow);
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
  }

  // Local DB for quick look ups..
  final Map<String, UserFollow> _followDb = {};
  Future<UserFollow?> get(String userId) async {
    return _followDb[userId];
  }

  Future<ApiResult<bool>> sync() async {
    try {
      var userId = _authUser.user!.id;
      // Just load from the DB for now..
      var follows = await _followsDatabase.listFromUserId(userId);
      for (var follow in follows) {
        if (follow.metadata.isDeleted) continue;
        _followDb[follow.followedUserId] = follow;
      }
      /* Sync methodology 
        * Check the DB for the most recent updated time.. 
        * Call the server for everything after that time (need to index on updated time)
        * Sync the response to the DB 
        * Load into local cache to support lookup

      */

      return ApiResult.ok(true);
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
  }

  Future<IterableApiResult<Iterable<UserFollow>>> list(
    String userId, {
    QueryCursor? cursor,
    bool isFollowed = false,
  }) async {
    var request = ListFollowApiRequest(
      userId: userId,
      includeUsers: true,
      isFollowed: isFollowed,
      cursor: cursor,
    );
    var response = ListFollowApiResponse();
    try {
      await _listServer.execute(request, response);
      // await _followsDatabase.putAll(response.follows);
      return IterableApiResult.ok(
        response.follows,
        next:
            response.cursor != null
                ? () => list(
                  userId,
                  cursor: response.cursor,
                  isFollowed: isFollowed,
                )
                : null,
      );
    } on Exception catch (e) {
      return IterableApiResult.error(e);
    }
  }
}

class AddFollowApiRequest extends ApiRequest<AddFollowMessage_Request> {
  AddFollowApiRequest({UserFollow? follow})
    : super(
        AddFollowMessage_Request(
          follow: follow?.toMessage(),
          requestInfo: RequestInfo(),
        ),
      );

  @override
  set requestInfo(RequestInfo info) {
    requestPb.requestInfo.mergeFromMessage(info);
  }
}

class AddFollowApiResponse extends ApiResponse<AddFollowMessage_Response> {
  AddFollowApiResponse() : super(AddFollowMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;

  UserFollow get follow => UserFollow.fromMessage(responsePb.follow);
}

class AddFollowApiServer
    extends ServerApi<AddFollowApiRequest, AddFollowApiResponse> {
  AddFollowApiServer({AbstractHttpService? client, required AuthUser authUser})
    : super('api/follow/add', authUser: authUser, client: client);
}

class RemoveFollowApiRequest extends ApiRequest<RemoveFollowMessage_Request> {
  RemoveFollowApiRequest({UserFollow? follow})
    : super(
        RemoveFollowMessage_Request(
          follow: follow?.toMessage(),
          requestInfo: RequestInfo(),
        ),
      );

  @override
  set requestInfo(RequestInfo info) {
    requestPb.requestInfo.mergeFromMessage(info);
  }
}

class RemoveFollowApiResponse
    extends ApiResponse<RemoveFollowMessage_Response> {
  RemoveFollowApiResponse() : super(RemoveFollowMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;

  UserFollow get follow => UserFollow.fromMessage(responsePb.follow);
}

class RemoveFollowApiServer
    extends ServerApi<RemoveFollowApiRequest, RemoveFollowApiResponse> {
  RemoveFollowApiServer({
    AbstractHttpService? client,
    required AuthUser authUser,
  }) : super('api/follow/remove', authUser: authUser, client: client);
}

class ListFollowApiRequest extends ApiRequest<ListFollowMessage_Request> {
  ListFollowApiRequest({
    String? userId,
    QueryCursor? cursor,
    bool? includeUsers,
    bool? isFollowed,
  }) : super(
         ListFollowMessage_Request(
           userId: userId,
           isFollowed: isFollowed,
           includeUsers: includeUsers,
           cursor: cursor?.toMessage(),
           requestInfo: RequestInfo(),
         ),
       );

  @override
  set requestInfo(RequestInfo info) {
    requestPb.requestInfo.mergeFromMessage(info);
  }
}

class ListFollowApiResponse extends ApiResponse<ListFollowMessage_Response> {
  ListFollowApiResponse() : super(ListFollowMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;

  Iterable<UserFollow> get follows =>
      responsePb.follows.map((f) => UserFollow.fromMessage(f));

  QueryCursor? get cursor =>
      responsePb.hasCursor()
          ? QueryCursor.fromMessage(responsePb.cursor)
          : null;
}

class ListFollowApiServer
    extends ServerApi<ListFollowApiRequest, ListFollowApiResponse> {
  ListFollowApiServer({AbstractHttpService? client, required AuthUser authUser})
    : super('api/follow/list', authUser: authUser, client: client);
}
