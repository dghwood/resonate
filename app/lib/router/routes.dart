import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/podcast.dart';
import 'package:resonate/components/common/player.dart';
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

final Logger _log = Logger('router');

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: "root",
);

final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: "shell",
);

/* TODO(duncan): Fix the redirection or move it. 

*/

String? _signInRedirect(BuildContext context, GoRouterState state) {
  AuthUser authUser = context.read();
  _log.info('_signinRedirect::${authUser.status}::${state.fullPath}');
  switch (authUser.status) {
    case AuthUserStatus.loading:
      return Routes.loading;
    case AuthUserStatus.signedIn:
      // Note: This doesn't persist the previous screen you were on.
      return state.fullPath == Routes.loading ? Routes.home : null;
    case AuthUserStatus.signedOut:
      return Routes.signIn;
    default:
      return null;
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
        return Scaffold(
          body: navigationShell,
          bottomSheet: BottomPlayerComponent(playerApi: context.read()),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navigationShell.currentIndex,
            onTap:
                (index) => navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                ),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
            ],
          ),
        );
      },
      branches: [
        // Home
        StatefulShellBranch(
          // navigatorKey: _shellNavigatorKeyHome,
          routes: [
            GoRoute(
              // redirect: _signInRedirect,
              builder: (context, state) => HomePage(),
              path: Routes.home,
              // routes: sharedRoutes,
            ),
            ...sharedRoutes,
          ],
        ),
        StatefulShellBranch(
          // navigatorKey: _shellNavigatorKeyHome,
          routes: [
            GoRoute(
              // redirect: _signInRedirect,
              builder: (context, state) => SearchComponent(),
              path: Routes.search,
              // routes: sharedRoutes,
            ),
            ...sharedRoutes,
          ],
        ),
        StatefulShellBranch(
          // navigatorKey: _shellNavigatorKeyHome,
          routes: [
            GoRoute(
              // TODO(duncan): Update this to consume a user id
              builder: (context, state) {
                var user = context.read<AuthUser>().user;
                if (user == null) {
                  return Text('User not found');
                }
                return ProfileComponent(user: user);
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
