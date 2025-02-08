import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/theme.dart';
import '../../common/widget/button.dart';
import '../../common/widget/top_app_bar.dart';
import '../../provider/auth/sign_up_provider.dart';

class SetTalentKeywordSuccessPage extends StatelessWidget {
  const SetTalentKeywordSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);

    return Scaffold(
      backgroundColor: Palette.bgBackGround,
      appBar: TopAppBar(
        leftIcon: false,
        first: GestureDetector(
            onTap: () {
              signUpProvider.resetSignUp();
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
            SvgPicture.asset(
                'assets/icons/set_talent_keyword_success_logo.svg'),
            const SizedBox(height: 43),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '맞춤 키워드 등록이',
                  style: TextTypes.heading2(color: Palette.text01),
                ),
                Text(
                  '완료되었습니다.',
                  style: TextTypes.heading2(color: Palette.text01),
                ),
                const SizedBox(height: 16),
                Text(
                  '이제 서로의 재능들을 교환해 보세요!',
                  style: TextTypes.bodyMedium01(color: Palette.text02),
                ),
              ],
            ),
            const SizedBox(height: 56),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PrimaryM(
                content: '매칭 게시물 보러가기',
                onPressed: () {
                  context.go('/home');
                },
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SecondaryMGray(
                content: '인증서류 등록하기',
                onPressed: () {
                  //이거 없어질듯?
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
