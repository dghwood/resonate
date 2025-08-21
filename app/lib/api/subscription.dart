import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/base.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/services/http.dart';
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
    AbstractHttpService? client,
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
    AbstractHttpService? client,
    required AuthUser authUser,
  }) : super(
         RemoveSubscriptionApiRequest(),
         RemoveSubscriptionApiResponse(),
         'api/subscribe/remove',
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
       _subscriptionDatabase = SubscriptionDatabase(databaseService);

  final AuthUser _authUser;

  final AddSubscriptionApiServer _subscribeServer;
  final RemoveSubscriptionApiServer _unsubscribeServer;
  final SubscriptionDatabase _subscriptionDatabase;

  final Map<String, UserSubscription> _subscriptions = {};

  Future<void> init() async {
    _log.info('Initializing SubscriptionApi...');
    // This should try the db and server..
    await for (final subscription in list()) {
      _subscriptions.clear();
      for (final sub in subscription) {
        _subscriptions[sub.podcastId] = sub;
      }
    }
  }

  UserSubscription? get(String podcastId) => _subscriptions[podcastId];

  Stream<Iterable<UserSubscription>> list() async* {
    try {
      yield await _subscriptionDatabase.list();
    } on Exception catch (e) {
      _log.info('Failed to initialize subscription database: $e');
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

  Future<ApiResult<UserSubscription>> subscribe(String podcastId) async {
    if (_subscriptions.containsKey(podcastId)) {
      _log.info('Already subscribed to $podcastId');
      return ApiResult.ok(_subscriptions[podcastId]!);
    }

    var subscription = _createSubscription(podcastId);

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
    return ApiResult.ok(subscription);
  }

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
    return ApiResult.ok(true);
  }
}
