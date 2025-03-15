import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/theme.dart';
import '../../../../data/model/respone/community_board.dart';
import 'community_board_list_card_bottom.dart';

class CommunityBoardListCard extends StatelessWidget {
  final CommunityBoard post;
  final int index;

  const CommunityBoardListCard({
    Key? key,
    required this.post,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                post.postType,
                style: TextTypes.captionMedium02(color: Palette.primary01),
              ),
              const SizedBox(height: 4),
              Text(
                post.title,
                style: TextTypes.bodySemi01(color: Palette.text01),
              ),
              const SizedBox(height: 16),
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
                    post.createdAt.toString(),
                    style: TextTypes.captionMedium02(color: Palette.text04),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                post.content,
                style: TextTypes.bodyMedium03(color: Palette.text02),
              ),
            ],
          ),
        ),
        CommunityBoardListCardBottom(post: post, index: index),
        const SizedBox(height: 16),
      ],
    );
  }
}
