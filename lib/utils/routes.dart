import 'package:app_front_talearnt/view/auth/find_password_page.dart';
import 'package:app_front_talearnt/view/auth/find_password_success_page.dart';
import 'package:app_front_talearnt/view/auth/reset_password_page.dart';
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
        routes: <RouteBase>[
          GoRoute(
            path: '/find-password',
            builder: (BuildContext context, GoRouterState state) {
              return const FindPasswordPage();
            },
          ),
          GoRoute(
            path: '/find-password-success',
            builder: (BuildContext context, GoRouterState state) {
              return const FindPasswordSuccessPage();
            },
          ),
          GoRoute(
            path: '/reset-password',
            builder: (BuildContext context, GoRouterState state) {
              return const ResetPasswordPage();
            },
          ),
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
