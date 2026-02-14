import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/errors.dart';
import 'package:resonate/api/follow.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/components/common/infinite_scroll.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/router/navigation.dart';

/* FollowIconComponent 

  This has a bunch of stages 

  * First it needs to check if you follow the user 
  * The follow / unfollow 
  * catch the error and retry 
*/
enum FollowNotifierStatus { loading, error, followed, unfollowed }

class FollowNotifier extends ChangeNotifier {
  FollowNotifier({required this.followApi, required this.user});

  final FollowApi followApi;
  final PublicUser user;

  Exception? error;

  FollowNotifierStatus __status = FollowNotifierStatus.loading;
  set _status(FollowNotifierStatus status) {
    __status = status;
    notifyListeners();
  }

  FollowNotifierStatus get _status => __status;
  FollowNotifierStatus get status => _status;

  void init() async {
    _status = FollowNotifierStatus.loading;
    if (await followApi.get(user.id) != null) {
      _status = FollowNotifierStatus.followed;
    } else {
      _status = FollowNotifierStatus.unfollowed;
    }
  }

  void follow() async {
    _status = FollowNotifierStatus.loading;
    var result = await followApi.add(user);
    switch (result) {
      case ApiOk():
        _status = FollowNotifierStatus.followed;
        break;
      case ApiError():
        error = result.error;
        _status = FollowNotifierStatus.error;
        break;
    }
  }

  void unfollow() async {
    _status = FollowNotifierStatus.loading;
    var result = await followApi.remove(user);
    switch (result) {
      case ApiOk():
        _status = FollowNotifierStatus.unfollowed;
      case ApiError():
        error = result.error;
        _status = FollowNotifierStatus.error;
        break;
    }
  }
}

class FollowIconComponent extends StatelessWidget {
  const FollowIconComponent({
    super.key,
    required this.followApi,
    required this.user,
    this.icon = true,
  });

  final FollowApi followApi;
  final PublicUser user;
  final bool icon;

  Widget unfollowButton(Function() onPressed) {
    return OutlinedButtonComponent(
      icon: Icon(Icons.add_circle_outline),
      showIcon: icon,
      state: ButtonState.off,
      onPressed: onPressed,
      child: Text('Follow'),
    );
  }

  Widget errorButton(Function() onPressed) {
    return OutlinedButtonComponent(
      icon: Icon(Icons.error_outline),
      showIcon: icon,
      state: ButtonState.error,
      onPressed: onPressed,
      child: Text('Error'),
    );
  }

  Widget followButton(Function() onPressed) {
    return OutlinedButtonComponent(
      icon: Icon(Icons.check_circle_outline),
      showIcon: icon,
      state: ButtonState.on,
      onPressed: onPressed,
      child: Text('Following'),
    );
  }

  Widget loadingButton(Function() onPressed) {
    // TODO(duncan): Needs some work...
    return OutlinedButtonComponent(
      icon: Icon(Icons.refresh),
      showIcon: icon,
      state: ButtonState.loading,
      onPressed: onPressed,
      child: Text('Loading'),
    );
  }

  @override
  Widget build(BuildContext context) {
    var notifier = FollowNotifier(followApi: followApi, user: user);
    notifier.init();

    return ListenableBuilder(
      listenable: notifier,
      builder: (context, _) {
        switch (notifier.status) {
          case FollowNotifierStatus.loading:
            return loadingButton(notifier.init);
          case FollowNotifierStatus.error:
            context.read<ErrorService>().report(context, notifier.error!);
            return errorButton(notifier.init);
          case FollowNotifierStatus.followed:
            return followButton(notifier.unfollow);
          case FollowNotifierStatus.unfollowed:
            return unfollowButton(notifier.follow);
        }
      },
    );
  }
}

class FollowListComponent extends StatelessWidget {
  const FollowListComponent({
    super.key,
    required this.user,
    required this.followApi,
    this.scrollController,
    this.isFollowed = false,
  });

  final FollowApi followApi;
  final PublicUser user;
  final ScrollController? scrollController;
  final bool isFollowed;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: followApi.list(user.id, isFollowed: isFollowed),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingSpinnerComponent();
        }
        var iterableApiResult = snapshot.requireData;
        switch (iterableApiResult) {
          case ApiOkIterable():
            break;
          case ApiErrorIterable():
            return Text('Error: ${iterableApiResult.error}');
        }
        return InfiniteScrollComponent(
          iterableApiResult: iterableApiResult,
          scrollController: scrollController ?? ScrollController(),
          itemBuilder: (context, follow) {
            if (follow.user == null) {
              return Text('User Not Found: ${follow.followedUserId}');
            }
            var user = follow.user!;
            return ListTile(
              leading: ProfileImageComponent(user, width: 48, height: 48),
              title: Text(user.name),
              // TODO(duncan): For long lists this might be really slow
              trailing:
                  isFollowed
                      ? null
                      : FollowIconComponent(followApi: followApi, user: user),
              onTap: () {
                Navigate(context).toPublicProfile(user.id);
              },
            );
          },
        );
      },
    );
  }
}
