import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/provider/board/match_board_provider.dart';
import 'package:app_front_talearnt/provider/profile/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../common/widget/toast_message.dart';
import '../../../../data/model/respone/match_board.dart';
import '../../../../provider/auth/login_provider.dart';
import '../../../../view_model/board_view_model.dart';

class MatchBoardListCardBottom extends StatelessWidget {
  final String pageType; // my-write, list
  final MatchBoard post;
  final int index;

  const MatchBoardListCardBottom(
      {super.key,
      required this.post,
      required this.index,
      required this.pageType});

  @override
  Widget build(BuildContext context) {
    final MatchBoardProvider matchBoardProvider =
        Provider.of<MatchBoardProvider>(context);
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
                  post.count.toString(),
                  style: TextTypes.captionSemi02(color: Palette.text03),
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
                  "${post.openedChatRoomCount}",
                  style: TextTypes.captionSemi02(color: Palette.text03),
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
                    bool isFavorite = await matchBoardProvider
                        .changeMatchBoardLike(post.exchangePostNo);
                    await boardViewModel.handleMatchBoardLike(
                        post.exchangePostNo, isFavorite);
                  } else {
                    bool isFavorite = await profileProvider
                        .changeMatchBoardLike(post.exchangePostNo);
                    await boardViewModel.handleMatchBoardLike(
                        post.exchangePostNo, isFavorite);
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
                  post.isFavorite
                      ? SvgPicture.asset('assets/icons/bookmark_on.svg')
                      : SvgPicture.asset('assets/icons/bookmark_off.svg'),
                  const SizedBox(width: 4),
                  Text(
                    "${post.favoriteCount}",
                    style: TextTypes.captionSemi02(color: Palette.text03),
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
