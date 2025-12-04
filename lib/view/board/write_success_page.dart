import 'package:app_front_talearnt/provider/board/match_board_provider.dart';
import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:app_front_talearnt/view_model/board_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/theme.dart';
import '../../common/widget/button.dart';
import '../../common/widget/top_app_bar.dart';
import '../../provider/board/community_write_provider.dart';
import '../../provider/board/match_write_provider.dart';

class WriteSuccessPage extends StatelessWidget {
  const WriteSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final matchWriteProvider = Provider.of<MatchWriteProvider>(context);
    final communityWriteProvider = Provider.of<CommunityWriteProvider>(context);
    final viewModel = Provider.of<BoardViewModel>(context);
    final commonProvider = Provider.of<CommonProvider>(context);
    final matchBoardProvider = Provider.of<MatchBoardProvider>(context);

    return Scaffold(
      backgroundColor: Palette.bgBackGround,
      appBar: TopAppBar(
        leftIcon: false,
        first: GestureDetector(
            onTap: () {
              matchWriteProvider.clearProvider();
              communityWriteProvider.clearProvider();
              context.go('/home');
            },
            child: SvgPicture.asset("assets/icons/close.svg")),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 99,
            ),
            SvgPicture.asset('assets/img/success_sign_up_logo.svg'),
            const SizedBox(height: 43),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '글을 성공적으로 작성했어요!',
                  style: TextTypes.heading2(color: Palette.text01),
                ),
                const SizedBox(height: 12),
                Text(
                  '재능 교환 신청이 올 때까지',
                  style: TextTypes.bodyMedium01(color: Palette.text02),
                ),
                Text(
                  '조금만 기다려주세요',
                  style: TextTypes.bodyMedium01(color: Palette.text02),
                ),
              ],
            ),
            const SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PrimaryM(
                content: '내가 쓴 글 확인하기',
                onPressed: () async {
                  commonProvider.changeIsLoading(true);
                  await viewModel.getMatchDetailBoard(matchWriteProvider.postNo,
                      source: 'checkMyWrite');
                  communityWriteProvider.clearProvider();
                  matchWriteProvider.clearProvider();
                  commonProvider.changeIsLoading(false);
                },
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SecondaryMGray(
                content: '홈으로 돌아가기',
                onPressed: () {
                  communityWriteProvider.clearProvider();
                  matchWriteProvider.clearProvider();
                  context.go('/home');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
