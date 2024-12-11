import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class MatchWrite extends StatelessWidget {
  const MatchWrite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        onPressed: () {
          context.pop();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/text_edit.svg',
                    width: 36,
                    height: 36,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    '필수 정보를 입력해 주세요',
                    style: TextTypes.bodySemi01(color: Palette.text01),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Divider(
              color: Palette.line01, // 선 색상
              thickness: 1.0, // 선 두께
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Align(
                alignment: Alignment.centerLeft, // 왼쪽 정렬 강제
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '주고 싶은 나의 재능',
                            style: TextTypes.bodySemi02(color: Palette.text01),
                          ),
                          TextSpan(
                            text: '(최소 1개)',
                            style: TextTypes.bodySemi02(color: Palette.text02),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Wrap(
                      spacing: 12.0,
                      runSpacing: 12.0,
                      children: [
                        // chips 들어갈 예정
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '받고 싶은 나의 재능',
                            style: TextTypes.bodySemi02(color: Palette.text01),
                          ),
                          TextSpan(
                            text: '(최소 1개)',
                            style: TextTypes.bodySemi02(color: Palette.text02),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SvgPicture.asset(
                      'assets/icons/add_square.svg',
                      width: 36,
                      height: 36,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      '진행 기간',
                      style: TextTypes.bodySemi02(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Wrap(
                      spacing: 12.0,
                      runSpacing: 12.0,
                      children: [
                        // chips 들어갈 예정
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      '진행 방식',
                      style: TextTypes.bodySemi02(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Wrap(
                      spacing: 12.0,
                      runSpacing: 12.0,
                      children: [
                        // chips 들어갈 예정
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      '인증 배지 여부',
                      style: TextTypes.bodySemi02(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Wrap(
                      spacing: 12.0,
                      runSpacing: 12.0,
                      children: [
                        // chips 들어갈 예정
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
