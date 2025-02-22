import 'package:app_front_talearnt/provider/board/common_board_provider.dart';
import 'package:app_front_talearnt/view/board/after_filter_no_board_list_page.dart';
import 'package:app_front_talearnt/view/board/community_board/widget/community_board_list_card.dart';
import 'package:app_front_talearnt/view/board/community_board/widget/community_board_list_tab_bar.dart';
import 'package:app_front_talearnt/view/board/match_board/widget/match_board_list_card.dart';
import 'package:app_front_talearnt/view/board/match_board/widget/match_board_list_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/theme.dart';
import '../../../provider/board/match_board_provider.dart';
import '../../../view_model/board_view_model.dart';
import '../../provider/board/community_board_provider.dart';
import 'no_board_list_page.dart';
import 'widget/board_custom_app_bar.dart';

class BoardList extends StatelessWidget {
  const BoardList({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BoardViewModel>(context);
    final MatchBoardProvider matchBoardProvider =
        Provider.of<MatchBoardProvider>(context);
    final CommunityBoardProvider communityBoardProvider =
        Provider.of<CommunityBoardProvider>(context);
    matchBoardProvider.setViewModel(viewModel);
    return Scaffold(body: SafeArea(
      child: Consumer<CommonBoardProvider>(
        builder: (subContext, commonBoardProvider, child) {
          final int childCount = (commonBoardProvider.boardType == 'match'
              ? matchBoardProvider.talentExchangePosts.length
              : communityBoardProvider.communityPosts.length);

          return CustomScrollView(
            controller: commonBoardProvider.boardType == 'match'
                ? matchBoardProvider.scrollController
                : communityBoardProvider.scrollController,
            slivers: [
              SliverAppBar(
                pinned: false,
                floating: true,
                snap: true,
                backgroundColor: Palette.bgBackGround,
                elevation: 0,
                toolbarHeight: 56,
                leading: null,
                automaticallyImplyLeading: false,
                flexibleSpace: BoardCustomAppBar(
                  type: commonBoardProvider.boardType,
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: commonBoardProvider.boardType == 'match'
                    ? MatchBoardListTabBar()
                    : CommunityBoardListTabBar(),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    List<dynamic> posts =
                        commonBoardProvider.boardType == 'match'
                            ? matchBoardProvider.talentExchangePosts
                            : communityBoardProvider.communityPosts;
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
                    return commonBoardProvider.boardType == 'match'
                        ? InkWell(
                            overlayColor:
                                WidgetStateProperty.all(Colors.transparent),
                            onTap: () async {
                              int postNo =
                                  commonBoardProvider.boardType == 'match'
                                      ? matchBoardProvider
                                          .talentExchangePosts[index]
                                          .exchangePostNo
                                      : communityBoardProvider
                                          .communityPosts[index].exchangePostNo;
                              await viewModel.getTalentDetailPost(postNo);
                            },
                            child: MatchBoardListCard(
                                post: posts[index], index: index))
                        : CommunityBoardListCard(
                            post: posts[index], index: index);
                  },
                  childCount: childCount == 0 ? 1 : childCount,
                ),
              ),
            ],
          );
        },
      ),
    ));
  }
}
