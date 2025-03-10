import 'package:app_front_talearnt/main.dart';
import 'package:app_front_talearnt/view/auth/find_id_page.dart';
import 'package:app_front_talearnt/view/auth/find_id_success_page.dart';
import 'package:app_front_talearnt/view/auth/find_password_page.dart';
import 'package:app_front_talearnt/view/auth/find_password_success_page.dart';
import 'package:app_front_talearnt/view/auth/reset_password_page.dart';
import 'package:app_front_talearnt/view/auth/sign_up_success_page.dart';
import 'package:app_front_talearnt/view/board/match_board/match_edit1_page.dart';
import 'package:app_front_talearnt/view/board/match_board/match_edit2_page.dart';
import 'package:app_front_talearnt/view/board/match_board/match_edit_preview_page.dart';
import 'package:app_front_talearnt/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../view/auth/agreement/privacy_agreement_optional.dart';
import '../view/auth/agreement/privacy_agreement_required.dart';
import '../view/auth/agreement/terms_agreement_optional.dart';
import '../view/auth/agreement/terms_agreement_required.dart';
import '../view/auth/login_page.dart';
import '../view/auth/sign_up_main_page.dart';
import '../view/board/board_list.dart';
import '../view/board/community_board/community_write1_page.dart';
import '../view/board/community_board/community_write2_page.dart';
import '../view/board/community_board/community_write_preview_page.dart';
import '../view/board/match_board/match_board_detail_page.dart';
import '../view/board/match_board/match_board_image_view_detail_page.dart';
import '../view/board/match_board/match_board_image_view_page.dart';
import '../view/board/match_board/match_write1_page.dart';
import '../view/board/match_board/match_write2_page.dart';
import '../view/board/match_board/match_write_preview_page.dart';
import '../view/board/write_success_page.dart';
import '../view/keyword/set_talent_keyword_main_page.dart';
import '../view/keyword/set_talent_keyword_success_page.dart';

class Routes {
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
        // redirect: (context, state) async {
        //   final secureStorageService = context.read<SecureStorageService>();
        //   final userId = await secureStorageService.read(key: "email");
        //   final password = await secureStorageService.read(key: "password");
        //   if (!secureStorageService.isLoggedIn) {
        //     getUserProfile();
        //     return '/home';
        //   }
        //   return null;
        // },
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
          GoRoute(
            path: '/set-keyword',
            builder: (BuildContext context, GoRouterState state) {
              return const SetTalentKeywordMainPage();
            },
          ),
          GoRoute(
            path: '/set-keyword-success',
            builder: (BuildContext context, GoRouterState state) {
              return const SetTalentKeywordSuccessPage();
            },
          ),
          GoRoute(
            path: '/match_write1',
            builder: (BuildContext context, GoRouterState state) {
              return const MatchWrite1Page();
            },
          ),
          GoRoute(
            path: '/match_write2',
            builder: (BuildContext context, GoRouterState state) {
              return const MatchWrite2Page();
            },
          ),
          GoRoute(
            path: '/match-write-preview',
            builder: (BuildContext context, GoRouterState state) {
              return const MatchWritePreviewPage();
            },
          ),
          GoRoute(
            path: '/write-success',
            builder: (BuildContext context, GoRouterState state) {
              return const WriteSuccessPage();
            },
          ),
          GoRoute(
            path: '/terms-agree-required',
            builder: (BuildContext context, GoRouterState state) {
              return const TermsAgreementRequired();
            },
          ),
          GoRoute(
            path: '/privacy-agree-required',
            builder: (BuildContext context, GoRouterState state) {
              return const PrivacyAgreementRequired();
            },
          ),
          GoRoute(
            path: '/privacy-agree-optional',
            builder: (BuildContext context, GoRouterState state) {
              return const PrivacyAgreementOptional();
            },
          ),
          GoRoute(
            path: '/terms-agree-optional',
            builder: (BuildContext context, GoRouterState state) {
              return const TermsAgreementOptional();
            },
          ),
          GoRoute(
            path: '/board-list',
            builder: (BuildContext context, GoRouterState state) {
              return const BoardList();
            },
          ),
          GoRoute(
            path: '/home',
            builder: (BuildContext context, GoRouterState state) {
              return const HomePage();
            },
          ),
          GoRoute(
            path: '/match-board-detail-page',
            builder: (BuildContext context, GoRouterState state) {
              return const MatchBoardDetailPage();
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'match-image-view',
                builder: (BuildContext context, GoRouterState state) {
                  return const MatchBoardImageViewPage();
                },
              ),
              GoRoute(
                path: 'match-image-view-detail',
                builder: (BuildContext context, GoRouterState state) {
                  return const MatchBoardImageViewDetailPage();
                },
              ),
            ],
          ),
          GoRoute(
            path: '/community-write1',
            builder: (BuildContext context, GoRouterState state) {
              return const CommunityWrite1Page();
            },
          ),
          GoRoute(
            path: '/community-write2',
            builder: (BuildContext context, GoRouterState state) {
              return const CommunityWrite2Page();
            },
          ),
          GoRoute(
            path: '/community-preview',
            builder: (BuildContext context, GoRouterState state) {
              return const CommunityWritePreviewPage();
            },
          ),
          GoRoute(
            path: '/match-edit1',
            builder: (BuildContext context, GoRouterState state) {
              return const MatchEdit1Page();
            },
          ),
          GoRoute(
            path: '/match-edit2',
            builder: (BuildContext context, GoRouterState state) {
              return const MatchEdit2Page();
            },
          ),
          GoRoute(
            path: '/match-edit-preview',
            builder: (BuildContext context, GoRouterState state) {
              return const MatchEditPreviewPage();
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
