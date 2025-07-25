import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/loading.dart';
import 'package:app_front_talearnt/provider/auth/login_provider.dart';
import 'package:app_front_talearnt/provider/board/match_board_provider.dart';
import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:app_front_talearnt/provider/home/home_provider.dart';
import 'package:app_front_talearnt/provider/profile/profile_provider.dart';
import 'package:app_front_talearnt/view/widget/home_board_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../common/widget/button.dart';
import '../common/widget/common_bottom_navigation_bar.dart';
import '../provider/board/common_board_provider.dart';
import '../view_model/board_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final loginProvider = Provider.of<LoginProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    final viewModel = Provider.of<BoardViewModel>(context);
    final commonProvider = Provider.of<CommonProvider>(context);
    final CommonBoardProvider commonBoardProvider =
        Provider.of<CommonBoardProvider>(context);
    final MatchBoardProvider matchBoardProvider =
        Provider.of<MatchBoardProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        commonProvider.changeIsLoading(true);
        if (homeProvider.newTalentExchangePosts.isEmpty) {
          await context.read<BoardViewModel>().getMatchBoardList(
              [], [], '', '', '', '', '', '', '10', '', "new");
        }

        if (homeProvider.bestCommunityPosts.isEmpty) {
          await context
              .read<BoardViewModel>()
              .getBestCommunityBoardList("", "hot", "", "", "10", "");
        }

        if (homeProvider.userMatchingTalentExchangePosts.isEmpty &&
            loginProvider.isLoggedIn) {
          await context.read<BoardViewModel>().getMatchBoardList(
              profileProvider.userProfile.giveTalents
                  .map((e) => e.toString())
                  .toList(),
              [],
              '',
              '',
              '',
              '',
              '',
              '',
              '10',
              '',
              "userMatch");
          await context.read<BoardViewModel>().getMatchBoardList(
              [], [], '', '', '', '', '', '', '10', '', "new");
          await context
              .read<BoardViewModel>()
              .getBestCommunityBoardList("", "hot", "", "", "10", "");
        }
        commonProvider.changeIsLoading(false);
      },
    );

    Future<void> getList(
        CommonProvider commonProvider,
        BoardViewModel boardViewModel,
        MatchBoardProvider matchBoardProvider) async {
      commonProvider.changeIsLoading(true);
      await boardViewModel
          .getMatchBoardList(
              matchBoardProvider.selectedGiveTalentKeywordCodes
                  .map((e) => e.toString())
                  .toList(),
              matchBoardProvider.selectedInterestTalentKeywordCodes
                  .map((e) => e.toString())
                  .toList(),
              matchBoardProvider.selectedOrderType,
              matchBoardProvider.selectedDurationType,
              matchBoardProvider.selectedOperationType,
              null,
              null,
              null,
              null,
              null,
              "reset")
          .whenComplete(() => commonProvider.changeIsLoading(false));
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 1,
                                bottom: 1,
                                left: 8,
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/default_logo.svg',
                                width: 112,
                                height: 22,
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/icons/bell_off.svg',
                              width: 18,
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: AspectRatio(
                          aspectRatio: 375 / 188,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SvgPicture.asset(
                              'assets/img/main_banner1.svg',
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      loginProvider.isLoggedIn
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "관심있는 키워드를 반영했어요",
                                      style: TextTypes.captionMedium02(
                                        color: Palette.text02,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          text: profileProvider
                                              .userProfile.nickname,
                                          style: TextTypes.bodySemi01(
                                            color: Palette.primary01,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '님을 위한 맞춤 매칭',
                                              style: TextTypes.bodySemi01(
                                                color: Palette.text01,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          matchBoardProvider
                                              .setSelectedInterestTalentKeyword(
                                                  profileProvider.userProfile
                                                      .receiveTalents);
                                          commonBoardProvider
                                              .updateInitState(false);
                                          getList(commonProvider, viewModel,
                                              matchBoardProvider);
                                          context.push('/board-list');
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              '더보기',
                                              style: TextTypes.caption01(
                                                color: Palette.text03,
                                              ),
                                            ),
                                            SvgPicture.asset(
                                              'assets/icons/add_more_arrow.svg',
                                              width: 24,
                                              height: 24,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 24),
                                      ...homeProvider
                                          .userMatchingTalentExchangePosts
                                          .map((post) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 14),
                                          child: GestureDetector(
                                              onTap: () async {
                                                commonProvider
                                                    .changeIsLoading(true);
                                                await viewModel
                                                    .getMatchDetailBoard(
                                                  post.exchangePostNo,
                                                )
                                                    .then(
                                                  (value) {
                                                    commonProvider
                                                        .changeIsLoading(false);
                                                  },
                                                );
                                              },
                                              child: HomeMatchBoardCard(
                                                  post: post)),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                )
                              ],
                            )
                          : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "단 3초! 로그인하고 확인해보세요",
                                              style: TextTypes.captionMedium02(
                                                color: Palette.text02,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              text: '회원',
                                              style: TextTypes.bodySemi01(
                                                color: Palette.primary01,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: '님을 위한 맞춤 매칭',
                                                  style: TextTypes.bodySemi01(
                                                    color: Palette.text01,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      PrimaryS(
                                        content: "로그인",
                                        onPressed: () {
                                          context.push("/login");
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                const Divider(
                                  thickness: 8,
                                  color: Palette.line02,
                                )
                              ],
                            ),
                      const SizedBox(
                        height: 44,
                      ),
                      homeProvider.newTalentExchangePosts.isEmpty
                          ? const SizedBox.shrink()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24, right: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '신규 매칭 게시물이 올라왔어요!',
                                        style: TextTypes.bodySemi01(
                                            color: Palette.text01),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          commonProvider.changeIsLoading(true);
                                          await viewModel
                                              .getInitMatchBoardList()
                                              .then(
                                            (value) {
                                              commonProvider
                                                  .changeIsLoading(false);
                                            },
                                          );
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              '더보기',
                                              style: TextTypes.caption01(
                                                  color: Palette.text03),
                                            ),
                                            SvgPicture.asset(
                                              'assets/icons/add_more_arrow.svg',
                                              width: 24,
                                              height: 24,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 24),
                                      ...homeProvider.newTalentExchangePosts
                                          .map((post) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 14),
                                          child: GestureDetector(
                                            onTap: () async {
                                              commonProvider
                                                  .changeIsLoading(true);
                                              await viewModel
                                                  .getMatchDetailBoard(
                                                post.exchangePostNo,
                                              )
                                                  .then(
                                                (value) {
                                                  commonProvider
                                                      .changeIsLoading(false);
                                                },
                                              );
                                            },
                                            child: HomeMatchBoardCard(
                                                post: post),
                                          ),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                      const SizedBox(
                        height: 44,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'BEST 커뮤니티 글만 모아봤어요!',
                                  style: TextTypes.bodySemi01(
                                    color: Palette.text01,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    commonProvider.changeIsLoading(true);
                                    await viewModel.getInitCommunityBoardList();
                                    commonBoardProvider
                                        .setBoardType("community");
                                    commonBoardProvider.updateInitState(true);
                                    commonProvider.changeIsLoading(false);
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '더보기',
                                        style: TextTypes.caption01(
                                          color: Palette.text03,
                                        ),
                                      ),
                                      SvgPicture.asset(
                                        'assets/icons/add_more_arrow.svg',
                                        width: 24,
                                        height: 24,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          homeProvider.bestCommunityPosts.isEmpty
                              ? const Row(
                                  children: [
                                    SizedBox(width: 24),
                                    HomeNullCard(),
                                  ],
                                )
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 24),
                                      ...homeProvider.bestCommunityPosts
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        final ranking = entry.key + 1;
                                        final post = entry.value;

                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 14),
                                          child: GestureDetector(
                                            onTap: () async {
                                              commonProvider
                                                  .changeIsLoading(true);
                                              await viewModel
                                                  .getCommunityDetailBoard(
                                                post.communityPostNo,
                                              )
                                                  .then(
                                                (value) {
                                                  commonProvider
                                                      .changeIsLoading(false);
                                                },
                                              );
                                            },
                                            child: HomeCommunityCard(
                                              post: post,
                                              ranking: ranking,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                )
                        ],
                      ),
                      const SizedBox(
                        height: 108,
                      ),
                    ],
                  ),
                );
              },
            ),
            const CommonBottomNavigationBar(),
            if (commonProvider.isLoadingPage) const LoadingWithCharacter()
          ],
        ),
      ),
    );
  }
}
