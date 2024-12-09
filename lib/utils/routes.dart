import 'package:app_front_talearnt/view/auth/find_id_page.dart';
import 'package:app_front_talearnt/view/auth/find_id_success_page.dart';
import 'package:app_front_talearnt/view/auth/find_password_page.dart';
import 'package:app_front_talearnt/view/auth/find_password_success_page.dart';
import 'package:app_front_talearnt/view/auth/reset_password_page.dart';
import 'package:app_front_talearnt/view/auth/sign_up_success_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../view/auth/login_page.dart';
import '../view/auth/sign_up_main_page.dart';

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
            path: '/find-id',
            builder: (BuildContext context, GoRouterState state) {
              return const FindIdPage();
            },
          ),
          GoRoute(
            path: '/find-id-success',
            builder: (BuildContext context, GoRouterState state) {
              return const FindIdSuccessPage();
            },
          ),
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
              }),
          GoRoute(
            path: '/sign-up',
            builder: (BuildContext context, GoRouterState state) {
              return const SignUpMainPage();
            },
          ),
          GoRoute(
            path: '/sign-up-success',
            builder: (BuildContext context, GoRouterState state) {
              return const SignUpSuccessPage();
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
