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

  Future<ApiResult<UserSubscription>> subscribe(String podcastId) async {
    // This needs to invalidate the _subscriptions cache..
    var request = AddSubscriptionApiRequest();
    var subscription = UserSubscriptionMessage(
      // userId: '123', // TODO(duncan): Do I need to update this?
      podcastId: podcastId,
    );
    request.requestPb.subscription = subscription;
    var response = AddSubscriptionApiResponse();

    try {
      await _subscribeServer.execute(request, response);
      _subscriptions[podcastId] = UserSubscription.fromMessage(
        response.responsePb.subscription,
      );
      return ApiResult.ok(
        UserSubscription.fromMessage(response.responsePb.subscription),
      );
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
  }

  Future<ApiResult<UserSubscription>> unsubscribe(String podcastId) async {
    // This needs to invalidate the _subscriptions cache..
    var request = RemoveSubscriptionApiRequest();
    request.requestPb.subscription = UserSubscriptionMessage(
      // userId: '123', // TODO(duncan): Do I need to update this?
      podcastId: podcastId,
    );
    var response = RemoveSubscriptionApiResponse();

    try {
      await _unsubscribeServer.execute(request, response);
      _subscriptions.remove(podcastId);
      return ApiResult.ok(
        UserSubscription.fromMessage(response.responsePb.subscription),
      );
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
  }
}
