import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/provider/auth/login_provider.dart';
import 'package:app_front_talearnt/provider/profile/profile_provider.dart';
import 'package:app_front_talearnt/view/board/match_board/widget/match_board_selected_chip_list.dart';
import 'package:app_front_talearnt/view/widget/home_board_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../view_model/board_view_model.dart';
import '../view_model/keyword_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final keywordViewModel = Provider.of<KeywordViewModel>(context);
    final loginProvider = Provider.of<LoginProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    final viewModel = Provider.of<BoardViewModel>(context);

    final List<String> matchBoardList =
        List.generate(10, (index) => 'Match $index');

    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Palette.line01,
              width: 1.0,
            ),
          ),
        ),
        child: BottomAppBar(
          color: Palette.bgBackGround,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/icons/home_on.svg'),
                      const Text('홈'),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await viewModel.getInitTalentExchangePosts();
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/icons/post_off.svg'),
                      const Text(
                        '게시글',
                        style: TextStyle(
                          color: Color(0xFFA6B0B5),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await keywordViewModel.getOfferedKeywords();
                    context.push('/match_write1');
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/icons/write_off.svg'),
                      const Text(
                        '글쓰기',
                        style: TextStyle(
                          color: Color(0xFFA6B0B5),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.push('/community-write1');
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/icons/chat_off.svg'),
                      const Text(
                        '채팅',
                        style: TextStyle(
                          color: Color(0xFFA6B0B5),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/icons/my_off.svg'),
                      const Text(
                        '마이',
                        style: TextStyle(
                          color: Color(0xFFA6B0B5),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: profileProvider.userProfile.nickname,
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
                              onTap: () {},
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
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: [
                            const SizedBox(width: 24),
                            ...matchBoardList.map((match) {
                              return const Padding(
                                padding: EdgeInsets.only(right: 14),
                                child: HomeMatchBoardCard(),
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
                          horizontal: 24,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "단 3초! 로그인하고 확인해보세요",
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                            const PrimaryS(
                              content: "로그인",
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
                        '신규 매칭 게시물이 올라왔어요!',
                        style: TextTypes.bodySemi01(
                          color: Palette.text01,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
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
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      const SizedBox(width: 24),
                      ...matchBoardList.map((match) {
                        return const Padding(
                          padding: EdgeInsets.only(right: 14),
                          child: HomeMatchBoardCard(),
                        );
                      }).toList(),
                    ],
                  ),
                )
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
                        onTap: () {},
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
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      const SizedBox(width: 24),
                      ...matchBoardList.map((match) {
                        return const Padding(
                          padding: EdgeInsets.only(right: 14),
                          child: HomeCommunityCard(),
                        );
                      }).toList(),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
