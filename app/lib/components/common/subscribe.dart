import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/subscription.dart';

Logger _log = Logger('components/common/subscribe');

class SubscribeButtonComponent extends StatelessWidget {
  const SubscribeButtonComponent({
    super.key,
    required AuthUser authUser,
    required String podcastId,
  }) : _authUser = authUser,
       _podcastId = podcastId;
  final AuthUser _authUser;
  final String _podcastId;

  @override
  Widget build(BuildContext context) {
    if (!_authUser.isSignedIn) return SizedBox();
    var subscriptionApi = _authUser.subscriptionApi;
    var subscription = subscriptionApi.get(_podcastId);
    _log.info(subscription);
    if (subscription != null) {
      return IconButton(
        icon: Icon(Icons.check_circle_outline),
        onPressed: () {
          _authUser.subscriptionApi.unsubscribe(_podcastId);
        },
      );
    }
    return IconButton(
      icon: Icon(Icons.add_circle_outline),
      onPressed: () {
        _authUser.subscriptionApi.subscribe(_podcastId);
      },
    );
  }
}
