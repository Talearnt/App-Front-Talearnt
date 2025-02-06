import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/theme.dart';
import '../../../data/model/respone/talent_exchange_post.dart';
import 'board_selected_chip_list.dart';
import 'match_board_list_card_bottom.dart';

class BoardListCard extends StatelessWidget {
  final TalentExchangePost post;
  final int index;

  const BoardListCard({
    Key? key,
    required this.post, required this.index,
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
                    style: TextTypes.caption02(color: Palette.text02),
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
                    post.duration,
                    style: TextTypes.caption02(color: Palette.text04),
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
                      style: TextTypes.caption02(color: Palette.primary01),
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
                      post.exchangeType,
                      style: TextTypes.caption02(color: Palette.primary01),
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
                      style: TextTypes.caption02(color: Palette.primary01),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                post.title,
                style: TextTypes.heading(color: Palette.text01),
              ),
              const SizedBox(height: 8),
              Text(
                post.content,
                style: TextTypes.bodyMedium02(color: Palette.text03),
              ),
              const SizedBox(height: 24),
              Text(
                '주고 싶은 나의 재능',
                style: TextTypes.caption02(color: Palette.text04),
              ),
              const SizedBox(height: 8),
              BoardSelectedChipList(keywordNames: post.giveTalents),
              const SizedBox(height: 16),
              Text(
                '받고 싶은 상대의 재능',
                style: TextTypes.caption02(color: Palette.text04),
              ),
              const SizedBox(height: 8),
              BoardSelectedChipList(keywordNames: post.receiveTalents),
              const SizedBox(height: 8),
            ],
          ),
        ),
        MatchBoardListCardBottom(post: post, index: index),
        const SizedBox(height: 16),
      ],
    );
  }
}
