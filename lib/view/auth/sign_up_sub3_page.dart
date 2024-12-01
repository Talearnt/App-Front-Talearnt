import 'package:app_front_talearnt/provider/auth/sign_up_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/theme.dart';
import '../../common/widget/default_text_field.dart';
import '../../common/widget/obscure_text_field.dart';
import '../../common/widget/text_field_label.dart';

class SignUpSub3Page extends StatelessWidget {
  const SignUpSub3Page({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);

    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '로그인에 사용할',
              style: TextTypes.heading(color: Palette.text01),
            ),
            Text(
              '회원정보를 입력해 주세요.',
              style: TextTypes.heading(color: Palette.text01),
            ),
            const SizedBox(
              height: 24,
            ),
            const TextFieldLabel(
              content: '성별',
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      signUpProvider.changeGender(0);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: signUpProvider.gender == 0
                          ? Palette.primary01
                          : Palette.line01,
                      side: BorderSide(
                          color: signUpProvider.gender == 0
                              ? Palette.primary01
                              : Palette.line01),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 0,
                      shadowColor:
                          Colors.transparent, // hover 시 주변 뿌옇게 되는 효과 제거
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(11.5),
                      child: Text(
                        '남자',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      signUpProvider.changeGender(1);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: signUpProvider.gender == 1
                          ? Colors.blue
                          : Colors.grey,
                      side: BorderSide(
                          color: signUpProvider.gender == 1
                              ? Colors.blue
                              : Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(11.5),
                      child: Text(
                        '여자',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            const TextFieldLabel(
              content: '닉네임',
            ),
            const SizedBox(height: 4),
            DefaultTextField(
              type: 'default',
              hint: '닉네임을 입력해주세요',
              textEditingController: signUpProvider.nickNameController,
              onChanged: (value) {
                signUpProvider
                    .updateController(signUpProvider.nickNameController);
              },
              provider: signUpProvider,
              validType: 'nickName',
              focusNode: signUpProvider.nickNameFocusNode,
              validFunc: signUpProvider.updateNickNameValid,
              validMessage: signUpProvider.nickNameValidMessage,
              isValid: signUpProvider.nickNameValid,
            ),
            const SizedBox(height: 24.0),
            const TextFieldLabel(
              content: '이름',
            ),
            const SizedBox(height: 4),
            DefaultTextField(
              type: 'default',
              hint: '이름을 입력해주세요',
              textEditingController: signUpProvider.nameController,
              onChanged: (value) {
                signUpProvider.updateController(signUpProvider.nameController);
              },
              provider: signUpProvider,
              validType: 'name',
              focusNode: signUpProvider.nameFocusNode,
              validFunc: signUpProvider.updateNameValid,
              validMessage: signUpProvider.nameValidMessage,
              isValid: signUpProvider.nameValid,
            ),
            const SizedBox(height: 24.0),
            const TextFieldLabel(
              content: '이메일',
            ),
            const SizedBox(height: 4),
            DefaultTextField(
              type: 'default',
              hint: '메일을 입력해주세요',
              textEditingController: signUpProvider.emailController,
              onChanged: (value) {
                signUpProvider.updateController(signUpProvider.emailController);
              },
              provider: signUpProvider,
              validType: 'email',
              focusNode: signUpProvider.emailFocusNode,
              validFunc: signUpProvider.updateEmailValid,
              validMessage: signUpProvider.emailValidMessage,
              isValid: signUpProvider.emailValid,
            ),
            const SizedBox(height: 24.0),
            const TextFieldLabel(
              content: '비밀번호',
            ),
            const SizedBox(height: 4),
            ObscureTextField(
              hint: '영문, 숫자, 특수문자의 조합 8자리 이상',
              textEditingController: signUpProvider.passwordController,
              textOnChanged: (value) {
                signUpProvider.updatePhoneNumCheckController(
                    signUpProvider.passwordController);
              },
              isObscured: signUpProvider.passwordObscure,
              changeObscured: signUpProvider.changePasswordObscure,
              validType: 'password',
              focusNode: signUpProvider.passwordFocusNode,
              validFunc: signUpProvider.updatePasswordValid,
              validMessage: signUpProvider.passwordValidMessage,
              isValid: signUpProvider.passwordValid,
              isOtherValid: true,
              checkOtherValidFun: signUpProvider.checkBeforePasswordValid,
            ),
            const SizedBox(height: 24.0),
            const Text(
              '비밀번호 확인',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            ObscureTextField(
              hint: '비밀번호를 한 번 더 입력해 주세요.',
              textEditingController: signUpProvider.passwordCheckController,
              textOnChanged: (value) {
                signUpProvider.updatePhoneNumCheckController(
                    signUpProvider.passwordCheckController);
              },
              isObscured: signUpProvider.passwordCheckObscure,
              changeObscured: signUpProvider.changePasswordCheckObscure,
              validType: 'passwordCheck',
              focusNode: signUpProvider.passwordCheckFocusNode,
              validFunc: signUpProvider.updatePasswordCheckValid,
              validMessage: signUpProvider.passwordCheckValidMessage,
              isValid: signUpProvider.passwordCheckValid,
            ),
          ]),
    );
  }
}
