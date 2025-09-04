import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../common/widget/toast_message.dart';
import '../../../../data/model/respone/community_board.dart';
import '../../../../provider/auth/login_provider.dart';
import '../../../../provider/board/community_board_provider.dart';
import '../../../../provider/profile/profile_provider.dart';
import '../../../../view_model/board_view_model.dart';

class CommunityBoardListCardBottom extends StatelessWidget {
  final String pageType; // my-write, list
  final CommunityBoard post;
  final int index;

  const CommunityBoardListCardBottom(
      {super.key,
      required this.post,
      required this.index,
      required this.pageType});

  @override
  Widget build(BuildContext context) {
    final CommunityBoardProvider communityBoardProvider =
        Provider.of<CommunityBoardProvider>(context);
    final ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context);
    final boardViewModel = Provider.of<BoardViewModel>(context);
    final loginProvider = Provider.of<LoginProvider>(context);
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
                  "${post.commentCount}",
                  style: TextTypes.captionMedium02(color: Palette.text03),
                ),
              ],
            ),
          ),
          const VerticalDivider(
            color: Palette.line02,
          ),
          Expanded(
            child: InkWell(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              onTap: () async {
                if (loginProvider.isLoggedIn) {
                  if (pageType == 'list') {
                    await communityBoardProvider
                        .changeCommunityBoardLike(post.communityPostNo);
                    await boardViewModel.handleCommunityBoardLike(
                        communityBoardProvider
                            .communityBoardList[index].communityPostNo);
                  } else {
                    await profileProvider
                        .changeCommunityBoardLike(post.communityPostNo);
                    await boardViewModel.handleCommunityBoardLike(profileProvider
                        .communityBoardList[index].communityPostNo);
                  }
                } else {
                  ToastMessage.show(
                    context: context,
                    message: "로그인이 필요합니다.",
                    type: 1,
                    bottom: 50,
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  post.isLike
                      ? SvgPicture.asset('assets/icons/thumb_up_on.svg')
                      : SvgPicture.asset('assets/icons/thumb_up_off.svg'),
                  const SizedBox(width: 4),
                  Text(
                    "${post.likeCount}",
                    style: TextTypes.captionMedium02(color: Palette.text03),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
