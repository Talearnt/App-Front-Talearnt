import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/provider/board/community_board_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../common/widget/toast_message.dart';
import '../../../../provider/auth/login_provider.dart';
import '../../../../provider/board/community_board_provider.dart';
import '../../../../provider/home/home_provider.dart';
import '../../../../provider/profile/profile_provider.dart';
import '../../../../view_model/board_view_model.dart';

class CommunityDetailBoardBottom extends StatelessWidget {
  final CommunityBoardDetailProvider communityBoardDetailProvider;

  const CommunityDetailBoardBottom({
    super.key,
    required this.communityBoardDetailProvider,
  });

  @override
  Widget build(BuildContext context) {
    final boardViewModel = Provider.of<BoardViewModel>(context);
    final CommunityBoardProvider communityBoardProvider =
    Provider.of<CommunityBoardProvider>(context);
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    final loginProvider = Provider.of<LoginProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
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
                  "댓글수 ${communityBoardDetailProvider.communityDetailBoard
                      .commentCount}",
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
            child: InkWell(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              onTap: () async {
                if (loginProvider.isLoggedIn) {
                  await communityBoardDetailProvider.changeCommunityBoardLike();
                  await communityBoardProvider
                      .changeCommunityBoardLikeFromDetail(
                      communityBoardDetailProvider
                          .communityDetailBoard.communityPostNo,
                      communityBoardDetailProvider
                          .communityDetailBoard.isLike);
                  await homeProvider.changeCommunityBoardLikeFromDetail(
                      communityBoardDetailProvider
                          .communityDetailBoard.communityPostNo,
                      communityBoardDetailProvider.communityDetailBoard.isLike);
                  await profileProvider.changeCommunityBoardLikeFromDetail(
                      communityBoardDetailProvider
                          .communityDetailBoard.communityPostNo,
                      communityBoardDetailProvider.communityDetailBoard.isLike);
                  await boardViewModel.handleCommunityBoardLike(
                      communityBoardDetailProvider
                          .communityDetailBoard.communityPostNo,
                      communityBoardDetailProvider.communityDetailBoard.isLike);
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
                  communityBoardDetailProvider.communityDetailBoard.isLike
                      ? SvgPicture.asset('assets/icons/thumb_up_on.svg')
                      : SvgPicture.asset('assets/icons/thumb_up_off.svg'),
                  const SizedBox(width: 4),
                  Text(
                    "추천 ${communityBoardDetailProvider.communityDetailBoard
                        .likeCount}",
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
