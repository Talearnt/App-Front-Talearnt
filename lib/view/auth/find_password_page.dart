import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/bottom_btn.dart';
import 'package:app_front_talearnt/common/widget/default_text_field.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:app_front_talearnt/provider/auth/find_password_provider.dart';
import 'package:app_front_talearnt/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/widget/loading.dart';
import '../../provider/common/common_provider.dart';

class FindPasswordPage extends StatelessWidget {
  const FindPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final findPasswordProvider = Provider.of<FindPasswordProvider>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);
    final commonProvider = Provider.of<CommonProvider>(context);
    return Scaffold(
      appBar: TopAppBar(
        content: "비밀번호 찾기",
        onPressed: () {
          findPasswordProvider.clearProvider();
          context.pop();
        },
      ),
      backgroundColor: Palette.bgBackGround,
      body: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "본인 확인을 통해",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    "비밀번호를 재설정할 수 있어요",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    '이메일',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  DefaultTextField(
                    type: 'default',
                    hint: '메일을 입력해주세요',
                    textEditingController: findPasswordProvider.emailController,
                    onChanged: (value) {
                      findPasswordProvider.updateController(
                          findPasswordProvider.emailController);
                      findPasswordProvider.chkValidEmailAndPhoneNumber();
                    },
                    provider: findPasswordProvider,
                    validType: 'email',
                    focusNode: findPasswordProvider.emailFocusNode,
                    validFunc: findPasswordProvider.updateEmailValid,
                    validMessage: findPasswordProvider.emailValidMessage,
                    isValid: findPasswordProvider.emailValid,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    '휴대폰 번호',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  DefaultTextField(
                    type: 'default',
                    hint: '01012345678 형식으로 입력해주세요',
                    textEditingController:
                        findPasswordProvider.phoneNumberController,
                    keyboardType: "num",
                    validType: 'phone',
                    maxTextLength: 11,
                    onChanged: (value) {
                      findPasswordProvider.updateController(
                          findPasswordProvider.emailController);
                      findPasswordProvider.chkValidEmailAndPhoneNumber();
                    },
                    provider: findPasswordProvider,
                    focusNode: findPasswordProvider.phoneNumberFocusNode,
                    validMessage: findPasswordProvider.phoneNumberValidMessage,
                    validFunc: findPasswordProvider.updatePhoneNumberValid,
                    isValid: findPasswordProvider.phoneNumberValid,
                    isOtherValid: true,
                    checkOtherValidFun:
                        findPasswordProvider.focusPhoneNumberAndEmailEmpty,
                  ),
                ],
              ),
            ),
            const Spacer(),
            BottomBtn(
              mediaBottom: MediaQuery.of(context).viewInsets.bottom,
              content: '비밀번호 찾기',
              isEnabled: findPasswordProvider.isValidEmailAndPhoneNumber,
              onPressed: () async {
                commonProvider.changeIsLoading(true);
                await authViewModel
                    .sendResetPasswordEmail(
                        context,
                        findPasswordProvider.emailController.text,
                        findPasswordProvider.phoneNumberController.text)
                    .whenComplete(() => commonProvider.changeIsLoading(false));

                if (findPasswordProvider.userId.isNotEmpty) {
                  context.go('/find-password-success');
                }
              },
            )
          ],
        ),
        if (commonProvider.isLoadingPage) const Loading()
      ]),
    );
  }
}
