import 'package:app_front_talearnt/main.dart';
import 'package:app_front_talearnt/view/auth/find_id_page.dart';
import 'package:app_front_talearnt/view/auth/find_id_success_page.dart';
import 'package:app_front_talearnt/view/auth/find_password_page.dart';
import 'package:app_front_talearnt/view/auth/find_password_success_page.dart';
import 'package:app_front_talearnt/view/auth/reset_password_page.dart';
import 'package:app_front_talearnt/view/auth/sign_up_success_page.dart';
import 'package:app_front_talearnt/view/board/community_board/community_edit1_page.dart';
import 'package:app_front_talearnt/view/board/community_board/community_edit2_page.dart';
import 'package:app_front_talearnt/view/board/community_board/community_edit_preview_page.dart';
import 'package:app_front_talearnt/view/board/match_board/match_board_like_page.dart';
import 'package:app_front_talearnt/view/board/match_board/match_edit1_page.dart';
import 'package:app_front_talearnt/view/board/match_board/match_edit2_page.dart';
import 'package:app_front_talearnt/view/board/match_board/match_edit_preview_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../view/alarm/alarm_page.dart';
import '../view/auth/agreement/privacy_agreement_optional.dart';
import '../view/auth/agreement/privacy_agreement_required.dart';
import '../view/auth/agreement/terms_agreement_optional.dart';
import '../view/auth/agreement/terms_agreement_required.dart';
import '../view/auth/kakao_sign_up_page.dart';
import '../view/auth/login_page.dart';
import '../view/auth/sign_up_main_page.dart';
import '../view/board/board_list.dart';
import '../view/board/community_board/community_board_detail_page.dart';
import '../view/board/community_board/community_board_image_view_detail_page.dart';
import '../view/board/community_board/community_board_image_view_page.dart';
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
import '../view/home_page.dart';
import '../view/keyword/set_talent_keyword_main_page.dart';
import '../view/keyword/set_talent_keyword_success_page.dart';
import '../view/profile/account_delete_complete_page.dart';
import '../view/profile/account_delete_page.dart';
import '../view/profile/account_manage_page.dart';
import '../view/profile/alarm_setting_page.dart';
import '../view/profile/event_notice_page.dart';
import '../view/profile/licenses_page.dart';
import '../view/profile/modify_user_info_page.dart';
import '../view/profile/my_write_page.dart';
import '../view/profile/notice_detail_page.dart';
import '../view/profile/profile_page.dart';
import '../view/profile/user_image_preview_page.dart';

class Routes {
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
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
            path: '/login',
            builder: (BuildContext context, GoRouterState state) {
              return const LoginPage();
            },
          ),
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
            path: '/kakao-sign-up',
            builder: (BuildContext context, GoRouterState state) {
              return const KakaoSignUpPage();
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
            path: '/match-write1',
            builder: (BuildContext context, GoRouterState state) {
              return const MatchWrite1Page();
            },
          ),
          GoRoute(
            path: '/match-write2',
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
          GoRoute(
            path: '/community-board-detail',
            builder: (BuildContext context, GoRouterState state) {
              return const CommunityBoardDetailPage();
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'community-image-view',
                builder: (BuildContext context, GoRouterState state) {
                  return const CommunityBoardImageViewPage();
                },
              ),
              GoRoute(
                path: 'community-image-view-detail',
                builder: (BuildContext context, GoRouterState state) {
                  return const CommunityBoardImageViewDetailPage();
                },
              ),
            ],
          ),
          GoRoute(
            path: '/profile',
            builder: (BuildContext context, GoRouterState state) {
              return const ProfilePage();
            },
          ),
          GoRoute(
            path: '/modify-user-info',
            builder: (BuildContext context, GoRouterState state) {
              return const ModifyUserInfoPage();
            },
          ),
          GoRoute(
            path: '/account-manage',
            builder: (BuildContext context, GoRouterState state) {
              return const AccountManagePage();
            },
          ),
          GoRoute(
            path: '/alarm-setting',
            builder: (BuildContext context, GoRouterState state) {
              return const AlarmSettingPage();
            },
          ),
          GoRoute(
            path: '/licenses',
            builder: (BuildContext context, GoRouterState state) {
              return const LicensesPage();
            },
          ),
          GoRoute(
            path: '/event-notice',
            builder: (BuildContext context, GoRouterState state) {
              return const EventNoticePage();
            },
          ),
          GoRoute(
            path: '/user-image-preview',
            builder: (BuildContext context, GoRouterState state) {
              return const UserImagePreviewPage();
            },
          ),
          GoRoute(
            path: '/match_board_like',
            builder: (BuildContext context, GoRouterState state) {
              return const MatchBoardLikePage();
            },
          ),
          GoRoute(
            path: '/community-edit1',
            builder: (BuildContext context, GoRouterState state) {
              return const CommunityEdit1Page();
            },
          ),
          GoRoute(
            path: '/community-edit2',
            builder: (BuildContext context, GoRouterState state) {
              return const CommunityEdit2Page();
            },
          ),
          GoRoute(
            path: '/community-edit-preview',
            builder: (BuildContext context, GoRouterState state) {
              return const CommunityEditPreviewPage();
            },
          ),
          GoRoute(
            path: '/alarm',
            builder: (BuildContext context, GoRouterState state) {
              return const AlarmPage();
            },
          ),
          GoRoute(
            path: '/my-write',
            builder: (BuildContext context, GoRouterState state) {
              return const MyWritePage();
            },
          ),
          GoRoute(
            path: '/account-delete',
            builder: (BuildContext context, GoRouterState state) {
              return const AccountDeletePage();
            },
          ),
          GoRoute(
            path: '/account-delete-complete',
            builder: (BuildContext context, GoRouterState state) {
              return const AccountDeleteCompletePage();
            },
          ),
          GoRoute(
            path: '/account-delete',
            builder: (BuildContext context, GoRouterState state) {
              return const AccountDeletePage();
            },
          ),
          GoRoute(
            path: '/account-delete-complete',
            builder: (BuildContext context, GoRouterState state) {
              return const AccountDeleteCompletePage();
            },
          ),
          GoRoute(
            path: '/notice-detail',
            builder: (BuildContext context, GoRouterState state) {
              return const NoticeDetailPage();
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
