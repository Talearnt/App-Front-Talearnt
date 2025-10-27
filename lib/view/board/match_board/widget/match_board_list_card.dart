import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/theme.dart';
import '../../../../data/model/respone/match_board.dart';
import 'match_board_list_card_bottom.dart';
import 'match_board_selected_chip_list.dart';

class MatchBoardListCard extends StatelessWidget {
  final String pageType; // my-write, list
  final MatchBoard post;
  final int index;

  const MatchBoardListCard({
    Key? key,
    required this.post,
    required this.index,
    required this.pageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: SvgPicture.asset('assets/img/profile.svg'),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    post.nickname,
                    style: TextTypes.captionMedium02(color: Palette.text02),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6.5,
                      horizontal: 6,
                    ),
                    child: Container(
                      width: 3,
                      height: 3,
                      decoration: const BoxDecoration(
                        color: Palette.icon03,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Text(
                    post.createdAt,
                    style: TextTypes.captionMedium02(color: Palette.text04),
                  ),
                ],
              ),
              const SizedBox(height: 14),
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
                      post.status,
                      style: TextTypes.captionSemi02(color: Palette.primary01),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: Palette.primaryBG04,
                    ),
                    child: Text(
                      post.duration,
                      style: TextTypes.captionSemi02(color: Palette.primary01),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                post.title,
                style: TextTypes.heading4(color: Palette.text01),
              ),
              const SizedBox(height: 8),
              Text(
                post.content,
                style: TextTypes.bodyMedium03(color: Palette.text03),
              ),
              const SizedBox(height: 24),
              Text(
                '주고 싶은 나의 재능',
                style: TextTypes.captionMedium02(color: Palette.text04),
              ),
              const SizedBox(height: 8),
              MatchBoardSelectedChipList(keywordNames: post.giveTalents),
              const SizedBox(height: 16),
              Text(
                '받고 싶은 상대의 재능',
                style: TextTypes.captionMedium02(color: Palette.text04),
              ),
              const SizedBox(height: 8),
              MatchBoardSelectedChipList(keywordNames: post.receiveTalents),
              const SizedBox(height: 8),
            ],
          ),
        ),
        MatchBoardListCardBottom(
          post: post,
          index: index,
          pageType: pageType,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
