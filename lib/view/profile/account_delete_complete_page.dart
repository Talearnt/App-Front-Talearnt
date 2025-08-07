import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/theme.dart';
import '../../common/widget/button.dart';
import '../../common/widget/top_app_bar.dart';
import '../../provider/common/common_provider.dart';

class AccountDeleteCompletePage extends StatelessWidget {
  const AccountDeleteCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    final commonProvider = Provider.of<CommonProvider>(context);

    return Scaffold(
      appBar: TopAppBar(
        content: '',
        leftIcon: false,
        first: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/close.svg',
          ),
          onPressed: () {
            commonProvider.changeSelectedPage('home');
            context.go('/');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Text(
              '회원 탈퇴가 완료되었어요',
              style: TextTypes.heading2(color: Palette.text01),
            ),
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Palette.bgUp01,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Palette.line01,
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '○○○○○○○○○○○○님과\n함께한 시간, 저희는 절대 잊지 않을게요\n탤런트는 언제나\n여러분의 성장을 응원하겠습니다!',
                    style: TextTypes.body02(color: Palette.text01),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '혹시라도 다시 돌아오고 싶으시다면,\n7일 후 재가입이 가능해요',
                    style: TextTypes.body02(color: Palette.text01),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '다시 돌아오실 땐\n더 좋은 모습으로 찾아뵐게요!\n기다리고 있겠습니다.',
                    style: TextTypes.body02(color: Palette.text01),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    '탈퇴일자: YYYY.MM.DD hh:mm',
                    style: TextTypes.caption01(color: Palette.primary01),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '탈퇴계정: kim5781020@naver.com',
                    style: TextTypes.caption01(color: Palette.primary01),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            PrimaryM(
              content: '홈으로',
              onPressed: () {
                commonProvider.changeSelectedPage('home');
                context.go('/');
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
