import 'package:app_front_talearnt/common/common_navigator.dart';
import 'package:app_front_talearnt/provider/auth/find_id_provider.dart';
import 'package:app_front_talearnt/provider/auth/find_password_provider.dart';
import 'package:app_front_talearnt/provider/auth/login_provider.dart';
import 'package:app_front_talearnt/provider/auth/sign_up_provider.dart';
import 'package:app_front_talearnt/provider/auth/storage_provider.dart';
import 'package:app_front_talearnt/provider/talent_board/keyword_provider.dart';
import 'package:app_front_talearnt/provider/talent_board/match_write_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/model/respone/token.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/talent_board_repository.dart';
import '../data/services/authorization_interceptor.dart';
import '../data/services/dio_service.dart';
import '../main.dart';
import '../utils/token_manager.dart';
import '../view_model/auth_view_model.dart';
import '../view_model/talent_board_view_model.dart';
import 'auth/kakao_provider.dart';
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
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
        Provider<AuthorizationInterceptor>(
          create: (context) => AuthorizationInterceptor(
            tokenManager: context.read<TokenManager>(),
            loginProvider: context.read<LoginProvider>(),
          ),
        ),

        // DioService Provider
        Provider<DioService>(
          create: (context) => DioService(
            context.read<TokenManager>(),
            interceptor: context.read<AuthorizationInterceptor>(),
          ),
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
          ),
        ),
        ChangeNotifierProvider<KeywordProvider>(
            create: (_) => KeywordProvider()),
        ChangeNotifierProvider<MatchWriteProvider>(
            create: (_) => MatchWriteProvider()),
        ChangeNotifierProvider<TalentBoardViewModel>(
          create: (context) => TalentBoardViewModel(
            CommonNavigator(navigatorKey),
            TalentBoardRepository(context.read<DioService>()),
            context.read<KeywordProvider>(),
            context.read<MatchWriteProvider>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
