import 'package:app_front_talearnt/provider/auth/find_id_provider.dart';
import 'package:app_front_talearnt/provider/auth/find_password_provider.dart';
import 'package:app_front_talearnt/provider/auth/login_provider.dart';
import 'package:app_front_talearnt/provider/auth/sign_up_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/model/respone/token.dart';
import '../data/repositories/auth_repository.dart';
import '../utils/token_manager.dart';
import '../view_model/auth_view_model.dart';
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
        ChangeNotifierProvider<FindPasswordProvider>(
            create: (_) => FindPasswordProvider()),
        ChangeNotifierProvider<KakaoProvider>(create: (_) => KakaoProvider()),
        ChangeNotifierProvider<SignUpProvider>(create: (_) => SignUpProvider()),
        ChangeNotifierProvider<FindIdProvider>(create: (_) => FindIdProvider()),
        ChangeNotifierProvider<AuthViewModel>(
          create: (context) => AuthViewModel(
            context.read<LoginProvider>(),
            context.read<SignUpProvider>(),
            AuthRepository(),
            TokenManager(Token.empty()),
            context.read<FindIdProvider>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
