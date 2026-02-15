import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/base.dart';
import 'package:resonate/api/podcast.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pb.dart' hide QueryCursor;
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

class SyncSubscriptionApiRequest
    extends ApiRequest<SyncSubscriptionMessage_Request> {
  SyncSubscriptionApiRequest({Iterable<UserSubscription>? subscriptions})
    : super(
        SyncSubscriptionMessage_Request(
          requestInfo: RequestInfo(),
          subscriptions: subscriptions?.map((s) => s.toMessage()).toList(),
        ),
      );

  @override
  set requestInfo(RequestInfo info) {
    requestPb.requestInfo.mergeFromMessage(info);
  }
}

class SyncSubscriptionApiResponse
    extends ApiResponse<SyncSubscriptionMessage_Response> {
  SyncSubscriptionApiResponse() : super(SyncSubscriptionMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;

  Iterable<UserSubscription> get subscriptions =>
      responsePb.subscriptions.map((s) => UserSubscription.fromMessage(s));
}

class SyncSubscriptionApiServer
    extends ServerApi<SyncSubscriptionApiRequest, SyncSubscriptionApiResponse> {
  SyncSubscriptionApiServer({
    required AbstractHttpService client,
    required AuthUser authUser,
  }) : super(
         SyncSubscriptionApiRequest(),
         SyncSubscriptionApiResponse(),
         'api/subscribe/sync',
         authUser: authUser,
         client: client,
       );
}

class ImportOpmlApiRequest extends ApiRequest<ImportOpmlMessage_Request> {
  ImportOpmlApiRequest({List<int>? opmlBytes})
    : super(
        ImportOpmlMessage_Request(
          requestInfo: RequestInfo(),
          opmlBytes: opmlBytes,
        ),
      );

  @override
  set requestInfo(RequestInfo info) {
    requestPb.requestInfo.mergeFromMessage(info);
  }
}

class ImportOpmlApiResponse extends ApiResponse<ImportOpmlMessage_Response> {
  ImportOpmlApiResponse() : super(ImportOpmlMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;

  Iterable<UserSubscription> get subscriptions =>
      responsePb.subscriptions.map((s) => UserSubscription.fromMessage(s));
}

class ImportOpmlApiServer
    extends ServerApi<ImportOpmlApiRequest, ImportOpmlApiResponse> {
  ImportOpmlApiServer({
    required AbstractHttpService client,
    required AuthUser authUser,
  }) : super(
         ImportOpmlApiRequest(),
         ImportOpmlApiResponse(),
         'api/subscribe/import',
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
       _syncServer = SyncSubscriptionApiServer(
         client: client,
         authUser: authUser,
       ),
       _importServer = ImportOpmlApiServer(client: client, authUser: authUser),
       _podcastDatabase = PodcastDatabase(databaseService),
       //  _podcastDatabase = PodcastDatabase(databaseService),
       _subscriptionDatabase = SubscriptionDatabase(databaseService);

  final AuthUser _authUser;
  final AddSubscriptionApiServer _subscribeServer;
  final RemoveSubscriptionApiServer _unsubscribeServer;
  final SyncSubscriptionApiServer _syncServer;
  final ImportOpmlApiServer _importServer;
  final SubscriptionDatabase _subscriptionDatabase;
  // For adding podcasts to the database
  // when syncing.
  final PodcastDatabase _podcastDatabase;

  final Map<String, UserSubscription> _subscriptions = {};

  Future<void> init() async {
    _log.info('Initializing SubscriptionApi...');
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
    var result = await listLocal();
    switch (result) {
      case ApiOkIterable():
        break;
      case ApiErrorIterable():
        return ApiResult.error(result.error);
    }

    var subscriptions = result.result;
    var request = SyncSubscriptionApiRequest(subscriptions: subscriptions);
    var response = SyncSubscriptionApiResponse();
    try {
      await _syncServer.execute(request, response);
      // log to database
      // await _subscriptionDatabase.clear();
      subscriptions = response.subscriptions;
      // add the podcast messages
      for (var sub in subscriptions) {
        if (sub.podcast != null) {
          // remove the podcast and add to db.
          _log.info("adding podcast ${sub.podcast!.id}");
          await _podcastDatabase.put(sub.podcast!);
          sub.dropPodcast();
        }
      }
      await _subscriptionDatabase.putAll(subscriptions);
      _log.info('Synced ${subscriptions.length} subscriptions');
      return ApiResult.ok(subscriptions);
    } on Exception catch (e) {
      return ApiResult.error(e);
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

    try {
      // Add the podcast to the db so you have a cache.
      await _podcastDatabase.put(podcast);
    } on Exception catch (e) {
      _log.severe(e);
      return ApiResult.error(e);
    }

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

  Future<ApiResult<Iterable<UserSubscription>>> importOpml(
    List<int> opmlBytes,
  ) async {
    var request = ImportOpmlApiRequest(opmlBytes: opmlBytes);
    var response = ImportOpmlApiResponse();
    try {
      await _importServer.execute(request, response);
      var subscriptions = response.subscriptions;

      var podcasts = <Podcast>[];
      for (var sub in subscriptions) {
        if (sub.podcast != null) {
          podcasts.add(sub.podcast!);
          // Drop the podcasts from the subscription message
          sub.dropPodcast();
        }
      }
      // Add the podcasts to the database
      if (podcasts.isNotEmpty) {
        _log.info("Batch adding ${podcasts.length} podcasts from OPML");
        await _podcastDatabase.putAll(podcasts);
      }

      // Update local database
      await _subscriptionDatabase.putAll(subscriptions);

      // Update local cache
      for (final sub in subscriptions) {
        _subscriptions[sub.podcastId] = sub;
      }

      notifyListeners();
      _log.info('Imported ${subscriptions.length} subscriptions from OPML');
      return ApiResult.ok(subscriptions);
    } on Exception catch (e) {
      _log.severe('Failed to import OPML: $e');
      return ApiResult.error(e);
    }
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
      var result = await get();
      switch (result) {
        case ApiOk():
          return IterableApiResult.ok(result.value);
        case ApiError():
          return IterableApiResult.error(result.error);
      }
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

  Future<ApiResult<Iterable<UserSubscription>>> get() async {
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
    _log.info('for podcastIds: $podcastIds');
    var podcastResult = await _podcastApi.getMany(podcastIds);

    switch (podcastResult) {
      case ApiOk():
        break;
      case ApiError():
        return ApiResult.error(podcastResult.error);
    }

    Map<String, UserSubscription> subscriptionsMap = {};
    for (var subscription in subscriptions) {
      subscriptionsMap[subscription.podcastId] = subscription;
    }
    for (var podcast in podcastResult.value) {
      var subscription = subscriptionsMap[podcast.id];
      if (subscription == null) continue;
      subscriptionsMap[podcast.id] = subscription.copyWithPodcast(podcast);
    }
    // TODO(duncan): I need to sort this list..
    return ApiResult.ok(subscriptionsMap.values);
  }
}
