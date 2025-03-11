import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../provider/board/match_board_detail_provider.dart';

class MatchBoardImageViewDetailPage extends StatelessWidget {
  const MatchBoardImageViewDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final matchBoardDetailProvider =
        Provider.of<MatchBoardDetailProvider>(context);
    final double appBarHeight = AppBar().preferredSize.height;
    final double safePadding = MediaQuery.of(context).padding.top;
    const double bottomAppBarHeight = 128.0; // 바텀 앱바 높이

    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: GestureDetector(
        onTap: () {
          matchBoardDetailProvider.toggleAppbarVisible(); // 앱바의 가시성 토글
        },
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.network(
                matchBoardDetailProvider.previewImageList[
                    matchBoardDetailProvider.previewImageIndex],
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // 상단 AppBar
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              top: matchBoardDetailProvider.isAppBarVisible
                  ? 0
                  : -appBarHeight - safePadding,
              left: 0,
              right: 0,
              child: AppBar(
                scrolledUnderElevation: 0,
                backgroundColor: const Color(0xCC000000),
                centerTitle: true,
                leading: IconButton(
                  hoverColor: Colors.transparent,
                  icon: SvgPicture.asset(
                    'assets/icons/justify_before.svg',
                    colorFilter: const ColorFilter.mode(
                      Color(0xffffffff),
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () {
                    context.go('/match-board-detail-page/match-image-view');
                  },
                ),
                title: Text.rich(
                  TextSpan(
                    text: '${matchBoardDetailProvider.previewImageIndex + 1}',
                    style: TextTypes.body02(color: Palette.primaryBG02),
                    children: [
                      TextSpan(
                        text:
                            '/${matchBoardDetailProvider.previewImageList.length}',
                        style: TextTypes.body02(color: Palette.bgBackGround),
                      ),
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                    hoverColor: Colors.transparent,
                    icon: SvgPicture.asset(
                      'assets/icons/close.svg',
                      colorFilter: const ColorFilter.mode(
                        Color(0xffffffff),
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ],
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              bottom: matchBoardDetailProvider.isAppBarVisible
                  ? 0
                  : -bottomAppBarHeight,
              left: 0,
              right: 0,
              child: Container(
                height: bottomAppBarHeight,
                color: const Color(0xCC000000),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 24,
                      ),
                      ...matchBoardDetailProvider.previewImageList
                          .asMap()
                          .entries
                          .map(
                        (entry) {
                          int index = entry.key;
                          var item = entry.value;

                          double imageSize = 88;

                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: GestureDetector(
                                onTap: () {
                                  matchBoardDetailProvider
                                      .setPreviewImageIndex(index);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: matchBoardDetailProvider
                                                  .previewImageIndex ==
                                              index
                                          ? Palette.primary01
                                          : Palette.icon04,
                                      width: 1,
                                    ),
                                  ),
                                  child: Image.network(
                                    item,
                                    width: imageSize,
                                    height: imageSize,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
