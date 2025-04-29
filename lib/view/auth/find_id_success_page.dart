import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/toast_message.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:app_front_talearnt/provider/auth/find_id_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FindIdSuccessPage extends StatelessWidget {
  const FindIdSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final findIdProvider = Provider.of<FindIdProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!findIdProvider.loadFindIdSuccessPage) {
        ToastMessage.show(
          context: context,
          message: '인증이 완료되었습니다.',
          type: 1,
          bottom: 46,
        );
        findIdProvider.afterLoad();
      }
    });
    return Scaffold(
      backgroundColor: Palette.bgBackGround,
      appBar: TopAppBar(
        leftIcon: false,
        first: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/close.svg',
          ),
          onPressed: () {
            findIdProvider.clearProvider();
            context.pop();
            context.pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              '아이디 찾기 완료',
              style: TextTypes.heading2(color: Palette.text01),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "아이디가 ",
                  style: TextTypes.bodyMedium03(color: Palette.text02),
                ),
                Text(
                  "휴대폰 번호로 발송",
                  style: TextTypes.bodyMedium03(color: Palette.error02),
                ),
                Text(
                  "되었습니다.",
                  style: TextTypes.bodyMedium03(color: Palette.text02),
                ),
              ],
            ),
            const SizedBox(height: 48),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Palette.bgUp01,
                border: Border.all(
                  color: Palette.line01,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Column(
                  children: [
                    Text(
                      "고객님의 아이디는",
                      style: TextTypes.body02(
                        color: Palette.text01,
                      ),
                    ),
                    Text(
                      "${findIdProvider.userId.isNotEmpty ? findIdProvider.userId.replaceRange(findIdProvider.userId.indexOf('@') - 3, findIdProvider.userId.indexOf('@'), '***') : ""} 입니다.",
                      style: TextTypes.body02(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "${findIdProvider.createdAt} 가입",
                      style: TextTypes.captionSemi02(
                        color: Palette.text03,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: SecondaryMGray(
                    content: "비밀번호 찾기",
                    onPressed: () {
                      findIdProvider.clearProvider();
                      context.go('/find-password');
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: PrimaryM(
                    content: "로그인",
                    onPressed: () {
                      findIdProvider.clearProvider();
                      context.pop();
                      context.pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
