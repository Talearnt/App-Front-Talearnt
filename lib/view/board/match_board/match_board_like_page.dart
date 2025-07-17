import 'package:app_front_talearnt/common/widget/loading.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:app_front_talearnt/provider/board/common_board_provider.dart';
import 'package:app_front_talearnt/provider/board/community_board_provider.dart';
import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:app_front_talearnt/view/board/after_filter_no_board_list_page.dart';
import 'package:app_front_talearnt/view/board/community_board/widget/community_board_list_card.dart';
import 'package:app_front_talearnt/view/board/match_board/widget/match_board_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../provider/board/match_board_provider.dart';
import '../../../view_model/board_view_model.dart';
import '../../../../common/widget/common_bottom_navigation_bar.dart';
import '../no_board_list_page.dart';

class MatchBoardLikePage extends StatelessWidget {
  const MatchBoardLikePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BoardViewModel>(context);
    final MatchBoardProvider matchBoardProvider =
        Provider.of<MatchBoardProvider>(context);
    final CommunityBoardProvider communityBoardProvider =
        Provider.of<CommunityBoardProvider>(context);
    final commonProvider = Provider.of<CommonProvider>(context);

    matchBoardProvider.setViewModel(viewModel);
    communityBoardProvider.setViewModel(viewModel);
    return Scaffold(
        appBar: TopAppBar(
          content: "찜 게시물",
          onPressed: () {
            context.pop();
          },
        ),
        body: SafeArea(
          child: Consumer<CommonBoardProvider>(
            builder: (subContext, commonBoardProvider, child) {
              final int childCount = (matchBoardProvider.matchBoardList.length);
              return Stack(
                children: [
                  CustomScrollView(
                    controller: matchBoardProvider.scrollController,
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            List<dynamic> posts =
                                matchBoardProvider.matchBoardList;
                            if (posts.isEmpty) {
                              if (commonBoardProvider.initState) {
                                return NoBoardListPage(
                                  boardType: commonBoardProvider.boardType,
                                );
                              } else {
                                return AfterFilterNoBoardListPage(
                                  boardType: commonBoardProvider.boardType,
                                );
                              }
                            }
                            return InkWell(
                                overlayColor:
                                    WidgetStateProperty.all(Colors.transparent),
                                onTap: () async {
                                  commonProvider.changeIsLoading(true);
                                  await viewModel.getMatchDetailBoard(
                                      matchBoardProvider.matchBoardList[index]
                                          .exchangePostNo);
                                  commonProvider.changeIsLoading(false);
                                },
                                child: MatchBoardListCard(
                                    post: posts[index], index: index));
                          },
                          childCount: childCount == 0 ? 1 : childCount,
                        ),
                      ),
                    ],
                  ),
                  const CommonBottomNavigationBar(),
                  if (commonProvider.isLoadingPage) const LoadingWithCharacter()
                ],
              );
            },
          ),
        ));
  }
}
