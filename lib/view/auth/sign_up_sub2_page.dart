import 'package:app_front_talearnt/provider/auth/sign_up_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/theme.dart';
import '../../common/widget/default_text_field.dart';
import '../../common/widget/text_field_label.dart';

class SignUpSub2Page extends StatelessWidget {
  const SignUpSub2Page({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '본인인증을 진행해 주세요.',
          style: TextTypes.heading(color: Palette.text01),
        ),
        const SizedBox(height: 32),
        const TextFieldLabel(
          content: '휴대폰 번호',
        ),
        const SizedBox(height: 4),
        DefaultTextField(
          type: 'default',
          keyboardType: 'num',
          hint: '01012345678',
          textEditingController: signUpProvider.phoneNumController,
          onChanged: (value) {
            signUpProvider.updatePhoneNumController();
          },
          provider: signUpProvider,
          maxTextLength: 11,
          focusNode: signUpProvider.phoneNumFocusNode,
          validMessage: signUpProvider.phoneNumValidMessage,
          isValid: signUpProvider.phoneNumValid,
        ),
        const SizedBox(
          height: 24,
        ),
        Visibility(
          visible: signUpProvider.sendCertNum,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TextFieldLabel(
                content: '인증번호 확인',
              ),
              const SizedBox(height: 4),
              DefaultTextField(
                type: 'cert',
                keyboardType: 'num',
                hint: '인증 번호를 입력해 주세요.',
                textEditingController: signUpProvider.certNumController,
                onChanged: (value) {
                  signUpProvider
                      .updateCerNumController(signUpProvider.certNumController);
                },
                provider: signUpProvider,
                focusNode: signUpProvider.certNumFocusNode,
                maxTextLength: 4,
                isSendAuth: signUpProvider.sendCertNum,
              ),
              const SizedBox(
                height: 24,
              ),
              TextButton(
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                onPressed: () {
                  //인증번호 다시 보내기
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('인증번호가 오지 않는다면? ',
                        style: TextTypes.caption01(color: Palette.text03)),
                    Text(
                      '재전송',
                      style: TextTypes.caption01(color: Palette.text03)
                          .copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: Palette.text03),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
