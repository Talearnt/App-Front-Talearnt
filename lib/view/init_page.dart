import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/view/widget/loading_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/services/secure_storage_service.dart';
import '../provider/auth/login_provider.dart';
import '../provider/common/common_provider.dart';
import '../view_model/auth_view_model.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  void initState() {
    super.initState();
    _checkAutoLogin();
  }

  Future<void> _checkAutoLogin() async {
    final commonProvider = Provider.of<CommonProvider>(context, listen: false);
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final secureStorageService =
        Provider.of<SecureStorageService>(context, listen: false);
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    final email = await secureStorageService.read(key: "email");
    final password = await secureStorageService.read(key: "password");
    final kakao = await secureStorageService.read(key: "kakao");
    if (kakao != null) {
      commonProvider.changeIsLoading(true);
      await authViewModel.kakaoLogin('login').whenComplete(() {
        commonProvider.changeIsLoading(false);
      });
    } else if (email != null && password != null) {
      loginProvider.saveAutoLogin(true);
      commonProvider.changeIsLoading(true);
      await authViewModel
          .login(email, password, true, loginProvider.loginRoot)
          .whenComplete(() {
        commonProvider.changeIsLoading(false);
      });
    } else {
      if (!mounted) return;
      loginProvider.saveAutoLogin(false);
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgBackGround,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              'assets/img/splash_logo.svg',
            ),
          ),
          const SizedBox(height: 20),
          const LoadingDots(
            dotSize: 10,
            color: Palette.primary01,
          ),
          const SizedBox(height: 20),
          Text(
            "정보를 불러오고 있어요~!",
            style: TextTypes.body02(
              color: Palette.text01,
            ),
          ),
        ],
      ),
    );
  }
}
