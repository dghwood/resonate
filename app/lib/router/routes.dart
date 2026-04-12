import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/download.dart';
import 'package:resonate/api/listens.dart';
import 'package:resonate/api/playlist.dart';
import 'package:resonate/api/podcast.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/api/subscription.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/components/common/player/mini_player.dart';
import 'package:resonate/components/common/player/player.dart';
import 'package:resonate/components/login/signin.dart';
import 'package:resonate/components/tabs/home.dart';
import 'package:resonate/components/tabs/pages/edit_profile.dart';
import 'package:resonate/components/tabs/pages/podcast.dart';
import 'package:resonate/components/tabs/pages/settings.dart';
import 'package:resonate/components/tabs/pages/user.dart';
import 'package:resonate/components/tabs/profile.dart';
import 'package:resonate/components/tabs/search.dart';
import 'package:resonate/router/navigation.dart';
import 'package:logging/logging.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/services/player/audio_handler.dart';

final Logger _log = Logger('router');

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: "root",
);

final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: "shell",
);

/* TODO(duncan): Fix the redirection or move it. 

*/
class RouteState {
  RouteState();

  String? path = Routes.signIn;
  AuthUserStatus status = AuthUserStatus.signedOut;
  Map<String, String>? pathParameters;

  void setState(GoRouterState state, AuthUserStatus status) {
    path = state.fullPath;
    pathParameters = state.pathParameters;
    this.status = status;
  }

  String? getPath() {
    if (pathParameters == null) return path;
    var newPath = path;
    for (var key in pathParameters!.keys) {
      newPath = newPath!.replaceAll(':$key', pathParameters![key]!);
    }
    return newPath;
  }
}

final routeState = RouteState();

String? _signInRedirect(BuildContext context, GoRouterState state) {
  AuthUser authUser = context.read();

  _log.info(
    '_signinRedirect::${authUser.status}::${state.fullPath}::${routeState.path}',
  );
  switch (authUser.status) {
    case AuthUserStatus.loading:
      routeState.setState(state, authUser.status);
      return Routes.loading;
    case AuthUserStatus.signedIn:
      var route = state.fullPath == Routes.signIn ? routeState.getPath() : null;
      // var route = state.fullPath == Routes.signIn ? routeState.path : null;
      routeState.setState(state, authUser.status);
      // Note: This doesn't persist the previous screen you were on.
      return state.fullPath == Routes.signIn || state.fullPath == Routes.loading
          ? Routes.home
          : route;
    case AuthUserStatus.signedOut:
      routeState.setState(state, authUser.status);
      return Routes.signIn;
  }
}

final List<RouteBase> sharedRoutes = [
  GoRoute(
    path: Routes.podcast,
    builder: (context, state) {
      _log.info('podcast ${state.pathParameters}');
      var podcastId = state.pathParameters['id'];
      if (podcastId == null) {
        // TODO: Handle 404
        return Text('Podcast ID is required');
      }
      return PodcastPage(
        podcastId: state.pathParameters['id']!,
        authUser: context.read(),
        podcastApi: context.read(),
      );
    },
  ),
  GoRoute(path: Routes.settings, builder: (context, state) => SettingsPage()),
  GoRoute(
    path: Routes.editProfile,
    builder:
        (context, state) => EditProfileComponent(
          authUser: context.read(),
          uploadApi: context.read(),
        ),
  ),
  GoRoute(
    path: Routes.publicProfile,
    builder: (context, state) {
      _log.info('publicUser ${state.pathParameters}');
      var userId = state.pathParameters['id'];
      if (userId == null) {
        return Text('User ID is required');
      }
      return PublicUserProfileComponent(
        userId: userId,
        authUser: context.read(),
        publicUserApi: context.read(),
      );
    },
  ),
];

GoRouter appRouter(AuthUser authUser) => GoRouter(
  redirect: _signInRedirect,
  // Listen to updates from User to refresh the redirects
  refreshListenable: authUser,
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.signIn,
  routes: <RouteBase>[
    GoRoute(
      path: Routes.loading,
      builder: (context, state) {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        _log.info('when does this fire?');
        return AppShellComponent(
          authUser: context.read(),
          databaseService: context.read(),
          playlistApi: AudioHandlerService.instance,
          navigationShell: navigationShell,
          listenApi: ListenApi.instance,
        );
      },
      branches: [
        // Home
        StatefulShellBranch(
          routes: [
            GoRoute(builder: (context, state) => HomePage(), path: Routes.home),
            ...sharedRoutes,
          ],
        ),
        // Search
        StatefulShellBranch(
          routes: [
            GoRoute(
              builder: (context, state) => SearchPageComponent(),
              path: Routes.search,
            ),
            ...sharedRoutes,
          ],
        ),
        // Profile
        StatefulShellBranch(
          routes: [
            GoRoute(
              // TODO(duncan): Update this to consume a user id
              builder: (context, state) {
                var user = context.read<AuthUser>().user;
                if (user == null) {
                  // TODO(duncan): Have a sign in page or something?
                  return Text('User not found');
                }
                // return ProfileComponent(user: user);
                _log.info('profilePage::${user.id}');
                return PublicUserProfileComponent(
                  publicUserApi: context.read(),
                  authUser: context.read(),
                  userId: user.id,
                );
              },
              path: Routes.profile,
              // routes: sharedRoutes,
            ),
            ...sharedRoutes,
          ],
        ),
      ],
    ),
    GoRoute(
      path: Routes.signIn,
      builder: (context, state) {
        return SigninComponent2(authUser: context.read());
      },
    ),
  ],
);

class AppShellComponent extends StatefulWidget {
  const AppShellComponent({
    super.key,
    required this.navigationShell,
    required this.databaseService,
    required this.playlistApi,
    required this.authUser,
    required this.listenApi,
  });

  final StatefulNavigationShell navigationShell;
  final AuthUser authUser;
  final AbstractDatabaseService databaseService;
  final AudioHandlerService playlistApi;
  final ListenApi listenApi;

  @override
  State<AppShellComponent> createState() => _AppShellComponentState();
}

class _AppShellComponentState extends State<AppShellComponent> {
  @override
  void initState() {
    super.initState();
    _setupFuture = _setupPostLogin();
  }

  Future<ApiResult<bool>> _setupPostLogin() async {
    var user = widget.authUser.user;
    if (user == null) return ApiResult.error(Exception('User not found'));
    try {
      await widget.databaseService.init(user.id);
      _log.info('db done');
      // TODO(duncan): Sync the user message
      await widget.authUser.subscriptionApi.init();
      _log.info('subs done');
      widget.listenApi.init();
      _log.info('listens done');
      await widget.authUser.downloadApi.init();
      _log.info('download done');
      await widget.playlistApi.init();
      // _log.info('playlist done');
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
    return ApiResult.ok(true);
  }

  late final Future<ApiResult<bool>> _setupFuture;

  @override
  Widget build(BuildContext context) {
    _log.info('AppShellComponent::build');
    return FutureBuilder(
      future: _setupFuture,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return Material(child: LoadingSpinnerComponent());
        }
        var result = asyncSnapshot.requireData;
        switch (result) {
          case ApiOk():
            break;
          case ApiError():
            return Text('REAL BIG ERROR');
        }
        return Scaffold(
          body: widget.navigationShell,
          bottomSheet: BottomPlayerComponent(
            playerApi: AudioHandlerService.instance,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: widget.navigationShell.currentIndex,
            onTap:
                (index) => widget.navigationShell.goBranch(
                  index,
                  initialLocation: index == widget.navigationShell.currentIndex,
                ),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
            ],
          ),
        );
      },
    );
  }
}
