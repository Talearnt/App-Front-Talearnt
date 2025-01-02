import 'package:app_front_talearnt/common/common_navigator.dart';
import 'package:app_front_talearnt/provider/auth/find_id_provider.dart';
import 'package:app_front_talearnt/provider/auth/find_password_provider.dart';
import 'package:app_front_talearnt/provider/auth/login_provider.dart';
import 'package:app_front_talearnt/provider/talearnt_board/match_write_provider.dart';
import 'package:app_front_talearnt/provider/auth/sign_up_provider.dart';
import 'package:app_front_talearnt/provider/auth/storage_provider.dart';
import 'package:app_front_talearnt/provider/talearnt_board/keyword_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/model/respone/token.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/taleant_board_repository.dart';
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
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
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
            AuthRepository(),
            TokenManager(Token.empty()),
            context.read<FindIdProvider>(),
            context.read<FindPasswordProvider>(),
            CommonNavigator(navigatorKey),
            context.read<StorageProvider>(),
          ),
        ),
        ChangeNotifierProvider<KeywordProvider>(
            create: (_) => KeywordProvider()),
        ChangeNotifierProvider<MatchWriteProvider>(
            create: (_) => MatchWriteProvider()),
        ChangeNotifierProvider<TalearntBoardViewModel>(
          create: (context) => TalearntBoardViewModel(
            CommonNavigator(navigatorKey),
            TalearntBoardRepository(),
            context.read<KeywordProvider>(),
            context.read<MatchWriteProvider>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
