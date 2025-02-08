import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/bottom_btn.dart';
import 'package:app_front_talearnt/common/widget/obscure_text_field.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:app_front_talearnt/provider/auth/find_password_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final findPasswordProvider = Provider.of<FindPasswordProvider>(context);
    return Scaffold(
      appBar: const TopAppBar(
        content: '비밀번호 재설정',
      ),
      backgroundColor: Palette.bgBackGround,
      body: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '새 비밀번호를 입력해 주세요',
                  style: TextTypes.heading2(color: Palette.text01),
                ),
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  '새 비밀번호',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                ObscureTextField(
                  hint: '영문, 숫자, 특수문자의 조합 8자리 이상',
                  textEditingController:
                      findPasswordProvider.passwordController,
                  textOnChanged: (value) {
                    findPasswordProvider.updatePasswordCheckController(
                        findPasswordProvider.passwordController);
                    findPasswordProvider.chkValidNewPassword();
                  },
                  isObscured: findPasswordProvider.passwordObscure,
                  changeObscured: findPasswordProvider.changePasswordObscure,
                  validType: 'password',
                  focusNode: findPasswordProvider.passwordFocusNode,
                  validFunc: findPasswordProvider.updatePasswordValid,
                  validMessage: findPasswordProvider.passwordValidMessage,
                  isValid: findPasswordProvider.passwordValid,
                ),
                const SizedBox(height: 24.0),
                const Text(
                  '비밀번호 확인',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                ObscureTextField(
                  hint: '비밀번호를 한 번 더 입력해 주세요.',
                  textEditingController:
                      findPasswordProvider.passwordCheckController,
                  textOnChanged: (value) {
                    findPasswordProvider.updatePhoneNumCheckController(
                        findPasswordProvider.passwordCheckController);
                    findPasswordProvider.chkValidNewPassword();
                  },
                  isObscured: findPasswordProvider.passwordCheckObscure,
                  changeObscured:
                      findPasswordProvider.changePasswordCheckObscure,
                  validType: 'passwordCheck',
                  focusNode: findPasswordProvider.passwordCheckFocusNode,
                  validFunc: findPasswordProvider.updatePasswordCheckValid,
                  validMessage: findPasswordProvider.passwordCheckValidMessage,
                  isValid: findPasswordProvider.passwordCheckValid,
                ),
              ],
            ),
          ),
          const Spacer(),
          BottomBtn(
            mediaBottom: MediaQuery.of(context).viewInsets.bottom,
            content: '확인',
            isEnabled: findPasswordProvider.isValidNewPassword,
            onPressed: () {
              context.pop();
            },
          )
        ],
      ),
    );
  }
}
