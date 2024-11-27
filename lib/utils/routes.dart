import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../view/auth/login_page.dart';

class Routes {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
        routes: const <RouteBase>[
          // GoRoute(
          //   path: '/sign-up',
          //   builder: (BuildContext context, GoRouterState state) {
          //     return SignUpPage();
          //   },
          // ),
        ],
      ),
    ],
    errorPageBuilder: (BuildContext context, GoRouterState state) {
      return const MaterialPage(
        child: Center(
          child: Text('Page Not Found'),
        ),
      );
    },
  );
}
