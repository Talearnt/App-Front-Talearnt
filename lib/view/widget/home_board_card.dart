import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/view/board/match_board/widget/match_board_selected_chip_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeBoardCard extends StatelessWidget {
  const HomeBoardCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 308,
      height: 346,
      decoration: BoxDecoration(
        color: Palette.bgBackGround,
        border: Border.all(
          color: Palette.line02,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color:
                const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1), // 그림자 색상
            offset: const Offset(0, 1), // 그림자의 위치 (x, y)
            blurRadius: 10, // 그림자의 흐림 정도
            spreadRadius: 3, // 그림자의 확산 정도
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset('assets/img/profile.svg'),
                ),
                const SizedBox(width: 8),
                Text(
                  "잭재기",
                  style: TextTypes.body02(
                    color: Palette.text01,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: Palette.primaryBG04,
                  ),
                  child: Text(
                    "모집중",
                    style: TextTypes.captionSemi02(color: Palette.primary01),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: Palette.bgUp01,
                  ),
                  child: Text(
                    "온라인",
                    style: TextTypes.captionSemi02(color: Palette.text02),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: Palette.bgUp01,
                  ),
                  child: Text(
                    "2개월",
                    style: TextTypes.captionSemi02(color: Palette.text02),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              "Java와 C++, 보안에 관심 있는 분 있나요?",
              style: TextTypes.heading2(
                color: Palette.text01,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              "안녕하세요~ 어쩌구 저쩌구~ 전 보안 잘 하는데 디자인이 꽝이에여",
              style: TextTypes.bodyMedium03(
                color: Palette.text03,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "주고 싶은 재능",
                        style: TextTypes.captionSemi02(
                          color: Palette.text04,
                        ),
                      ),
                      const MatchBoardSelectedChipList(
                        keywordNames: ["JAVA"],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "받고 싶은 재능",
                        style: TextTypes.captionSemi02(
                          color: Palette.text04,
                        ),
                      ),
                      const MatchBoardSelectedChipList(
                        keywordNames: ["JAVA"],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
