import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/api/user.dart';
import 'package:resonate/components/login/signin.dart';
import 'package:resonate/components/tabs/pages/base.dart';
import 'package:resonate/components/tabs/home.dart';
import 'package:resonate/components/tabs/pages/podcast.dart';
import 'package:resonate/components/tabs/pages/settings.dart';
import 'package:resonate/components/tabs/profile.dart';
import 'package:resonate/components/tabs/search.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/router/navigation.dart';
import 'package:logging/logging.dart';
import 'package:resonate/services/database.dart';

final Logger _log = Logger('router');

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: "root",
);

final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: "shell",
);

final providers = [EmailAuthProvider()];

/* TODO(duncan): Fix the redirection or move it. 

*/

String? _signInRedirect(BuildContext context, GoRouterState state) {
  var authUser = context.read();
  switch (authUser.status) {
    case AuthUserStatus.loading:
      return Routes.loading;
    case AuthUserStatus.signedIn:
      return Routes.home;
    case AuthUserStatus.signedOut:
      return Routes.signIn;
    default:
      return null;
  }
}

String? _OLDsignInRedirect(BuildContext context, GoRouterState state) {
  var user = Provider.of<User>(context, listen: false);
  var redirectPath = state.uri.queryParameters['redirect'];
  _log.info('redirect_path::$redirectPath');
  _log.info('_signInRedirect::${state.fullPath}::${user.signedInStatus}');
  switch (user.signedInStatus) {
    case UserLoginStatus.signedIn:
      switch (state.fullPath) {
        case Routes.loading:
          return redirectPath ?? Routes.home;
        case Routes.signIn:
          return Routes.loading;
        default:
          return null;
      }
    case UserLoginStatus.loading:
      return state.fullPath == Routes.loading
          ? null
          : '${Routes.loading}?${redirectPath != null ? 'redirect=$redirectPath' : ''}';
    case UserLoginStatus.signedOut:
      return state.fullPath == Routes.signIn
          ? null
          : '${Routes.signIn}?redirect=${state.fullPath}';
  }
}

final List<RouteBase> sharedRoutes = [
  GoRoute(
    // redirect: _signInRedirect,
    path: Routes.podcast,
    builder: (context, state) => PodcastPage(),
  ),
  GoRoute(
    // redirect: _signInRedirect,
    path: Routes.settings,
    builder: (context, state) => SettingsPage(),
  ),
];

GoRouter appRouter(User user) => GoRouter(
  // redirect: _signInRedirect,
  // Listen to updates from User to refresh the redirects
  // refreshListenable: user,
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.signIn,
  routes: <RouteBase>[
    GoRoute(
      path: '/loading',
      // redirect: _signInRedirect,
      builder: (context, state) {
        // _log.info('BUILDING LOADING SCREEN');
        // var user = Provider.of<User>(context, listen: false);
        // var db = Provider.of<AbstractDatabaseService>(context, listen: false);
        // var userApi = Provider.of<UserApi>(context, listen: false);
        // var future = db.init().then((_) async {
        //   await for (var response in userApi.get(user.id)) {
        //     // _log.info(response);
        //     switch (response) {
        //       case ApiOk():
        //         _log.info('ApiOk::user signed in');
        //         user.loadFromServer(response.value);
        //         break;
        //       case ApiError():
        //         _log.info('ApiError ${response.error}');
        //         break;
        //     }
        //   }
        // });
        // AbstractDatabaseService db = context.read();
        // return FutureBuilder(
        //   future: db.init().then((_) => true),
        //   builder: (context, snapshot) {
        //     // _log.info(snapshot);
        //     return Scaffold(body: Center(child: CircularProgressIndicator()));
        //   },
        // );
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          body: navigationShell,
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
              routes: sharedRoutes,
            ),
          ],
        ),
        StatefulShellBranch(
          // navigatorKey: _shellNavigatorKeyHome,
          routes: [
            GoRoute(
              // redirect: _signInRedirect,
              builder: (context, state) => SearchComponent(),
              path: Routes.search,
              routes: sharedRoutes,
            ),
          ],
        ),
        StatefulShellBranch(
          // navigatorKey: _shellNavigatorKeyHome,
          routes: [
            GoRoute(
              // redirect: _signInRedirect,
              builder: (context, state) => ProfilePage(),
              path: Routes.profile,
              routes: sharedRoutes,
            ),
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
    // GoRoute(
    //   path: Routes.signIn,
    //   // redirect: (context, state) {
    //   //   var user = Provider.of<User>(context, listen: false);
    //   //   switch (user.signedInStatus) {
    //   //     case UserLoginStatus.signedIn:
    //   //       return Routes.home;
    //   //     case UserLoginStatus.loading:
    //   //       return Routes.loading;
    //   //     case UserLoginStatus.signedOut:
    //   //       return null;
    //   //   }
    //   // },
    //   builder: (context, state) {
    //     return SignInScreen(
    //       providers: providers,
    //       headerBuilder: (context, constraints, shrinkOffset) {
    //         return AppBar(title: Text('SignIn'));
    //       },
    //       actions: [
    //         // AuthStateChangeAction<UserCreated>((context, state) {
    //         //   // This should redirect somewhere else?
    //         //   Navigate(context).toHome();
    //         // }),
    //         // AuthStateChangeAction<SignedIn>((context, state) {
    //         //   Navigate(context).toHome();
    //         // }),
    //       ],
    //     );
    //   },
    // ),
  ],
);
