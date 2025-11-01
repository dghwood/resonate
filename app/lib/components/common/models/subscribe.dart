import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/api/subscription.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/models/models.dart';

Logger _log = Logger('components/common/subscribe');

enum SubscribeNotifierStatus { loading, error, subscribed, unsubscribed }

class SubscribeNotifier extends ChangeNotifier {
  SubscribeNotifier({required this.subscriptionApi, required this.podcast});

  final SubscriptionApi subscriptionApi;
  final Podcast podcast;

  Exception? error;

  SubscribeNotifierStatus __status = SubscribeNotifierStatus.loading;
  set _status(SubscribeNotifierStatus status) {
    __status = status;
    notifyListeners();
  }

  SubscribeNotifierStatus get _status => __status;
  SubscribeNotifierStatus get status => _status;

  void init() async {
    _status = SubscribeNotifierStatus.loading;
    if (subscriptionApi.get(podcast.id) != null) {
      _status = SubscribeNotifierStatus.subscribed;
    } else {
      _status = SubscribeNotifierStatus.unsubscribed;
    }
  }

  void subscribe() async {
    _status = SubscribeNotifierStatus.loading;
    var result = await subscriptionApi.subscribe(podcast);
    switch (result) {
      case ApiOk():
        _status = SubscribeNotifierStatus.subscribed;
        break;
      case ApiError():
        _log.info(result.error);
        error = result.error;
        _status = SubscribeNotifierStatus.error;
        break;
    }
  }

  void unsubscribe() async {
    _status = SubscribeNotifierStatus.loading;
    var result = await subscriptionApi.unsubscribe(podcast.id);
    switch (result) {
      case ApiOk():
        _status = SubscribeNotifierStatus.unsubscribed;
      case ApiError():
        error = result.error;
        _status = SubscribeNotifierStatus.error;
        break;
    }
  }
}

class SubscribeButtonComponent extends StatefulWidget {
  const SubscribeButtonComponent({
    super.key,
    this.icon = false,
    required this.podcast,
    required this.subscriptionApi,
  });

  final bool icon;
  final Podcast podcast;
  final SubscriptionApi subscriptionApi;

  @override
  State<SubscribeButtonComponent> createState() =>
      _SubscribeButtonComponentState();
}

class _SubscribeButtonComponentState extends State<SubscribeButtonComponent> {
  Widget subscribeButton(Function() onPressed) {
    return widget.icon
        ? IconButton(icon: Icon(Icons.add_circle_outline), onPressed: onPressed)
        : OutlinedButton(onPressed: onPressed, child: Text('Subscribe'));
  }

  Widget errorButton(Function() onPressed) {
    return widget.icon
        ? IconButton(icon: Icon(Icons.error_outline), onPressed: onPressed)
        : OutlinedButton(onPressed: onPressed, child: Text('Error'));
  }

  Widget unsubscribedButton(Function() onPressed) {
    return widget.icon
        ? IconButton(
          icon: Icon(Icons.check_circle_outline),
          onPressed: onPressed,
        )
        : OutlinedButton(onPressed: onPressed, child: Text('Subscribed'));
  }

  Widget loadingButton(Function() onPressed) {
    // TODO(duncan): Needs some work...
    return widget.icon
        ? IconButton(icon: Icon(Icons.refresh), onPressed: onPressed)
        : OutlinedButton(onPressed: onPressed, child: Text('Loading'));
  }

  late SubscribeNotifier notifier;
  @override
  void initState() {
    super.initState();
    notifier = SubscribeNotifier(
      podcast: widget.podcast,
      subscriptionApi: widget.subscriptionApi,
    )..init();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: notifier,
      builder: (context, _) {
        switch (notifier.status) {
          case SubscribeNotifierStatus.loading:
            return loadingButton(() {});
          case SubscribeNotifierStatus.error:
            return errorButton(() {
              notifier.init();
            });
          case SubscribeNotifierStatus.subscribed:
            return unsubscribedButton(() {
              notifier.unsubscribe();
            });
          case SubscribeNotifierStatus.unsubscribed:
            return subscribeButton(() {
              notifier.subscribe();
            });
        }
      },
    );
  }
}

class SubscribeIconCommponent extends StatelessWidget {
  SubscribeIconCommponent({
    super.key,
    required AuthUser authUser,
    required Podcast podcast,
    this.size = 16,
  }) : _authUser = authUser,
       _podcast = podcast;
  final AuthUser _authUser;
  final Podcast _podcast;

  final double size;

  final ValueNotifier<Future<ApiResult<bool>>> _future =
      ValueNotifier<Future<ApiResult<bool>>>(Future.value(ApiResult.ok(true)));

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _future,
      builder: (context, value, child) {
        return FutureBuilder(
          future: value,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingSpinnerComponent(size: size);
            }
            var result = snapshot.requireData;
            var subscriptionApi = _authUser.subscriptionApi;
            var subscription = subscriptionApi.get(_podcast.id);
            switch (result) {
              case ApiOk():
                return subscription != null
                    ? IconButton(
                      icon: Icon(Icons.check_circle_outline, size: size),
                      onPressed: () {
                        _future.value = subscriptionApi
                            .unsubscribe(_podcast.id)
                            .then((r) {
                              switch (r) {
                                case ApiOk():
                                  return ApiResult.ok(true);
                                case ApiError():
                                  return ApiResult.error(r.error);
                              }
                            });
                      },
                    )
                    : IconButton(
                      icon: Icon(Icons.add_circle_outline, size: size),
                      onPressed: () {
                        _future.value = subscriptionApi
                            .subscribe(_podcast)
                            .then((r) {
                              switch (r) {
                                case ApiOk():
                                  return ApiResult.ok(true);
                                case ApiError():
                                  return ApiResult.error(r.error);
                              }
                            });
                      },
                    );
              case ApiError():
                return IconButton(
                  icon: Icon(Icons.error_outline, size: size),
                  onPressed: () {
                    _log.info('Error press');
                  },
                );
            }
          },
        );
      },
    );
  }
}
