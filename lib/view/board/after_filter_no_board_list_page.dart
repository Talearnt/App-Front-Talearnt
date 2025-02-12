import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../common/theme.dart';
import '../../common/widget/button.dart';
import '../../provider/board/community_board_provider.dart';
import '../../provider/board/match_board_provider.dart';
import '../../provider/common/common_provider.dart';
import '../../view_model/board_view_model.dart';

class AfterFilterNoBoardListPage extends StatelessWidget {
  final String boardType;

  const AfterFilterNoBoardListPage({super.key, required this.boardType});

  @override
  Widget build(BuildContext context) {
    final matchBoardProvider = Provider.of<MatchBoardProvider>(context);
    final communityBoardProvider = Provider.of<CommunityBoardProvider>(context);
    final boardViewModel = Provider.of<BoardViewModel>(context);
    final commonProvider = Provider.of<CommonProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(
            height: 99,
          ),
          SvgPicture.asset('assets/icons/no_board_list_logo.svg'),
          const SizedBox(height: 28),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '해당 게시물이 없어요...',
                style: TextTypes.heading2(color: Palette.text01),
              ),
              const SizedBox(height: 8),
              Text(
                '필터 변경 후 다시 시도해 보세요',
                style: TextTypes.bodyMedium01(color: Palette.text02),
              ),
            ],
          ),
          const SizedBox(height: 56),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SecondaryMGray(
              content: '필터 초기화하기',
              onPressed: () async {
                if (boardType == 'match') {
                  matchBoardProvider.resetFilter();
                  commonProvider.changeIsLoading(true);
                  await boardViewModel
                      .getTalentExchangePosts(
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
                          null)
                      .whenComplete(
                          () => commonProvider.changeIsLoading(false));
                } else {
                  communityBoardProvider.resetFilter();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
