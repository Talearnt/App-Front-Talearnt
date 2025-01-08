import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/provider/auth/storage_provider.dart';
import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:app_front_talearnt/view/auth/sign_up_sub1_page.dart';
import 'package:app_front_talearnt/view/auth/sign_up_sub2_page.dart';
import 'package:app_front_talearnt/view/auth/sign_up_sub3_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/widget/bottom_btn.dart';
import '../../common/widget/top_app_bar.dart';
import '../../provider/auth/sign_up_provider.dart';
import '../../view_model/auth_view_model.dart';

class SignUpMainPage extends StatelessWidget {
  const SignUpMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);
    final storageProvider = Provider.of<StorageProvider>(context);
    final commonProvider = Provider.of<CommonProvider>(context);

    return PopScope(
      canPop: false, // 뒤로가기 허용은 하지 않지만 사용자 정의 동작을 처리
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (!didPop) {
          // 뒤로가기가 처리되지 않았을 때
          if (context.mounted) {
            signUpProvider.resetSignUp(); // 초기화 작업 수행
            Navigator.pop(context); // 화면 종료
          }
        }
      },
      child: Scaffold(
        backgroundColor: Palette.bgBackGround,
        appBar: TopAppBar(
            content: '회원가입',
            onPressed: () {
              if (signUpProvider.signUpPage == 0) {
                signUpProvider.resetSignUp(); // 초기화 작업 수행
                Navigator.of(context).pop();
              } else {
                signUpProvider.pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              }
            }),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: LinearProgressIndicator(
                    backgroundColor: Palette.bgUp02,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Palette.text03),
                    value: signUpProvider.getSignUpProgress(),
                  )),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: signUpProvider.pageController,
                    onPageChanged: (int page) {
                      if (page == 2 && signUpProvider.isFirstVisit) {
                        authViewModel.createRandomNickName('signUp');
                      }
                      signUpProvider.updateSignUp(page);
                    },
                    children: const [
                      SignUpSub1Page(),
                      SignUpSub2Page(),
                      SignUpSub3Page()
                    ],
                  ),
                ),
              ),
              signUpProvider.signUpPage == 0
                  ? //첫번째 페이지
                  BottomBtn(
                      mediaBottom: MediaQuery.of(context).viewInsets.bottom,
                      content: '시작하기',
                      isEnabled: signUpProvider.isSignUpSub1ButtonEnabled,
                      onPressed: () async {
                        signUpProvider.pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                    )
                  : signUpProvider.signUpPage == 2
                      ? BottomBtn(
                          mediaBottom: MediaQuery.of(context).viewInsets.bottom,
                          content: '가입하기',
                          isEnabled: signUpProvider.isSignUpSub3ButtonEnabled,
                          onPressed: () async {
                            commonProvider.changeIsLoading(true);
                            await authViewModel
                                .signUp(
                                    signUpProvider.emailController.text,
                                    signUpProvider.passwordController.text,
                                    signUpProvider.nameController.text,
                                    signUpProvider.nickNameController.text,
                                    signUpProvider.gender,
                                    signUpProvider.phoneNumController.text)
                                .whenComplete(
                                    () => commonProvider.changeIsLoading(false))
                                .then((_) {
                              context.go('/sign-up-success');
                            });
                          },
                        )
                      : storageProvider.isCooldown
                          ? BottomBtn(
                              mediaBottom:
                                  MediaQuery.of(context).viewInsets.bottom,
                              content:
                                  '인증번호 요청 ${commonProvider.getFormattedTime(storageProvider.certNumResendCooldown)}',
                              isEnabled: false,
                              onPressed: () {
                                storageProvider.startTimer();
                              },
                            )
                          : signUpProvider.sendCertNum
                              ? BottomBtn(
                                  mediaBottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                  content: '인증하기',
                                  isEnabled: signUpProvider
                                      .isSignUpSub2NextButtonEnabled,
                                  onPressed: () async {
                                    commonProvider.changeIsLoading(true);
                                    await authViewModel
                                        .signUpCheckSmsValidation(
                                            context,
                                            signUpProvider
                                                .phoneNumController.text,
                                            signUpProvider
                                                .certNumController.text)
                                        .whenComplete(() => commonProvider
                                            .changeIsLoading(false));

                                    //인증 완료되면 다음 페이지로 넘어감
                                    if (signUpProvider.checkSmsValidation) {
                                      signUpProvider.finishCheckCertNum();
                                      signUpProvider.pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                    }
                                  },
                                )
                              : BottomBtn(
                                  mediaBottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                  content: '인증번호 요청',
                                  isEnabled:
                                      signUpProvider.isSignUpSub2ButtonEnabled,
                                  onPressed: signUpProvider
                                          .isSignUpSub2ButtonEnabled
                                      ? () async {
                                          commonProvider.changeIsLoading(true);
                                          await authViewModel
                                              .sendCertNum(
                                                  context,
                                                  'signUp',
                                                  null,
                                                  signUpProvider
                                                      .phoneNumController.text)
                                              .whenComplete(() => commonProvider
                                                  .changeIsLoading(false));
                                        }
                                      : () {},
                                ),
            ],
          ),
        ),
      ),
    );
  }
}
