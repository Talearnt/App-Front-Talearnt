import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/theme.dart';
import '../../common/widget/button.dart';
import '../../provider/auth/sign_up_provider.dart';

class SignUpSub1Page extends StatelessWidget {
  const SignUpSub1Page({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Talearnt 서비스 이용을 위한',
            style: TextTypes.heading2(color: Palette.text01),
          ),
          Text(
            '약관에 동의해 주세요!',
            style: TextTypes.heading2(color: Palette.text01),
          ),
          const SizedBox(
            height: 32,
          ),
          Row(children: [
            SizedBox(
              width: 24,
              height: 24,
              child: GestureDetector(
                onTap: () {
                  signUpProvider.updateAllCheck(signUpProvider.allCheck);
                },
                child: signUpProvider.allCheck
                    ? SvgPicture.asset("assets/icons/check_on_primary.svg")
                    : SvgPicture.asset("assets/icons/check_off_primary.svg"),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              '모두 동의 합니다.',
              style: TextTypes.body02(color: Palette.text01),
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
                      signUpProvider.updateRequiredTermsOfUseCheck();
                    },
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: signUpProvider.requiredTermsOfUseCheck
                          ? SvgPicture.asset("assets/icons/check_on_second.svg")
                          : SvgPicture.asset(
                              "assets/icons/check_off_second.svg"),
                    ),
                  ),
                  Text(
                    '[필수]',
                    style: TextTypes.bodyMedium03(color: Palette.error01),
                  ),
                  Text(
                    ' 이용약관 동의',
                    style: TextTypes.bodyMedium03(color: Palette.text01),
                    softWrap: true,
                  )
                ],
              ),
              TextLineXs(
                content: '보기',
                onPressed: () => context.push('/terms-agree-required'),
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
                      signUpProvider.updatePersonalInfoCheck();
                    },
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: signUpProvider.personalInfoCheck
                          ? SvgPicture.asset("assets/icons/check_on_second.svg")
                          : SvgPicture.asset(
                              "assets/icons/check_off_second.svg"),
                    ),
                  ),
                  Text(
                    '[필수]',
                    style: TextTypes.bodyMedium03(color: Palette.error01),
                  ),
                  Text(
                    ' 개인 정보 수집 및 이용 동의',
                    style: TextTypes.bodyMedium03(color: Palette.text01),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  )
                ],
              ),
              TextLineXs(
                content: '보기',
                onPressed: () => context.push('/privacy-agree-required'),
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
                        signUpProvider.updateMarketingCheck();
                      },
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: signUpProvider.marketingCheck
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
                          style: TextTypes.bodyMedium03(color: Palette.text01),
                          children: [
                            TextSpan(
                              text: '마케팅 목적의 개인정보 수집 및 이용 동의',
                              style:
                                  TextTypes.bodyMedium03(color: Palette.text01),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextLineXs(
                content: '보기',
                onPressed: () => context.push('/privacy-agree-optional'),
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
                      signUpProvider.updateTermsOfUseCheck();
                    },
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: signUpProvider.termsOfUseCheck
                          ? SvgPicture.asset("assets/icons/check_on_second.svg")
                          : SvgPicture.asset(
                              "assets/icons/check_off_second.svg"),
                    ),
                  ),
                  Text(
                    '[선택]',
                    style: TextTypes.bodyMedium03(color: Palette.text01),
                  ),
                  Text(
                    ' 이용약관 동의',
                    style: TextTypes.bodyMedium03(color: Palette.text01),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  )
                ],
              ),
              TextLineXs(
                content: '보기',
                onPressed: () => context.push('/terms-agree-optional'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
