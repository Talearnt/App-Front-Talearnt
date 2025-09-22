import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/loading.dart';
import 'package:app_front_talearnt/provider/auth/login_provider.dart';
import 'package:app_front_talearnt/provider/board/match_board_provider.dart';
import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:app_front_talearnt/provider/home/home_provider.dart';
import 'package:app_front_talearnt/provider/notification/notification_provider.dart';
import 'package:app_front_talearnt/provider/profile/profile_provider.dart';
import 'package:app_front_talearnt/view/widget/home_board_card.dart';
import 'package:app_front_talearnt/view_model/notification_view_model.dart';
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

  static bool _hasLoaded = false;
  static bool _wasLoggedIn = false;

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
    final NotificationViewModel notificationViewModel =
        Provider.of<NotificationViewModel>(context);
    final NotificationProvider notificationProvider =
        Provider.of<NotificationProvider>(context);

    Future<void> loadHome() async {
      commonProvider.changeIsLoading(true);
      final futures = <Future>[];
      if (homeProvider.newTalentExchangePosts.isEmpty) {
        futures.add(viewModel.getMatchBoardList(
            [], [], '', '', '', '', '', '', '10', '', 'new'));
      }
      if (homeProvider.bestCommunityPosts.isEmpty) {
        futures.add(
            viewModel.getBestCommunityBoardList("", "hot", "", "", "10", ""));
      }
      if (loginProvider.isLoggedIn &&
          homeProvider.userMatchingTalentExchangePosts.isEmpty) {
        final giveTalents = profileProvider.userProfile.giveTalents
            .map((e) => e.toString())
            .toList();
        futures.add(viewModel.getMatchBoardList(
            giveTalents, [], '', '', '', '', '', '', '10', '', 'userMatch'));
      }
      await Future.wait(futures);
      commonProvider.changeIsLoading(false);
    }

    if (!_hasLoaded) {
      _hasLoaded = true;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        _wasLoggedIn = loginProvider.isLoggedIn;
        // 비로그인 상태일 때만 최초 loadHome 실행
        if (!loginProvider.isLoggedIn) {
          await loadHome();
        }
      });
    }

    if (loginProvider.isLoggedIn && !_wasLoggedIn) {
      // 로그인 성공 시 홈 다시 로드
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await loadHome();
      });
      _wasLoggedIn = true;
    } else if (!loginProvider.isLoggedIn && _wasLoggedIn) {
      // 로그아웃 시 홈 다시 로드
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await loadHome();
      });
      _wasLoggedIn = false;
    }

    Future<void> getList(
      CommonProvider commonProvider,
      BoardViewModel boardViewModel,
      MatchBoardProvider matchBoardProvider,
    ) async {
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
            "reset",
          )
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
                            horizontal: 20, vertical: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 1, bottom: 1, left: 8),
                              child: SvgPicture.asset(
                                  'assets/icons/default_logo.svg',
                                  width: 112,
                                  height: 22),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await notificationViewModel.getNotification();
                                context.push('/alarm');
                              },
                              child: SvgPicture.asset(
                                notificationProvider.notifications
                                        .any((n) => n.isRead == false)
                                    ? 'assets/icons/bell_on.svg'
                                    : 'assets/icons/bell_off.svg',
                                width: 18,
                                height: 20,
                              ),
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
                      const SizedBox(height: 36),
                      loginProvider.isLoggedIn
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("관심있는 키워드를 반영했어요",
                                        style: TextTypes.captionMedium02(
                                            color: Palette.text02)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.35), // 원하는 최대 너비
                                                child: Text(
                                                  profileProvider
                                                      .userProfile.nickname,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextTypes.bodySemi01(
                                                      color: Palette.primary01),
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                            TextSpan(
                                              text: '님을 위한 맞춤 매칭',
                                              style: TextTypes.bodySemi01(
                                                  color: Palette.text01),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          matchBoardProvider
                                              .setSelectedInterestTalentKeyword(
                                                  profileProvider.userProfile
                                                      .receiveTalents);
                                          commonBoardProvider
                                              .updateInitState(false);
                                          await getList(commonProvider,
                                              viewModel, matchBoardProvider);
                                          commonProvider
                                              .changeSelectedPage('board_list');
                                          await context.push('/board-list');
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('더보기',
                                                style: TextTypes.caption01(
                                                    color: Palette.text03)),
                                            SvgPicture.asset(
                                                'assets/icons/add_more_arrow.svg',
                                                width: 24,
                                                height: 24),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
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
                                                      post.exchangePostNo)
                                                  .then((value) {
                                                commonProvider
                                                    .changeIsLoading(false);
                                              });
                                            },
                                            child: HomeBoardCard(
                                              post: post,
                                              type: 'user',
                                            ),
                                          ),
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
                                            child: Text("단 3초! 로그인하고 확인해보세요",
                                                style:
                                                    TextTypes.captionMedium02(
                                                        color: Palette.text02)),
                                          ),
                                          const SizedBox(height: 2),
                                          Text.rich(
                                            TextSpan(
                                              text: '회원',
                                              style: TextTypes.bodySemi01(
                                                  color: Palette.primary01),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: '님을 위한 맞춤 매칭',
                                                    style: TextTypes.bodySemi01(
                                                        color: Palette.text01)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      PrimaryS(
                                        content: "로그인",
                                        onPressed: () async {
                                          await context.push("/login");
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),
                                const Divider(
                                    thickness: 8, color: Palette.line02),
                              ],
                            ),
                      const SizedBox(height: 44),
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
                                      Text('신규 매칭 게시물이 올라왔어요!',
                                          style: TextTypes.bodySemi01(
                                              color: Palette.text01)),
                                      GestureDetector(
                                        onTap: () async {
                                          commonProvider.changeIsLoading(true);
                                          await viewModel
                                              .getInitMatchBoardList()
                                              .then((value) {
                                            commonProvider.changeSelectedPage(
                                                'board_list');
                                            commonProvider
                                                .changeIsLoading(false);
                                          });
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('더보기',
                                                style: TextTypes.caption01(
                                                    color: Palette.text03)),
                                            SvgPicture.asset(
                                                'assets/icons/add_more_arrow.svg',
                                                width: 24,
                                                height: 24),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
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
                                                      post.exchangePostNo)
                                                  .then((value) {
                                                commonProvider
                                                    .changeIsLoading(false);
                                              });
                                            },
                                            child: HomeBoardCard(
                                              post: post,
                                              type: 'new',
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                      const SizedBox(height: 44),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text('BEST 커뮤니티 글만 모아봤어요!',
                                      style: TextTypes.bodySemi01(
                                          color: Palette.text01),
                                      overflow: TextOverflow.ellipsis),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    commonProvider.changeIsLoading(true);
                                    await viewModel.getInitCommunityBoardList();
                                    commonBoardProvider
                                        .setBoardType("community");
                                    commonBoardProvider.updateInitState(true);
                                    commonProvider
                                        .changeSelectedPage('board_list');
                                    commonProvider.changeIsLoading(false);
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('더보기',
                                          style: TextTypes.caption01(
                                              color: Palette.text03)),
                                      SvgPicture.asset(
                                          'assets/icons/add_more_arrow.svg',
                                          width: 24,
                                          height: 24),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          homeProvider.bestCommunityPosts.isEmpty
                              ? const Row(children: [
                                  SizedBox(width: 24),
                                  HomeNullCard()
                                ])
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
                                                      post.communityPostNo)
                                                  .then((value) {
                                                commonProvider
                                                    .changeIsLoading(false);
                                              });
                                            },
                                            child: HomeCommunityCard(
                                                post: post, ranking: ranking),
                                          ),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                )
                        ],
                      ),
                      const SizedBox(height: 44),
                      Container(
                        width: double.infinity,
                        height: 800,
                        decoration: BoxDecoration(
                          color: Palette.bgUp01,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 32,
                            horizontal: 24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/default_logo.svg',
                                height: 22,
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '회사소개',
                                    style: TextTypes.captionMedium02(
                                        color: Palette.text03),
                                  ),
                                  VerticalDivider(
                                    color: Palette.line02,
                                    thickness: 1,
                                  ),
                                  Text(
                                    '이벤트',
                                    style: TextTypes.captionMedium02(
                                        color: Palette.text03),
                                  ),
                                  VerticalDivider(
                                    color: Palette.line02,
                                    thickness: 1,
                                  ),
                                  Text(
                                    '공지사항',
                                    style: TextTypes.captionMedium02(
                                        color: Palette.text03),
                                  ),
                                  VerticalDivider(
                                    color: Palette.line02,
                                    thickness: 1,
                                  ),
                                  Text(
                                    '이용약관',
                                    style: TextTypes.captionMedium02(
                                        color: Palette.text03),
                                  ),
                                  VerticalDivider(
                                    color: Palette.line02,
                                    thickness: 1,
                                  ),
                                  Text(
                                    '개인정보처리방침',
                                    style: TextTypes.captionMedium02(
                                        color: Palette.text02),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Divider(
                                color: Palette.line02,
                                height: 1,
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Text(
                                '회사명 세븐피커',
                                style: TextTypes.caption01(
                                  color: Palette.text03,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                '사업자등록번호 418-35-01518',
                                style: TextTypes.caption01(
                                  color: Palette.text03,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                '대표자 정운만',
                                style: TextTypes.caption01(
                                  color: Palette.text03,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                '대표 이메일 woong9421@nate.com',
                                style: TextTypes.caption01(
                                  color: Palette.text03,
                                ),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Divider(
                                color: Palette.line01,
                                height: 1,
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Text(
                                'Copyright © Talearnt. All Rights Reserved.',
                                style: TextTypes.caption01(
                                  color: Palette.text03,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Icons by FREE Icons for Figma (CC BY 4.0)\nhttps://www.figma.com/community/file/1177180791780461401',
                                style: TextTypes.caption01(
                                  color: Palette.text03,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            const CommonBottomNavigationBar(),
            if (commonProvider.isLoadingPage) const LoadingWithCharacter(),
          ],
        ),
      ),
    );
  }
}
