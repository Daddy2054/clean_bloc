import 'dart:async';

import 'package:clean_bloc/src/features/auth/presentation/view/login_screen.dart';
import 'package:clean_bloc/src/features/auth/presentation/view/signup_screen.dart';
import 'package:clean_bloc/src/features/feed/presentation/view/discover_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/feed/presentation/view/feed_screen.dart';

class AppRouter {
  //TODO: Add the auth bloc as an input
  AppRouter();
  late final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        name: 'feed',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const FeedScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            name: 'discover',
            path: 'discover',
            builder: (BuildContext context, GoRouterState state) {
              return const DiscoverScreen();
            },
            routes: [
              GoRoute(
                path: 'userId',
                name: 'user',
                builder: (BuildContext context, GoRouterState state) {
                  return Container();
                },
              ),
            ],
          ),
          GoRoute(
            name: 'login',
            path: 'login',
            builder: (BuildContext context, GoRouterState state) {
              return const LoginScreen();
            },
            routes: [
              GoRoute(
                path: 'signup',
                name: 'signup',
                builder: (BuildContext context, GoRouterState state) {
                  return const SignupScreen();
                },
              ),
            ],
          ),
        ],
        //TODO: Redirect users to the login screen if they're not authenticated
        //Else, go to the feed screen
        //redirect:
      ),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  /// Creates a [GoRouterRefreshStream].
  ///
  /// Every time the [stream] receives an event the [GoRouter] will refresh its
  /// current route.
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
