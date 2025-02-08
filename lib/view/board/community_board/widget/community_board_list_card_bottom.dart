import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../data/model/respone/community_post.dart';

class CommunityBoardListCardBottom extends StatelessWidget {
  final CommunityPost post;
  final int index;

  const CommunityBoardListCardBottom(
      {super.key, required this.post, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/eye_open_grey.svg'),
                const SizedBox(width: 4),
                Text(
                  "조회수",
                  style: TextTypes.captionMedium02(color: Palette.text03),
                ),
              ],
            ),
          ),
          const VerticalDivider(
            color: Palette.line02,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/comment.svg'),
                const SizedBox(width: 4),
                Text(
                  "댓글수",
                  style: TextTypes.captionMedium02(color: Palette.text03),
                ),
              ],
            ),
          ),
          const VerticalDivider(
            color: Palette.line02,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/thumb_up_off.svg'),
                const SizedBox(width: 4),
                Text(
                  "${post.favoriteCount}",
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
