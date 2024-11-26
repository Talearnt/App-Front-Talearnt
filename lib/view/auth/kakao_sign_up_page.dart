import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/provider/auth/kakao_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../common/widget/bottom_btn.dart';
import '../../common/widget/default_text_field.dart';
import '../../common/widget/text_field_label.dart';
import '../../common/widget/top_app_bar.dart';

class KakaoSignUpPage extends StatelessWidget {
  const KakaoSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final kakaoProvider = Provider.of<KakaoProvider>(context);

    return PopScope(
      canPop: false, // 뒤로가기 허용은 하지 않지만 사용자 정의 동작을 처리
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (!didPop) {
          if (context.mounted) {
            //아마 초기화 함수 만들어야될듯
            Navigator.pop(context); // 화면 종료
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
                              onPressed: () {
                                kakaoProvider.changeGender(0);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: kakaoProvider.gender == 0
                                    ? Palette.primary01
                                    : Palette.line01,
                                side: BorderSide(
                                    color: kakaoProvider.gender == 0
                                        ? Palette.primary01
                                        : Palette.line01),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                elevation: 0,
                                shadowColor: Colors
                                    .transparent, // hover 시 주변 뿌옇게 되는 효과 제거
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
                                kakaoProvider.changeGender(1);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: kakaoProvider.gender == 1
                                    ? Palette.primary01
                                    : Palette.line01,
                                side: BorderSide(
                                    color: kakaoProvider.gender == 1
                                        ? Palette.primary01
                                        : Palette.line01),
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
                        content: '이름',
                      ),
                      const SizedBox(height: 4),
                      DefaultTextField(
                        isEnabled: false,
                        type: 'default',
                        hint: '이름을 입력해주세요.',
                        textEditingController: kakaoProvider.nameController,
                        onChanged: (value) {
                          kakaoProvider
                              .updateController(kakaoProvider.nameController);
                        },
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
                        onChanged: (value) {
                          kakaoProvider
                              .updateController(kakaoProvider.emailController);
                        },
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
                        onChanged: (value) {
                          kakaoProvider.updateController(
                              kakaoProvider.phoneNumController);
                        },
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
                                  .updateAllCheck(kakaoProvider.allCheck!);
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
                                    kakaoProvider
                                        .updateRequiredTermsOfUseCheck();
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
                            Text('보기',
                                style: TextTypes.caption01(
                                        color: Palette.text03)
                                    .copyWith(
                                        decoration: TextDecoration.underline,
                                        decorationColor: Palette.text03))
                          ]),
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
                            Text('보기',
                                style: TextTypes.caption01(
                                        color: Palette.text03)
                                    .copyWith(
                                        decoration: TextDecoration.underline,
                                        decorationColor: Palette.text03))
                          ]),
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
                          Text(
                            '보기',
                            style: TextTypes.caption01(color: Palette.text03)
                                .copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationColor: Palette.text03),
                          )
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
                          Text(
                            '보기',
                            style: TextTypes.caption01(color: Palette.text03)
                                .copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationColor: Palette.text03),
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
              ///////isEnabled: kakaoProvider.,
              onPressed: () async {},
            )
          ],
        ),
      ),
    );
  }
}
