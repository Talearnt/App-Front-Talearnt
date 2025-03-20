import 'package:app_front_talearnt/common/widget/default_text_field.dart';
import 'package:app_front_talearnt/common/widget/obscure_text_field.dart';
import 'package:app_front_talearnt/common/widget/text_field_label.dart';
import 'package:app_front_talearnt/common/widget/toast_message.dart';
import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/theme.dart';
import '../../../data/services/secure_storage_service.dart';
import '../../../provider/auth/login_provider.dart';
import '../../../view_model/auth_view_model.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);
    final commonProvider = Provider.of<CommonProvider>(context);
    final secureStorageService = Provider.of<SecureStorageService>(context);

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
        const SizedBox(height: 12.0),
        InkWell(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          onTap: () {
            loginProvider.setAutoLogin();
          },
          child: Row(
            children: [
              loginProvider.autoLoggedIn
                  ? SvgPicture.asset("assets/icons/check_on_primary.svg")
                  : SvgPicture.asset("assets/icons/check_off_primary.svg"),
              const SizedBox(
                width: 8,
              ),
              Text(
                '자동 로그인',
                style: TextTypes.caption01(color: Palette.text02),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24.0),
        ElevatedButton(
          onPressed: () async {
            if (loginProvider.checkLoginValidity()) {
              if (loginProvider.autoLoggedIn) {
                secureStorageService.write(
                    key: "email", value: loginProvider.emailController.text);
                secureStorageService.write(
                    key: "password",
                    value: loginProvider.passwordController.text);
              } else {
                secureStorageService.delete(key: "email");
                secureStorageService.delete(key: "password");
              }
              commonProvider.changeIsLoading(true);
              await authViewModel.login(loginProvider.emailController.text,
                  loginProvider.passwordController.text);
              commonProvider.changeIsLoading(false);
              // await talentBoardViewModel.getKeywords(); 하드코딩으로 대체
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
            loginProvider.testAutoLogin();
            commonProvider.changeIsLoading(true);
            await authViewModel
                .login(loginProvider.emailController.text,
                    loginProvider.passwordController.text)
                .whenComplete(
              () {
                commonProvider.changeIsLoading(false);
              },
            ).then(
              (value) {
                ToastMessage.show(
                  context: context,
                  message: "로그인에 성공하였습니다.",
                  type: 1,
                  bottom: 50,
                );
              },
            );
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
              'Test자동로그인',
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
                  context.push('/sign-up');
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
