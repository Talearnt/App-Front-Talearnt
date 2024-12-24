import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/bottom_btn.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/default_text_field.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:app_front_talearnt/provider/auth/find_id_provider.dart';
import 'package:app_front_talearnt/provider/auth/storage_provider.dart';
import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../view_model/auth_view_model.dart';
import '../../common/widget/loading.dart';

class FindIdPage extends StatelessWidget {
  const FindIdPage({super.key});

  @override
  Widget build(BuildContext context) {
    final findIdProvider = Provider.of<FindIdProvider>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);
    final storageProvider = Provider.of<StorageProvider>(context);
    final commonProvider = Provider.of<CommonProvider>(context);

    return Scaffold(
      backgroundColor: Palette.bgBackGround,
      appBar: TopAppBar(
        content: "아이디 찾기",
        onPressed: () {
          findIdProvider.clearProvider();
          context.pop();
        },
      ),
      body: Stack(
        children: [
          Column(
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
                    const SizedBox(height: 4),
                    DefaultTextField(
                      type: 'default',
                      hint: '이름을 입력해 주세요',
                      textEditingController: findIdProvider.userNameController,
                      maxTextLength: 5,
                      validType: 'name',
                      isEnabled: findIdProvider.textInputEnabled,
                      onChanged: (value) {
                        findIdProvider.updateController(
                            findIdProvider.userNameController);
                        findIdProvider.chkValidEmailAndPhoneNumber();
                      },
                      provider: findIdProvider,
                      focusNode: findIdProvider.userNameFocusNode,
                      validFunc: findIdProvider.updateUserNameValid,
                      validMessage: findIdProvider.userNameMessage,
                      isValid: findIdProvider.userNameValid,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '휴대폰 번호',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    DefaultTextField(
                      type: 'default',
                      hint: '01012345678',
                      textEditingController:
                          findIdProvider.phoneNumberController,
                      keyboardType: "num",
                      validType: 'phone',
                      isEnabled: findIdProvider.textInputEnabled,
                      maxTextLength: 11,
                      onChanged: (value) {
                        findIdProvider.updateController(
                            findIdProvider.phoneNumberController);
                        findIdProvider.chkValidEmailAndPhoneNumber();
                      },
                      provider: findIdProvider,
                      focusNode: findIdProvider.phoneNumberFocusNode,
                      validFunc: findIdProvider.updatePhoneNumberValid,
                      validMessage: findIdProvider.phoneNumberValidMessage,
                      isValid: findIdProvider.phoneNumberValid,
                      isInfo: findIdProvider.phoneNumberValid &&
                          findIdProvider.phoneNumberFocusNode.hasFocus,
                      infoMessage: "01012345678 형식으로 입력해 주세요",
                    ),
                    const SizedBox(height: 24),
                    if (findIdProvider.isCertSend)
                      const Text(
                        '인증번호 확인',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    const SizedBox(height: 4),
                    if (findIdProvider.isCertSend)
                      DefaultTextField(
                        type: 'cert',
                        hint: '인증번호를 입력해주세요.',
                        textEditingController:
                            findIdProvider.certNumberController,
                        keyboardType: "num",
                        onChanged: (value) {},
                        provider: findIdProvider,
                        focusNode: findIdProvider.certFocusNode,
                        isSendAuth: findIdProvider.isCertSend,
                        isValid: findIdProvider.certNumberValid,
                        validMessage: findIdProvider.certValidMessage,
                        timeSeconds: findIdProvider.certNumSecond,
                      ),
                    const SizedBox(height: 24),
                    if (findIdProvider.isCertSend)
                      Row(
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
                                findIdProvider.userNameController.text,
                                findIdProvider.phoneNumberController.text,
                              );
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const Spacer(),
              Consumer<CommonProvider>(
                builder: (subContext, commonProvider, child) {
                  if (storageProvider.isCooldown) {
                    return BottomBtn(
                      mediaBottom: MediaQuery.of(context).viewInsets.bottom,
                      content:
                          '인증번호 요청 ${commonProvider.getFormattedTime(storageProvider.certNumResendCooldown)}',
                      isEnabled: false,
                      onPressed: () {
                        storageProvider.startTimer();
                      },
                    );
                  } else {
                    return findIdProvider.isCertSend
                        ? BottomBtn(
                            mediaBottom:
                                MediaQuery.of(context).viewInsets.bottom,
                            content: '인증하기',
                            isEnabled: true,
                            onPressed: () async {
                              commonProvider.changeIsLoading(true);
                              await authViewModel
                                  .findUserIdInfo(
                                    context,
                                    findIdProvider.phoneNumberController.text,
                                    findIdProvider.certNumberController.text,
                                  )
                                  .whenComplete(() =>
                                      commonProvider.changeIsLoading(false));

                              if (findIdProvider.userId.isNotEmpty) {
                                findIdProvider.resetTimer();
                                context.go('/find-id-success');
                              }
                            },
                          )
                        : BottomBtn(
                            mediaBottom:
                                MediaQuery.of(context).viewInsets.bottom,
                            content: '인증번호 발송',
                            isEnabled: findIdProvider.isValidNameAndPhoneNumber,
                            onPressed: findIdProvider.isValidNameAndPhoneNumber
                                ? () async {
                                    await authViewModel.sendCertNum(
                                      context,
                                      'findId',
                                      findIdProvider.userNameController.text,
                                      findIdProvider.phoneNumberController.text,
                                    );
                                  }
                                : () {},
                          );
                  }
                },
              ),
            ],
          ),
          if (commonProvider.isLoadingPage) const Loading()
        ],
      ),
    );
  }
}
