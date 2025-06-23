import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:resonate/components/app.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: "root",
);
final providers = [EmailAuthProvider()];

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation:
      auth.FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/',
  routes: <RouteBase>[
    ShellRoute(
      builder: (context, state, child) {
        return ResonateScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return Text('home');
          },
        ),
        GoRoute(
          path: '/sign-in',
          builder: (context, state) {
            return SignInScreen(
              providers: providers,
              headerBuilder: (context, constraints, shrinkOffset) {
                return AppBar(title: Text('SignIn'));
              },
              actions: [
                AuthStateChangeAction<UserCreated>((context, state) {
                  // Put any new user logic here
                  context.go('/profile-page');
                }),
                AuthStateChangeAction<SignedIn>((context, state) {
                  context.go('/profile-page');
                }),
              ],
            );
          },
        ),
        GoRoute(
          path: '/profile-page',
          builder: (context, state) {
            // This is kinda useless boilerplate something..
            return ProfileScreen(
              providers: providers,
              actions: [
                SignedOutAction((context) {
                  context.go('/sign-in');
                }),
              ],
            );
          },
        ),
      ],
    ),
  ],
);
