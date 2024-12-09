import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/provider/auth/find_password_provider.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:app_front_talearnt/view/auth/reset_password_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class FindPasswordSuccessPage extends StatelessWidget {
  const FindPasswordSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final findPasswordProvider = Provider.of<FindPasswordProvider>(context);
    return Scaffold(
      appBar: TopAppBar(
        leftIcon: false,
        first: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/close.svg',
          ),
          onPressed: () {
            findPasswordProvider.clearProvider();
            context.pop();
          },
        ),
      ),
      backgroundColor: Palette.bgBackGround,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              '비밀번호 재설정 링크 발송 완료',
              style: TextTypes.heading(color: Palette.text01),
            ),
            const SizedBox(height: 8),
            Text(
              "인증 메일을 통해 비밀번호 재설정 후 로그인해 주세요",
              style: TextTypes.bodyMedium02(color: Palette.text02),
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
                      "발송 이메일은",
                      style: TextTypes.bodyLarge02(
                        color: Palette.text01,
                      ),
                    ),
                    Text(
                      "${findPasswordProvider.userId.isNotEmpty ? findPasswordProvider.userId.replaceRange(findPasswordProvider.userId.indexOf('@') - 3, findPasswordProvider.userId.indexOf('@'), '***') : ""} 입니다.",
                      style: TextTypes.bodyLarge02(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "${findPasswordProvider.createdAt} 발송",
                      style: TextTypes.caption02(
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
                  child: PrimaryM(
                    content: "로그인",
                    onPressed: () {
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
