import 'package:app_front_talearnt/common/widget/toast_message.dart';
import 'package:app_front_talearnt/provider/auth/sign_up_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/theme.dart';
import '../../common/widget/button.dart';
import '../../common/widget/default_text_field.dart';
import '../../common/widget/loading.dart';
import '../../common/widget/text_field_label.dart';
import '../../provider/common/common_provider.dart';
import '../../view_model/auth_view_model.dart';

class SignUpSub2Page extends StatelessWidget {
  const SignUpSub2Page({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);
    final commonProvider = Provider.of<CommonProvider>(context);

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '본인인증을 진행해 주세요.',
              style: TextTypes.heading2(color: Palette.text01),
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
              isEnabled: signUpProvider.isPhoneNumEnabled,
              textEditingController: signUpProvider.phoneNumController,
              onChanged: (value) {
                signUpProvider
                    .updateController(signUpProvider.phoneNumController);
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
                    timeSeconds: signUpProvider.certTimerSeconds,
                    keyboardType: 'num',
                    hint: '인증 번호를 입력해 주세요.',
                    isEnabled: signUpProvider.isCertNumEnabled,
                    textEditingController: signUpProvider.certNumController,
                    onChanged: (value) {
                      signUpProvider.updateCerNumController(
                          signUpProvider.certNumController);
                    },
                    provider: signUpProvider,
                    focusNode: signUpProvider.certNumFocusNode,
                    maxTextLength: 4,
                    isSendAuth: signUpProvider.sendCertNum,
                    isValid: signUpProvider.cerNumValid,
                    validMessage: signUpProvider.cerNumValidMessage,
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
                        TextLineS(
                          content: '재전송',
                          onPressed: () async {
                            commonProvider.changeIsLoading(true);
                            await authViewModel
                                .reSendCertNum(context, 'signUp', null,
                                    signUpProvider.phoneNumController.text)
                                .whenComplete(
                              () {
                                commonProvider.changeIsLoading(false);
                              },
                            ).then(
                              (value) {
                                ToastMessage.show(
                                  context: context,
                                  message: '인증번호를 재요청 하였습니다.',
                                  type: 2,
                                  bottom: 62,
                                );
                              },
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (commonProvider.isLoadingPage) const Loading(),
      ],
    );
  }
}
