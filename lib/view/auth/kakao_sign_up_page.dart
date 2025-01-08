import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/provider/auth/kakao_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/widget/bottom_btn.dart';
import '../../common/widget/button.dart';
import '../../common/widget/default_text_field.dart';
import '../../common/widget/text_field_label.dart';
import '../../common/widget/top_app_bar.dart';
import '../../provider/common/common_provider.dart';
import '../../view_model/auth_view_model.dart';

class KakaoSignUpPage extends StatelessWidget {
  const KakaoSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final kakaoProvider = Provider.of<KakaoProvider>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);
    final commonProvider = Provider.of<CommonProvider>(context);

    return PopScope(
      canPop: false, // 뒤로가기 허용은 하지 않지만 사용자 정의 동작을 처리
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (!didPop) {
          if (context.mounted) {
            kakaoProvider.resetKakao();
            context.pop();
          }
        }
      },
      child: Scaffold(
        backgroundColor: Palette.bgBackGround,
        appBar: TopAppBar(
            content: '약관 동의',
            onPressed: () {
              //여기도 초기화 함수
              Navigator.of(context).pop();
            }),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '로그인에 사용할 회원정보와',
                        style: TextTypes.heading(color: Palette.text01),
                      ),
                      Text(
                        '약관에 동의해 주세요.',
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
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                disabledBackgroundColor:
                                    kakaoProvider.gender == 0
                                        ? Palette.bgUp01
                                        : Colors.transparent,
                                disabledForegroundColor: Palette.line01,
                                side: const BorderSide(color: Palette.line01),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                elevation: 0,
                                shadowColor: Colors
                                    .transparent, // hover 시 주변 뿌옇게 되는 효과 제거
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(11.5),
                                child: Text('남자',
                                    style: TextTypes.bodyMedium02(
                                        color: Palette.text04)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                disabledBackgroundColor:
                                    kakaoProvider.gender == 1
                                        ? Palette.bgUp01
                                        : Colors.transparent,
                                disabledForegroundColor: Palette.line01,
                                side: const BorderSide(color: Palette.line01),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                elevation: 0,
                                shadowColor: Colors.transparent,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(11.5),
                                child: Text(
                                  '여자',
                                  style: TextTypes.bodyMedium02(
                                      color: Palette.text04),
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
                        textEditingController: kakaoProvider.nickNameController,
                        onChanged: (value) {
                          kakaoProvider.updateNickNameController(
                              kakaoProvider.nickNameController);
                        },
                        provider: kakaoProvider,
                        validType: 'nickName',
                        focusNode: kakaoProvider.nickNameFocusNode,
                        validFunc: kakaoProvider.updateNickNameInfoValid,
                        validMessage: kakaoProvider.nickNameValidMessage,
                        isValid: kakaoProvider.nickNameValid,
                        isInfo: kakaoProvider.isNickNameInfo,
                        isInfoValid: kakaoProvider.isNickNameInfoValid,
                        infoMessage: kakaoProvider.nickNameInfoMessage,
                        infoValidMessage:
                            kakaoProvider.nickNameInfoValidMessage,
                        infoType: kakaoProvider.nickNameInfoType,
                        infoFunc: kakaoProvider.updateNickNameInfo,
                        onServerCheck: authViewModel.checkNickNameDuplication,
                      ),
                      const SizedBox(height: 24.0),
                      const TextFieldLabel(
                        content: '이름',
                      ),
                      const SizedBox(height: 4),
                      DefaultTextField(
                        isEnabled: false,
                        type: 'default',
                        hint: '이름을 입력해주세요.',
                        textEditingController: kakaoProvider.nameController,
                        onChanged: (value) {},
                        provider: kakaoProvider,
                      ),
                      const SizedBox(height: 24.0),
                      const TextFieldLabel(
                        content: '이메일',
                      ),
                      const SizedBox(height: 4),
                      DefaultTextField(
                        isEnabled: false,
                        type: 'default',
                        hint: '메일을 입력해주세요',
                        textEditingController: kakaoProvider.emailController,
                        onChanged: (value) {},
                        provider: kakaoProvider,
                      ),
                      const SizedBox(height: 24.0),
                      const TextFieldLabel(
                        content: '휴대폰 번호',
                      ),
                      const SizedBox(height: 4),
                      DefaultTextField(
                        isEnabled: false,
                        type: 'default',
                        keyboardType: 'num',
                        hint: '01012345678',
                        textEditingController: kakaoProvider.phoneNumController,
                        onChanged: (value) {},
                        provider: kakaoProvider,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: GestureDetector(
                            onTap: () {
                              kakaoProvider
                                  .updateAllCheck(kakaoProvider.allCheck);
                            },
                            child: kakaoProvider.allCheck
                                ? SvgPicture.asset(
                                    "assets/icons/check_on_primary.svg")
                                : SvgPicture.asset(
                                    "assets/icons/check_off_primary.svg"),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '모두 동의 합니다.',
                          style: TextTypes.bodyLarge02(color: Palette.text01),
                        )
                      ]),
                      const SizedBox(
                        height: 14,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  kakaoProvider.updateRequiredTermsOfUseCheck();
                                },
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: kakaoProvider.requiredTermsOfUseCheck
                                      ? SvgPicture.asset(
                                          "assets/icons/check_on_second.svg")
                                      : SvgPicture.asset(
                                          "assets/icons/check_off_second.svg"),
                                ),
                              ),
                              Text(
                                '[필수]',
                                style: TextTypes.bodyMedium02(
                                    color: Palette.error01),
                              ),
                              Text(
                                ' 이용약관 동의',
                                style: TextTypes.bodyMedium02(
                                    color: Palette.text01),
                                softWrap: true,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 24,
                            child: TextLineXs(
                              content: '보기',
                              onPressed: () =>
                                  context.push('/terms-agree-required'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  kakaoProvider.updatePersonalInfoCheck();
                                },
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: kakaoProvider.personalInfoCheck
                                      ? SvgPicture.asset(
                                          "assets/icons/check_on_second.svg")
                                      : SvgPicture.asset(
                                          "assets/icons/check_off_second.svg"),
                                ),
                              ),
                              Text(
                                '[필수]',
                                style: TextTypes.bodyMedium02(
                                    color: Palette.error01),
                              ),
                              Text(
                                ' 개인 정보 수집 및 이용 동의',
                                style: TextTypes.bodyMedium02(
                                    color: Palette.text01),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 24,
                            child: TextLineXs(
                              content: '보기',
                              onPressed: () =>
                                  context.push('/privacy-agree-required'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    kakaoProvider.updateMarketingCheck();
                                  },
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: kakaoProvider.marketingCheck
                                        ? SvgPicture.asset(
                                            "assets/icons/check_on_second.svg")
                                        : SvgPicture.asset(
                                            "assets/icons/check_off_second.svg"),
                                  ),
                                ),
                                Flexible(
                                  child: Text.rich(
                                    TextSpan(
                                      text: '[선택] ', // 기본 텍스트
                                      style: TextTypes.bodyMedium02(
                                          color: Palette.text01),
                                      children: [
                                        TextSpan(
                                          text: '마케팅 목적의 개인정보 수집 및 이용 동의',
                                          style: TextTypes.bodyMedium02(
                                              color: Palette.text01),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 24,
                            child: TextLineXs(
                              content: '보기',
                              onPressed: () =>
                                  context.push('/privacy-agree-optional'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  kakaoProvider.updateTermsOfUseCheck();
                                },
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: kakaoProvider.termsOfUseCheck
                                      ? SvgPicture.asset(
                                          "assets/icons/check_on_second.svg")
                                      : SvgPicture.asset(
                                          "assets/icons/check_off_second.svg"),
                                ),
                              ),
                              Text(
                                '[선택]',
                                style: TextTypes.bodyMedium02(
                                    color: Palette.text01),
                              ),
                              Text(
                                ' 이용 약관 동의',
                                style: TextTypes.bodyMedium02(
                                    color: Palette.text01),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 24,
                            child: TextLineXs(
                              content: '보기',
                              onPressed: () =>
                                  context.push('/terms-agree-optional'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BottomBtn(
              mediaBottom: MediaQuery.of(context).viewInsets.bottom,
              content: '가입하기',
              isEnabled: kakaoProvider.isEnabledKakaoSignup,
              onPressed: () async {
                commonProvider.changeIsLoading(true);
                await authViewModel
                    .kakaoSignUp(
                        kakaoProvider.emailController.text,
                        kakaoProvider.nameController.text,
                        kakaoProvider.nickNameController.text,
                        kakaoProvider.gender,
                        kakaoProvider.phoneNumController.text)
                    .whenComplete(() => commonProvider.changeIsLoading(false))
                    .then((_) {
                  context.go('/');
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
