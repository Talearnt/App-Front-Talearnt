import 'package:app_front_talearnt/common/widget/loading.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:app_front_talearnt/provider/board/common_board_provider.dart';
import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:app_front_talearnt/view/board/match_board/no_match_board_like_list_page.dart';
import 'package:app_front_talearnt/view/board/match_board/widget/match_board_list_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../provider/board/match_board_provider.dart';
import '../../../view_model/board_view_model.dart';

class MatchBoardLikePage extends StatelessWidget {
  const MatchBoardLikePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BoardViewModel>(context);
    final MatchBoardProvider matchBoardProvider =
        Provider.of<MatchBoardProvider>(context);
    final commonProvider = Provider.of<CommonProvider>(context);

    matchBoardProvider.setViewModel(viewModel);
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: CustomScrollView(
                    controller: matchBoardProvider.scrollController,
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            List<dynamic> posts =
                                matchBoardProvider.matchBoardList;
                            if (posts.isEmpty) {
                              return const NoMatchBoardLikeListPage();
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
                                    post: posts[index], index: index, pageType: 'list',));
                          },
                          childCount: childCount == 0 ? 1 : childCount,
                        ),
                      ),
                    ],
                  ),
                ),
                if (commonProvider.isLoadingPage) const LoadingWithCharacter()
              ],
            );
          },
        ),
      ),
    );
  }
}
