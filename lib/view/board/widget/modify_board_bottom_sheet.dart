import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/provider/board/match_edit_provider.dart';
import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:app_front_talearnt/view_model/keyword_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/common_navigator.dart';
import '../../../provider/board/community_board_detail_provider.dart';
import '../../../provider/board/community_edit_provider.dart';
import '../../../provider/board/match_board_detail_provider.dart';
import '../../../view_model/board_view_model.dart';

class ModifyBoardBottomSheet extends StatelessWidget {
  final bool isMine;
  final String boardType;
  final int postNo;

  const ModifyBoardBottomSheet({
    super.key,
    required this.isMine,
    required this.boardType,
    required this.postNo,
  });

  @override
  Widget build(BuildContext context) {
    final keywordViewModel = Provider.of<KeywordViewModel>(context);
    final viewModel = Provider.of<BoardViewModel>(context);
    final matchBoardDetailProvider =
        Provider.of<MatchBoardDetailProvider>(context);
    final matchEditProvider = Provider.of<MatchEditProvider>(context);
    final communityEditProvider = Provider.of<CommunityEditProvider>(context);
    final communityBoardDetailProvider =
        Provider.of<CommunityBoardDetailProvider>(context);
    final commonNavigator = Provider.of<CommonNavigator>(context);
    final commonProvider = Provider.of<CommonProvider>(context);
    final boardViewModel = Provider.of<BoardViewModel>(context);

    return Wrap(children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 44, top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isMine) ...[
              SizedBox(
                height: 50,
                width: double.infinity,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: () async {
                    commonNavigator.goBack();
                    commonProvider.changeIsLoading(true);
                    if (boardType == "match") {
                      await keywordViewModel.getOfferedKeywords();
                      await matchEditProvider.setPostInfo(
                          matchBoardDetailProvider.matchingDetailPost);
                      commonNavigator.pushRoute(
                          '/board-list/match-board-detail-page/match-edit1');
                    } else {
                      await communityEditProvider.setPostInfo(
                          communityBoardDetailProvider.communityDetailBoard);
                      commonNavigator.pushRoute(
                          '/board-list/community-board-detail/community-edit1');
                    }
                    commonProvider.changeIsLoading(false);
                  },
                  child: Center(
                    child: Text(
                      "수정하기",
                      style: TextTypes.body02(
                        color: Palette.text01,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Palette.line02,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: () {
                    if (context.mounted) {
                      context.pop();
                    }
                    commonNavigator.showDoubleDialog(
                        content: "정말 게시물을 삭제하시겠어요?\n삭제한 게시물은 되돌릴 수 없어요",
                        leftText: '취소',
                        rightText: '삭제',
                        leftFun: () {
                          commonNavigator.goBack();
                        },
                        rightFun: () async {
                          if (boardType == "match") {
                            await viewModel.deleteMatchBoard(postNo).then(
                              (value) async {
                                commonProvider.changeIsLoading(true);
                                await boardViewModel.getInitMatchBoardList();
                                commonProvider.changeSelectedPage('board_list');
                                commonProvider.changeIsLoading(false);
                              },
                            );
                          } else {
                            await viewModel.deleteCommunityBoard(postNo);
                          }
                        });
                  },
                  child: Center(
                    child: Text(
                      "삭제하기",
                      style: TextTypes.body02(
                        color: Palette.error01,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Palette.line02,
              ),
            ] else
              ...[],
            SizedBox(
              height: 50,
              width: double.infinity,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  context.pop();
                },
                child: Center(
                  child: Text(
                    "취소",
                    style: TextTypes.body02(
                      color: Palette.text04,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
