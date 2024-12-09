import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/bottom_btn.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/default_text_field.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:app_front_talearnt/provider/auth/find_id_provider.dart';
import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/auth_view_model.dart';

class FindIdPage extends StatelessWidget {
  const FindIdPage({super.key});

  @override
  Widget build(BuildContext context) {
    final findIdprovider = Provider.of<FindIdProvider>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      backgroundColor: Palette.bgBackGround,
      appBar: TopAppBar(
        content: "아이디 찾기",
        onPressed: () {
          findIdprovider.clearProvider();
          context.pop();
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "사용자의 아이디를 찾습니다",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  '이름',
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
                  hint: '이름을 입력해 주세요',
                  textEditingController: findIdprovider.userNameController,
                  maxTextLength: 5,
                  validType: 'name',
                  isEnabled: !findIdprovider.isCertSend,
                  onChanged: (value) {
                    findIdprovider
                        .updateController(findIdprovider.userNameController);
                    findIdprovider.chkValidEmailAndPhoneNumber();
                  },
                  provider: findIdprovider,
                  focusNode: findIdprovider.userNameFocusNode,
                  validFunc: findIdprovider.updateUserNameValid,
                  validMessage: findIdprovider.userNameMessage,
                  isValid: findIdprovider.userNameValid,
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
                  hint: '01012345678',
                  textEditingController: findIdprovider.phoneNumberController,
                  keyboardType: "num",
                  validType: 'phone',
                  isEnabled: !findIdprovider.isCertSend,
                  maxTextLength: 11,
                  onChanged: (value) {
                    findIdprovider
                        .updateController(findIdprovider.phoneNumberController);
                    findIdprovider.chkValidEmailAndPhoneNumber();
                  },
                  provider: findIdprovider,
                  focusNode: findIdprovider.phoneNumberFocusNode,
                  validFunc: findIdprovider.updatePhoneNumberValid,
                  validMessage: findIdprovider.phoneNumberValidMessage,
                  isValid: findIdprovider.phoneNumberValid,
                  isInfo: findIdprovider.phoneNumberFocusNode.hasFocus,
                  infoMessage: "01012345678 형식으로 입력해 주세요",
                ),
                const SizedBox(
                  height: 24,
                ),
                Visibility(
                  visible: findIdprovider.isCertSend,
                  child: const Text(
                    '인증번호 확인',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Visibility(
                  visible: findIdprovider.isCertSend,
                  child: Consumer<CommonProvider>(
                    builder: (context, value, child) {
                      return DefaultTextField(
                        type: 'cert',
                        hint: '인증번호를 입력해주세요.',
                        textEditingController:
                        findIdprovider.certNumberController,
                        keyboardType: "num",
                        onChanged: (value) {},
                        provider: findIdprovider,
                        focusNode: findIdprovider.certFocusNode,
                        isSendAuth: findIdprovider.isCertSend,
                        isValid: findIdprovider.certNumberValid,
                        validMessage: findIdprovider.certValidMessage,
                        timeSeconds: findIdprovider.certNumSecond,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Visibility(
                  visible: findIdprovider.isCertSend,
                  child: Consumer<CommonProvider>(
                    builder: (subContext, commonProvider, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "인증번호가 오지 않는다면?",
                            style: TextTypes.caption01(
                              color: Palette.text03,
                            ),
                          ),
                          TextLineS(
                            content: "재발송",
                            onPressed: () async {
                              await authViewModel.reSendCertNum(
                                  context,
                                  'findId',
                                  findIdprovider.userNameController.text,
                                  findIdprovider.phoneNumberController.text);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Consumer<CommonProvider>(
            builder: (subContext, commonProvider, child) {
              return findIdprovider.isCertSend
                  ? BottomBtn(
                mediaBottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom,
                content: '인증번호',
                isEnabled: true,
                onPressed: () async {
                  await authViewModel.findUserIdInfo(
                      context,
                      findIdprovider.phoneNumberController.text,
                      findIdprovider.certNumberController.text);

                  if (findIdprovider.userId.isNotEmpty) {
                    findIdprovider.resetTimer();
                    context.go('/find-id-success');
                  }
                },
              )
                  : BottomBtn(
                mediaBottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom,
                content: '인증번호 발송',
                isEnabled: findIdprovider.isValidNameAndPhoneNumber,
                onPressed: findIdprovider.isValidNameAndPhoneNumber
                    ? () async {
                  await authViewModel.sendCertNum(
                      context,
                                  'findId',
                      findIdprovider.userNameController.text,
                      findIdprovider.phoneNumberController.text);
                }
                    : () {},
              );
            },
          )
        ],
      ),
    );
  }
}
