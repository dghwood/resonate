import 'dart:nativewrappers/_internal/vm/bin/vmservice_io.dart';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/base.dart';
import 'package:resonate/api/podcast.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pb.dart' hide QueryCursor;
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/services/http/http.dart';
import 'package:resonate/storage/podcast.dart';
import 'package:resonate/storage/subscriptions.dart';

Logger _log = Logger('api/subscription');

class AddSubscriptionApiRequest
    extends ApiRequest<AddSubscriptionMessage_Request> {
  AddSubscriptionApiRequest()
    : super(AddSubscriptionMessage_Request(requestInfo: RequestInfo()));

  @override
  set requestInfo(RequestInfo info) {
    requestPb.requestInfo.mergeFromMessage(info);
  }
}

class AddSubscriptionApiResponse
    extends ApiResponse<AddSubscriptionMessage_Response> {
  AddSubscriptionApiResponse() : super(AddSubscriptionMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;
}

class AddSubscriptionApiServer
    extends ServerApi<AddSubscriptionApiRequest, AddSubscriptionApiResponse> {
  AddSubscriptionApiServer({
    required AbstractHttpService client,
    required AuthUser authUser,
  }) : super(
         AddSubscriptionApiRequest(),
         AddSubscriptionApiResponse(),
         'api/subscribe/add',
         authUser: authUser,
         client: client,
       );
}

class RemoveSubscriptionApiRequest
    extends ApiRequest<RemoveSubscriptionMessage_Request> {
  RemoveSubscriptionApiRequest()
    : super(RemoveSubscriptionMessage_Request(requestInfo: RequestInfo()));

  @override
  set requestInfo(RequestInfo info) {
    requestPb.requestInfo.mergeFromMessage(info);
  }
}

class RemoveSubscriptionApiResponse
    extends ApiResponse<RemoveSubscriptionMessage_Response> {
  RemoveSubscriptionApiResponse() : super(RemoveSubscriptionMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;
}

class RemoveSubscriptionApiServer
    extends
        ServerApi<RemoveSubscriptionApiRequest, RemoveSubscriptionApiResponse> {
  RemoveSubscriptionApiServer({
    required AbstractHttpService client,
    required AuthUser authUser,
  }) : super(
         RemoveSubscriptionApiRequest(),
         RemoveSubscriptionApiResponse(),
         'api/subscribe/remove',
         authUser: authUser,
         client: client,
       );
}

class ListSubscriptionApiRequest
    extends ApiRequest<ListSubscriptionMessage_Request> {
  ListSubscriptionApiRequest({String? userId, bool? includePodcasts})
    : super(
        ListSubscriptionMessage_Request(
          userId: userId,
          includePodcasts: includePodcasts,
          requestInfo: RequestInfo(),
        ),
      );

  @override
  set requestInfo(RequestInfo info) {
    requestPb.requestInfo.mergeFromMessage(info);
  }
}

class ListSubscriptionApiResponse
    extends ApiResponse<ListSubscriptionMessage_Response> {
  ListSubscriptionApiResponse() : super(ListSubscriptionMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;

  QueryCursor? get cursor =>
      responsePb.hasCursor()
          ? QueryCursor.fromMessage(responsePb.cursor)
          : null;
  Iterable<UserSubscription> get subscriptions =>
      responsePb.subscriptions.map((s) => UserSubscription.fromMessage(s));
}

class ListSubscriptionApiServer
    extends ServerApi<ListSubscriptionApiRequest, ListSubscriptionApiResponse> {
  ListSubscriptionApiServer({
    required AbstractHttpService client,
    required AuthUser authUser,
  }) : super(
         ListSubscriptionApiRequest(),
         ListSubscriptionApiResponse(),
         'api/subscribe/list',
         authUser: authUser,
         client: client,
       );
}

class SubscriptionApi extends ChangeNotifier {
  SubscriptionApi({
    required AbstractHttpService client,
    required AuthUser authUser,
    required AbstractDatabaseService databaseService,
  }) : _authUser = authUser,
       _subscribeServer = AddSubscriptionApiServer(
         client: client,
         authUser: authUser,
       ),
       _unsubscribeServer = RemoveSubscriptionApiServer(
         client: client,
         authUser: authUser,
       ),
       //  _podcastDatabase = PodcastDatabase(databaseService),
       _subscriptionDatabase = SubscriptionDatabase(databaseService);

  final AuthUser _authUser;
  final AddSubscriptionApiServer _subscribeServer;
  final RemoveSubscriptionApiServer _unsubscribeServer;
  final SubscriptionDatabase _subscriptionDatabase;
  // final PodcastDatabase _podcastDatabase;

  final Map<String, UserSubscription> _subscriptions = {};

  Future<void> init() async {
    _log.info('Initializing SubscriptionApi...');
    // This should try the db and server..
    var result = await sync();
    switch (result) {
      case ApiOk():
        var subscription = result.value;
        _subscriptions.clear();

        for (final sub in subscription) {
          _subscriptions[sub.podcastId] = sub;
        }
      case ApiError():
        _log.warning('Failed to load subscriptions: ${result.error}');
    }
  }

  UserSubscription? get(String podcastId) => _subscriptions[podcastId];

  Future<IterableApiResult<Iterable<UserSubscription>>> list() async {
    return await listLocal();
  }

  Future<IterableApiResult<Iterable<UserSubscription>>> listLocal() async {
    try {
      var result = await _subscriptionDatabase.list();
      return IterableApiResult.ok(result);
    } on Exception catch (e) {
      _log.info('Failed to initialize subscription database: $e');
      return IterableApiResult.error(e);
    }
  }

  Future<ApiResult<Iterable<UserSubscription>>> sync() async {
    var result = await list();
    switch (result) {
      case ApiOkIterable():
        return ApiResult.ok(result.result);
      case ApiErrorIterable():
        return ApiResult.error(result.error);
    }
  }

  UserSubscription _createSubscription(String podcastId) {
    return UserSubscription(
      id: '${_authUser.user!.id}-$podcastId',
      userId: _authUser.user!.id,
      podcastId: podcastId,
      metadata: StorageMetadata(
        updatedTimestamp: DateTime.now(),
        createdTimestamp: DateTime.now(),
      ),
    );
  }

  Future<ApiResult<UserSubscription>> subscribe(Podcast podcast) async {
    var podcastId = podcast.id;
    if (_subscriptions.containsKey(podcastId)) {
      _log.info('Already subscribed to $podcastId');
      return ApiResult.ok(_subscriptions[podcastId]!);
    }

    var subscription = _createSubscription(podcastId);
    _log.info('created_subscription::${subscription.id}');

    // TODO(duncanwood): Do I need to make sure I have a local copy of the
    // podcast, in theory if I've got the podcastId then I should have stored
    // it already?

    var request = AddSubscriptionApiRequest();
    var response = AddSubscriptionApiResponse();
    request.requestPb.subscription = subscription.toMessage();

    // Sync to the database
    try {
      await _subscriptionDatabase.put(subscription);
    } on Exception catch (e) {
      _log.severe('Failed to put subscription in database: $e');
      return ApiResult.error(e);
    }

    // Sync to the server
    try {
      await _subscribeServer.execute(request, response);
    } on Exception catch (e) {
      _log.info('Server subscription failed: $e');
    }

    // Update the local cache.
    _subscriptions[podcastId] = subscription;
    notifyListeners();
    return ApiResult.ok(subscription);
  }

  // Do I need to clean up the podcast storage too?
  Future<ApiResult<bool>> unsubscribe(String podcastId) async {
    if (!_subscriptions.containsKey(podcastId)) {
      _log.info('Not subscribed to $podcastId');
      return ApiResult.ok(true);
    }

    var subscription = UserSubscription.copy(_subscriptions[podcastId]!);
    subscription.metadata.markDeleted();

    var request = RemoveSubscriptionApiRequest();
    var response = RemoveSubscriptionApiResponse();
    request.requestPb.subscription = subscription.toMessage();

    // Update the database
    try {
      await _subscriptionDatabase.put(subscription);
    } on Exception catch (e) {
      _log.severe('Failed to remove subscription from database: $e');
      return ApiResult.error(e);
    }

    // Update the server
    try {
      await _unsubscribeServer.execute(request, response);
    } on Exception catch (e) {
      _log.info('Server unsubscription failed: $e');
    }

    // Update the local cache
    _subscriptions.remove(podcastId);
    notifyListeners();
    return ApiResult.ok(true);
  }
}

class SubscriptionsApi extends ChangeNotifier {
  SubscriptionsApi({
    required AuthUser authUser,
    required AbstractHttpService httpService,
    required PodcastApi podcastApi,
  }) : _authUser = authUser,
       _listServer = ListSubscriptionApiServer(
         authUser: authUser,
         client: httpService,
       ),
       _podcastApi = podcastApi {
    _authUser.subscriptionApi.addListener(onSubscriptionApi);
  }

  void onSubscriptionApi() {
    notifyListeners();
  }

  final AuthUser _authUser;
  final PodcastApi _podcastApi;
  final ListSubscriptionApiServer _listServer;

  Future<IterableApiResult<Iterable<UserSubscription>>> listForUser(
    String userId, {
    QueryCursor? cusor,
  }) async {
    Exception? serverError;
    var user = _authUser.user;

    if (user != null && user.id == userId) {
      return await _authUser.subscriptionApi.list();
    }

    var request = ListSubscriptionApiRequest(
      userId: userId,
      includePodcasts: true,
    );
    var response = ListSubscriptionApiResponse();
    try {
      await _listServer.execute(request, response);
      var subscriptions = response.subscriptions;
      return IterableApiResult.ok(
        subscriptions,
        next:
            response.cursor != null
                ? () => listForUser(userId, cusor: response.cursor)
                : null,
      );
    } on Exception catch (e) {
      serverError = e;
    }

    if (user == null || user.id != userId) {
      // If not the authUser then return the server error
      return IterableApiResult.error(serverError);
    }

    // Try local database
    return await _authUser.subscriptionApi.listLocal();
  }

  Future<ApiResult<Iterable<Podcast>>> get() async {
    var subscriptionApi = _authUser.subscriptionApi;
    var result = await subscriptionApi.listLocal();

    switch (result) {
      case ApiOkIterable():
        break;
      case ApiErrorIterable():
        return ApiResult.error(result.error);
    }

    var subscriptions = result.result;
    var podcastIds = subscriptions.map((s) => s.podcastId);
    var podcastResult = await _podcastApi.getMany(podcastIds);

    switch (podcastResult) {
      case ApiOk():
        break;
      case ApiError():
        return ApiResult.error(podcastResult.error);
    }

    return ApiResult.ok(podcastResult.value);
  }
}
