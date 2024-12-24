import 'package:app_front_talearnt/common/widget/default_text_field.dart';
import 'package:app_front_talearnt/common/widget/obscure_text_field.dart';
import 'package:app_front_talearnt/common/widget/text_field_label.dart';
import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/theme.dart';
import '../../../provider/auth/login_provider.dart';
import '../../../view_model/auth_view_model.dart';
import '../../../view_model/talearnt_board_view_model.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);
    final talearntBoardViewModel = Provider.of<TalearntBoardViewModel>(context);
    final commonProvider = Provider.of<CommonProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TextFieldLabel(
          content: '아이디(이메일)',
        ),
        const SizedBox(height: 4),
        DefaultTextField(
          type: 'default',
          hint: '메일을 입력해주세요',
          textEditingController: loginProvider.emailController,
          onChanged: (value) {
            loginProvider.updateController(loginProvider.emailController);
          },
          provider: loginProvider,
          validType: 'email',
          focusNode: loginProvider.emailFocusNode,
          validFunc: loginProvider.updateEmailValid,
          validMessage: loginProvider.emailValidMessage,
          isValid: loginProvider.emailValid,
        ),
        const SizedBox(height: 16.0),
        const TextFieldLabel(
          content: '비밀번호',
        ),
        const SizedBox(height: 4),
        ObscureTextField(
          hint: '비밀번호를 입력해주세요',
          textEditingController: loginProvider.passwordController,
          textOnChanged: (value) {
            loginProvider.updateController(loginProvider.passwordController);
          },
          isObscured: loginProvider.passwordObscure,
          changeObscured: loginProvider.changePasswordObscure,
          validType: 'password',
          focusNode: loginProvider.passwordFocusNode,
          validFunc: loginProvider.updatePasswordValid,
          validMessage: loginProvider.passwordValidMessage,
          isValid: loginProvider.passwordValid,
        ),
        const SizedBox(height: 24.0),
        ElevatedButton(
          onPressed: () async {
            if (loginProvider.checkLoginValidity()) {
              commonProvider.changeIsLoading(true);
              await authViewModel
                  .login(loginProvider.emailController.text,
                      loginProvider.passwordController.text)
                  .whenComplete(() => commonProvider.changeIsLoading(false));
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1B76FF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(11.5),
            child: Text(
              '로그인',
              style: TextStyle(fontSize: 18, color: Color(0xFFFFFFFF)),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            await talearntBoardViewModel.getKeywords();
            context.go('/set-keyword');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1B76FF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(11.5),
            child: Text(
              '키워드 설정 임시 버튼',
              style: TextStyle(fontSize: 18, color: Color(0xFFFFFFFF)),
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          height: 18,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      context.push('/find-id');
                    },
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                    ),
                    child: Text('아이디 찾기',
                        style: TextTypes.caption01(color: Palette.text03)),
                  ),
                  const SizedBox(
                    height: 12,
                    child: VerticalDivider(width: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      context.push('/find-password');
                    },
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                    ),
                    child: Text('비밀번호 찾기',
                        style: TextTypes.caption01(color: Palette.text03)),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  context.go('/sign-up');
                },
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                  textStyle: WidgetStateProperty.all(
                    const TextStyle(fontSize: 14),
                  ),
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                child: Text('회원가입',
                    style: TextTypes.caption01(color: Palette.text02)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
