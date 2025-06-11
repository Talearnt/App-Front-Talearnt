import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/provider/board/community_board_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../data/model/respone/community_detail_board.dart';

class CommunityDetailBoardBottom extends StatelessWidget {
  final CommunityBoardDetailProvider communityBoardDetailProvider;

  const CommunityDetailBoardBottom({
    super.key,
    required this.communityBoardDetailProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Palette.line02, width: 1),
          bottom: BorderSide(color: Palette.line02, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                communityBoardDetailProvider.setInsertComment();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "댓글 쓰기",
                    style: TextTypes.captionMedium02(color: Palette.text03),
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(
            width: 1,
            color: Palette.line02,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/comment.svg'),
                const SizedBox(width: 4),
                Text(
                  "댓글수 ${communityBoardDetailProvider.communityDetailBoard.commentCount}",
                  style: TextTypes.captionMedium02(color: Palette.text03),
                ),
              ],
            ),
          ),
          const VerticalDivider(
            width: 1,
            color: Palette.line02,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/thumb_up_off.svg'),
                const SizedBox(width: 4),
                Text(
                  "추천 ${communityBoardDetailProvider.communityDetailBoard.likeCount}",
                  style: TextTypes.captionMedium02(color: Palette.text03),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
