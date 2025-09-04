import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:app_front_talearnt/view/board/community_board/widget/community_board_list_card.dart';
import 'package:app_front_talearnt/view/board/match_board/widget/match_board_list_card.dart';
import 'package:app_front_talearnt/view_model/board_view_model.dart';
import 'package:app_front_talearnt/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/theme.dart';
import '../../common/widget/loading.dart';
import '../../constants/global_value_constants.dart';
import '../../provider/profile/profile_provider.dart';

class MyWritePage extends StatefulWidget {
  const MyWritePage({Key? key}) : super(key: key);

  @override
  State<MyWritePage> createState() => MyWritePageState();
}

class MyWritePageState extends State<MyWritePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final profileProvider = Provider.of<ProfileProvider>(context);
    final commonProvider = Provider.of<CommonProvider>(context);
    final profileViewModel = Provider.of<ProfileViewModel>(context);

    profileProvider.myWriteTabController.addListener(() async {
      if (!profileProvider.myWriteTabController.indexIsChanging) {
        if (!profileProvider.isFirstTabChange) {
          profileProvider.setTabChange();
          return;
        }

        commonProvider.changeIsLoading(true);
        final index = profileProvider.myWriteTabController.index;
        if (index == 0) {
          await profileViewModel.getMyWriteMatchBoardList(
              null, null, null, 'reset');
        } else {
          await profileViewModel.getMyWriteCommunityBoardList(
              GlobalValueConstants.communityCategoryTypes[0]['code']!,
              null,
              null,
              null,
              null,
              'reset');
        }
        commonProvider.changeIsLoading(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final boardViewModel = Provider.of<BoardViewModel>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    final commonProvider = Provider.of<CommonProvider>(context);

    return Scaffold(
        appBar: TopAppBar(
          content: "내가 작성한 게시물",
          onPressed: () {
            context.pop();
          },
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TabBar(
                    controller: profileProvider.myWriteTabController,
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 2.0,
                      ),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Palette.text01,
                    indicatorWeight: 1.0,
                    indicatorPadding: const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    dividerColor: Colors.transparent,
                    labelColor: Palette.text01,
                    labelStyle: TextTypes.body02(color: Palette.text01),
                    unselectedLabelStyle:
                        TextTypes.body02(color: Palette.text03),
                    tabs: const [
                      Tab(text: '매칭'),
                      Tab(text: '커뮤니티'),
                    ],
                  ),
                ),
                Container(
                  height: 16,
                ),
                Expanded(
                  child: TabBarView(
                    controller: profileProvider.myWriteTabController,
                    children: [
                      CustomScrollView(
                          controller:
                              profileProvider.myWriteMatchScrollController,
                          slivers: [
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return InkWell(
                                      overlayColor: WidgetStateProperty.all(
                                          Colors.transparent),
                                      onTap: () async {
                                        commonProvider.changeIsLoading(true);
                                        await boardViewModel
                                            .getMatchDetailBoard(profileProvider
                                                .matchBoardList[index]
                                                .exchangePostNo);
                                        commonProvider.changeIsLoading(false);
                                      },
                                      child: MatchBoardListCard(
                                        post: profileProvider
                                            .matchBoardList[index],
                                        index: index,
                                        pageType: 'my-write',
                                      ));
                                },
                                childCount:
                                    profileProvider.matchBoardList.length,
                              ),
                            )
                          ]),
                      CustomScrollView(
                          controller:
                              profileProvider.myWriteCommunityScrollController,
                          slivers: [
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return InkWell(
                                      overlayColor: WidgetStateProperty.all(
                                          Colors.transparent),
                                      onTap: () async {
                                        commonProvider.changeIsLoading(true);
                                        await boardViewModel
                                            .getCommunityDetailBoard(
                                                profileProvider
                                                    .communityBoardList[index]
                                                    .communityPostNo);
                                        commonProvider.changeIsLoading(false);
                                      },
                                      child: CommunityBoardListCard(
                                        post: profileProvider
                                            .communityBoardList[index],
                                        index: index,
                                        pageType: 'my-write',
                                      ));
                                },
                                childCount:
                                    profileProvider.communityBoardList.length,
                              ),
                            )
                          ])
                    ],
                  ),
                ),
              ],
            ),
            if (commonProvider.isLoadingPage) const LoadingWithCharacter()
          ],
        ));
  }
}
