import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/theme.dart';
import '../../common/widget/button.dart';
import '../../common/widget/top_app_bar.dart';
import '../../provider/auth/sign_up_provider.dart';

class SignUpSuccessPage extends StatelessWidget {
  const SignUpSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);

    return Scaffold(
      backgroundColor: Palette.bgBackGround,
      appBar: TopAppBar(
        leftIcon: false,
        first: GestureDetector(
            onTap: () {
              signUpProvider.clearProvider();
              context.go('/');
            },
            child: SvgPicture.asset("assets/icons/close.svg")),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 99,
            ),
            SvgPicture.asset('assets/img/success_sign_up_logo.svg'),
            const SizedBox(height: 43),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '성공적으로 가입되었어요',
                  style: TextTypes.heading2(color: Palette.text01),
                ),
                Text(
                  'talearnt에서 만나요!',
                  style: TextTypes.heading2(color: Palette.text01),
                ),
                const SizedBox(height: 12),
                Text(
                  '로그인하시면 더욱 다양한 서비스를',
                  style: TextTypes.bodyMedium01(color: Palette.text02),
                ),
                Text(
                  '제공 받으실 수 있습니다.',
                  style: TextTypes.bodyMedium01(color: Palette.text02),
                ),
              ],
            ),
            const SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PrimaryM(
                content: '로그인 하기',
                onPressed: () {
                  signUpProvider.clearProvider();
                  context.pop();
                },
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SecondaryMGray(
                content: '홈으로 돌아가기',
                onPressed: () {
                  context.go("/");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
