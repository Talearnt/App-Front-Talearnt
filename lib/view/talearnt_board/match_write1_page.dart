import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:app_front_talearnt/view/talearnt_board/match_write2_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class MatchWrite1Page extends StatelessWidget {
  const MatchWrite1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        onPressed: () {
          context.pop();
        },
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Palette.line01,
              width: 1.0,
            ),
          ),
        ),
        child: BottomAppBar(
          color: Palette.bgBackGround,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Row(
              children: [
                const TextWithIcon(
                    content: '초기화', icon: Icons.refresh_outlined),
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryM(
                    content: '다음',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const MatchWrite2Page();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
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
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/add_square.svg',
                        width: 36,
                        height: 36,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 600,
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                top: 28,
                                left: 24,
                                right: 24,
                              ),
                              decoration: const BoxDecoration(
                                color: Palette.bgBackGround,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '받고 싶은 상대의 재능',
                                    style: TextTypes.bodySemi01(),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
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
