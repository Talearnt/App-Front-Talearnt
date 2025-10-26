import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../provider/board/common_board_provider.dart';
import '../../../provider/board/community_board_provider.dart';
import '../../../provider/board/match_board_provider.dart';
import '../../../view_model/board_view_model.dart';

class BoardCustomAppBar extends StatelessWidget {
  final String type;

  const BoardCustomAppBar({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final CommonBoardProvider commonBoardProvider =
        Provider.of<CommonBoardProvider>(context);
    final viewModel = Provider.of<BoardViewModel>(context);
    final MatchBoardProvider matchBoardProvider =
        Provider.of<MatchBoardProvider>(context);
    final CommunityBoardProvider communityBoardProvider =
        Provider.of<CommunityBoardProvider>(context);
    return Container(
      height: kToolbarHeight,
      decoration: BoxDecoration(
        color: Palette.bgBackGround,
        border: type == "match"
            ? const Border(
                bottom: BorderSide(
                  color: Palette.line02,
                  width: 1.0,
                ),
              )
            : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 왼쪽 버튼 그룹
          Row(
            children: [
              TextButton(
                onPressed: () {
                  viewModel.getMatchBoardList(
                    matchBoardProvider.selectedGiveTalentKeywordCodes
                        .map((e) => e.toString())
                        .toList(),
                    matchBoardProvider.selectedInterestTalentKeywordCodes
                        .map((e) => e.toString())
                        .toList(),
                    matchBoardProvider.selectedOrderType,
                    matchBoardProvider.selectedDurationType,
                    null,
                    null,
                    null,
                    null,
                    null,
                    "reset",
                  );
                  commonBoardProvider.setBoardType("match");
                  commonBoardProvider.updateInitState(true);
                },
                style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all(Size.zero),
                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                child: Text('매칭',
                    style: TextTypes.bodySemi01(
                        color:
                            type == "match" ? Palette.text01 : Palette.text04)),
              ),
              const SizedBox(width: 20),
              TextButton(
                onPressed: () {
                  viewModel.getCommunityBoardList(
                      communityBoardProvider.selectedPostType,
                      communityBoardProvider.selectedOrderType,
                      null,
                      null,
                      null,
                      null);
                  commonBoardProvider.setBoardType("community");
                  commonBoardProvider.updateInitState(true);
                },
                style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all(Size.zero),
                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                child: Text('커뮤니티',
                    style: TextTypes.bodySemi01(
                        color: type == "community"
                            ? Palette.text01
                            : Palette.text04)),
              ),
            ],
          ),
          // 오른쪽 아이콘 버튼
          IconButton(
            hoverColor: Colors.transparent,
            icon: SvgPicture.asset(
              'assets/icons/bell_off.svg',
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
