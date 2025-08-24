import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/models/models.dart';

Logger _log = Logger('components/common/subscribe');

class SubscribeIconCommponent extends StatelessWidget {
  SubscribeIconCommponent({
    super.key,
    required AuthUser authUser,
    required Podcast podcast,
  }) : _authUser = authUser,
       _podcast = podcast;
  final AuthUser _authUser;
  final Podcast _podcast;

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
              return LoadingSpinnerComponent(size: 16);
            }
            var result = snapshot.requireData;
            var subscriptionApi = _authUser.subscriptionApi;
            var subscription = subscriptionApi.get(_podcast.id);
            _log.info('${_podcast.id} - $subscription');
            switch (result) {
              case ApiOk():
                return subscription != null
                    ? IconButton(
                      icon: Icon(Icons.check_circle_outline),
                      onPressed: () {
                        _log.info('Unsubscribe press');
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
                      icon: Icon(Icons.add_circle_outline),
                      onPressed: () {
                        _log.info('Subscribe press');
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
                  icon: Icon(Icons.error_outline),
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
