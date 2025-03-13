import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/view/board/match_board/widget/match_board_selected_chip_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeMatchBoardCard extends StatelessWidget {
  const HomeMatchBoardCard({super.key});

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
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
            offset: const Offset(0, 1),
            blurRadius: 10,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/eye_open_grey.svg'),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "20",
                      style: TextTypes.bodySemi03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    SvgPicture.asset('assets/icons/bookmark_off.svg'),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "12",
                      style: TextTypes.bodySemi03(
                        color: Palette.text03,
                      ),
                    ),
                  ],
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
                        keywordNames: ["JAVA", "JAVA", "JAVA"],
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
                        keywordNames: ["JAVA", "JAVA", "JAVA"],
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

class HomeCommunityCard extends StatelessWidget {
  const HomeCommunityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 308,
          height: 280,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 2),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: SvgPicture.asset('assets/img/profile.svg'),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "당찬 돼지",
                          style: TextTypes.body02(
                            color: Palette.text01,
                          ),
                        ),
                        Text(
                          "2025. 03. 02",
                          style: TextTypes.captionSemi02(
                            color: Palette.text04,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: Palette.primaryBG04,
                  ),
                  child: Text(
                    "자유게시판",
                    style: TextTypes.captionSemi02(color: Palette.primary01),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "재능 어쩌구 저쩌구해서\n또 어쩌구 저쩌구 한 경우 있나요?",
                  style: TextTypes.bodySemi01(
                    color: Palette.text01,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "안녕하세요~ 어쩌구 저쩌구~ 전 보안 잘 하는데 디자인이 꽝이에여",
                  style: TextTypes.bodyMedium03(
                    color: Palette.text03,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/thumb_up_off.svg'),
                        const SizedBox(width: 4),
                        Text(
                          "21",
                          style: TextTypes.bodySemi03(
                            color: Palette.text03,
                          ),
                        ),
                        const SizedBox(width: 6),
                        SvgPicture.asset('assets/icons/comment.svg'),
                        const SizedBox(width: 4),
                        Text(
                          "12",
                          style: TextTypes.bodySemi03(
                            color: Palette.text03,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/eye_open_grey.svg'),
                        const SizedBox(width: 4),
                        Text(
                          "20",
                          style: TextTypes.bodySemi03(
                            color: Palette.text03,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: -14,
          right: 12,
          child: SvgPicture.asset('assets/icons/ranking_badge.svg'),
        ),
      ],
    );
  }
}
