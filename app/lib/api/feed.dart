import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/base.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/api/subscription.dart';
import 'package:resonate/errors/errors.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/services/http.dart';
import 'package:resonate/storage/episode.dart';
import 'package:resonate/storage/feed.dart';

final Logger _log = Logger("/api/feed");

class GetFeedApiRequest extends ApiRequest<GetFeedMessage_Request> {
  GetFeedApiRequest()
    : super(GetFeedMessage_Request(requestInfo: RequestInfo()));

  @override
  set requestInfo(RequestInfo info) =>
      requestPb.requestInfo.mergeFromMessage(info);
}

class GetFeedApiResponse extends ApiResponse<GetFeedMessage_Response> {
  GetFeedApiResponse() : super(GetFeedMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;

  void fromEpisodeBuffer(Uint8List buffer) {
    responsePb.mergeFromBuffer(buffer);
  }
}

class GetFeedApiServer
    extends ServerApi<GetFeedApiRequest, GetFeedApiResponse> {
  GetFeedApiServer({AbstractHttpService? client, required AuthUser authUser})
    : super(
        GetFeedApiRequest(),
        GetFeedApiResponse(),
        'api/feed/get',
        client: client,
        authUser: authUser,
      );
}

class GetFeedApi extends ChangeNotifier {
  GetFeedApi({
    required AbstractHttpService httpService,
    required AbstractDatabaseService databaseService,
    required AuthUser authUser,
    required SubscriptionApi subscriptionApi,
  }) : _server = GetFeedApiServer(client: httpService, authUser: authUser),
       _database = FeedDatabase(databaseService),
       _authUser = authUser,
       _subscriptionApi = subscriptionApi {
    _subscriptionApi.addListener(subscriptionListener);
  }

  final GetFeedApiServer _server;
  final FeedDatabase _database;
  final AuthUser _authUser;
  final SubscriptionApi _subscriptionApi;

  void subscriptionListener() {
    notifyListeners();
  }

  @override
  void dispose() {
    _subscriptionApi.removeListener(subscriptionListener);
    super.dispose();
  }

  /* get 

    I've been debating how to implement this. 

    I've gone with a Server first implementation
    * So the server returns the feed with the bells & whistles 
    * I'll have a first page cache so it still works offline
      * But paging with throw on offline error.. 
    
  */
  Stream<ApiResult<UserFeed>> get({DateTime? before}) async* {
    if (!_authUser.isSignedIn) {
      yield ApiResult.error(UserNotSignedInError());
      return;
    }
    var userId = _authUser.user!.id;
    var feed = UserFeed(userId: userId);
    // Try database only for first call
    if (before == null) {
      try {
        await _database.get(feed);
        yield ApiResult.ok(feed);
      } on Exception catch (_) {
        // Do I return this?
        // yield ApiResult.error(e);
      }
    }
    try {
      var request = GetFeedApiRequest();
      request.requestPb.userId = userId;
      var response = GetFeedApiResponse();
      await _server.execute(request, response);
      feed = UserFeed.fromMessage(response.responsePb.feed);
      await _database.put(feed);
      _log.info("feed refreshed");
      yield ApiResult.ok(feed);
    } on Exception catch (e) {
      yield ApiResult.error(e);
    }
  }
}
