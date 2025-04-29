import 'package:app_front_talearnt/common/common_navigator.dart';
import 'package:app_front_talearnt/data/repositories/keyword_repository.dart';
import 'package:app_front_talearnt/data/repositories/profile_repository.dart';
import 'package:app_front_talearnt/provider/auth/find_id_provider.dart';
import 'package:app_front_talearnt/provider/auth/find_password_provider.dart';
import 'package:app_front_talearnt/provider/auth/login_provider.dart';
import 'package:app_front_talearnt/provider/auth/sign_up_provider.dart';
import 'package:app_front_talearnt/provider/auth/storage_provider.dart';
import 'package:app_front_talearnt/provider/board/common_board_provider.dart';
import 'package:app_front_talearnt/provider/board/match_board_provider.dart';
import 'package:app_front_talearnt/provider/board/match_edit_provider.dart';
import 'package:app_front_talearnt/provider/home/home_provider.dart';
import 'package:app_front_talearnt/provider/keyword/keyword_provider.dart';
import 'package:app_front_talearnt/provider/profile/profile_provider.dart';
import 'package:app_front_talearnt/view_model/keyword_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/model/respone/token.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/board_repository.dart';
import '../data/services/authorization_interceptor.dart';
import '../data/services/dio_service.dart';
import '../data/services/secure_storage_service.dart';
import '../main.dart';
import '../utils/token_manager.dart';
import '../view_model/auth_view_model.dart';
import '../view_model/board_view_model.dart';
import '../view_model/profile_view_model.dart';
import 'auth/kakao_provider.dart';
import 'board/community_board_detail_provider.dart';
import 'board/community_board_provider.dart';
import 'board/community_write_provider.dart';
import 'board/match_board_detail_provider.dart';
import 'board/match_write_provider.dart';
import 'common/common_provider.dart';

class ProviderSetup extends StatelessWidget {
  final Widget child;

  const ProviderSetup({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Provider.debugCheckInvalidValueType = null;
    return MultiProvider(
      providers: [
        Provider<TokenManager>(
          create: (_) => TokenManager(Token.empty()),
        ),
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
        ChangeNotifierProvider<MatchWriteProvider>(
            create: (_) => MatchWriteProvider()),
        ChangeNotifierProvider<MatchEditProvider>(
            create: (_) => MatchEditProvider()),
        ChangeNotifierProvider<CommunityWriteProvider>(
            create: (_) => CommunityWriteProvider()),
        Provider<AuthorizationInterceptor>(
          create: (context) => AuthorizationInterceptor(
            tokenManager: context.read<TokenManager>(),
            loginProvider: context.read<LoginProvider>(),
            matchWriteProvider: context.read<MatchWriteProvider>(),
            matchEditProvider: context.read<MatchEditProvider>(),
            communityWriteProvider: context.read<CommunityWriteProvider>(),
          ),
        ),

        // DioService Provider
        Provider<DioService>(
          create: (context) => DioService(
            context.read<TokenManager>(),
            interceptor: context.read<AuthorizationInterceptor>(),
          ),
        ),
        Provider<SecureStorageService>(
          create: (context) => SecureStorageService(),
        ),
        ChangeNotifierProvider<CommonProvider>(create: (_) => CommonProvider()),
        ChangeNotifierProvider<KakaoProvider>(create: (_) => KakaoProvider()),
        ChangeNotifierProvider<SignUpProvider>(create: (_) => SignUpProvider()),
        ChangeNotifierProvider<FindIdProvider>(create: (_) => FindIdProvider()),
        Provider<CommonNavigator>(create: (_) => CommonNavigator(navigatorKey)),
        ChangeNotifierProvider<StorageProvider>(
            create: (_) => StorageProvider()),
        ChangeNotifierProvider<FindPasswordProvider>(
            create: (_) => FindPasswordProvider()),
        ChangeNotifierProvider<ProfileProvider>(
            create: (_) => ProfileProvider()),
        ChangeNotifierProvider<ProfileViewModel>(
          create: (context) => ProfileViewModel(
            CommonNavigator(navigatorKey),
            ProfileRepository(context.read<DioService>()),
            context.read<ProfileProvider>(),
          ),
        ),
        ChangeNotifierProvider<AuthViewModel>(
          create: (context) => AuthViewModel(
            context.read<LoginProvider>(),
            context.read<SignUpProvider>(),
            AuthRepository(context.read<DioService>()),
            context.read<TokenManager>(),
            context.read<FindIdProvider>(),
            context.read<FindPasswordProvider>(),
            CommonNavigator(navigatorKey),
            context.read<StorageProvider>(),
            context.read<CommonProvider>(),
            context.read<ProfileViewModel>(),
          ),
        ),
        ChangeNotifierProvider<KeywordProvider>(
            create: (_) => KeywordProvider()),
        ChangeNotifierProvider<CommonBoardProvider>(
            create: (_) => CommonBoardProvider()),
        ChangeNotifierProvider<MatchBoardProvider>(
            create: (_) => MatchBoardProvider()),
        ChangeNotifierProvider<CommunityBoardProvider>(
            create: (_) => CommunityBoardProvider()),
        ChangeNotifierProvider<MatchBoardDetailProvider>(
            create: (_) => MatchBoardDetailProvider()),
        ChangeNotifierProvider<CommunityBoardDetailProvider>(
            create: (_) => CommunityBoardDetailProvider()),
        ChangeNotifierProvider<BoardViewModel>(
          create: (context) => BoardViewModel(
            CommonNavigator(navigatorKey),
            BoardRepository(context.read<DioService>()),
            context.read<KeywordProvider>(),
            context.read<MatchWriteProvider>(),
            context.read<MatchBoardProvider>(),
            context.read<MatchBoardDetailProvider>(),
            context.read<MatchEditProvider>(),
            context.read<CommunityBoardProvider>(),
            context.read<HomeProvider>(),
            context.read<CommunityWriteProvider>(),
            context.read<CommunityBoardDetailProvider>(),
            context.read<HomeProvider>(),
          ),
        ),
        ChangeNotifierProvider<KeywordViewModel>(
          create: (context) => KeywordViewModel(
            CommonNavigator(navigatorKey),
            KeywordRepository(context.read<DioService>()),
            context.read<KeywordProvider>(),
            context.read<MatchWriteProvider>(),
            context.read<MatchBoardProvider>(),
            context.read<MatchEditProvider>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
