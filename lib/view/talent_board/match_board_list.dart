import 'package:app_front_talearnt/view/talent_board/widget/board_list_card.dart';
import 'package:app_front_talearnt/view/talent_board/widget/board_list_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/theme.dart';
import '../../common/widget/board_custom_app_bar.dart';
import '../../provider/talent_board/talent_board_provider.dart';

class MatchBoardList extends StatelessWidget {
  const MatchBoardList({super.key});

  @override
  Widget build(BuildContext context) {
    final TalentBoardProvider talentBoardProvider =
        Provider.of<TalentBoardProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              pinned: false,
              floating: true,
              snap: true,
              backgroundColor: Palette.bgBackGround,
              elevation: 0,
              toolbarHeight: 56,
              leading: null,
              automaticallyImplyLeading: false,
              flexibleSpace: BoardCustomAppBar(),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: BoardListTabBar(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final posts = talentBoardProvider.talentExchangePosts;

                  if (posts.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "게시글이 없습니다.",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    );
                  }

                  return BoardListCard(post: posts[index], index: index);
                },
                childCount: talentBoardProvider.talentExchangePosts.isEmpty
                    ? 1
                    : talentBoardProvider.talentExchangePosts.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
