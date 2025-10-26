import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/global_value_constants.dart';
import '../../../../provider/board/common_board_provider.dart';
import '../../../../provider/board/match_board_provider.dart';
import '../../../../provider/common/common_provider.dart';
import '../../../../view_model/board_view_model.dart';
import '../../widget/board_filter_chip.dart';
import '../../widget/radio_bottom_sheet.dart';
import 'keyword_filter_bottom_sheet.dart';

class MatchBoardListTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final matchBoardProvider = Provider.of<MatchBoardProvider>(context);
    final boardViewModel = Provider.of<BoardViewModel>(context);
    final commonProvider = Provider.of<CommonProvider>(context);
    final commonBoardProvider = Provider.of<CommonBoardProvider>(context);
    return Container(
      height: maxExtent,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //정렬방식
            BoardFilterChip(
              content: GlobalValueConstants.orderTypes.firstWhere(
                (option) =>
                    option['code'] == matchBoardProvider.selectedOrderType,
              )['value']!,
              function: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  builder: (BuildContext context) {
                    return RadioBottomSheet(
                      sheetTitle: "정렬 방식",
                      bottomSheetContent: GlobalValueConstants.orderTypes,
                      selectedCode: matchBoardProvider.selectedOrderType,
                      changedFunction: (code) {
                        matchBoardProvider.updateOrderType(code);
                        commonBoardProvider.updateInitState(false);
                        getList(
                            commonProvider, boardViewModel, matchBoardProvider);
                      },
                    );
                  },
                );
              },
            ),
            BoardFilterChip(
              content:
                  '받고 싶은 재능 ${matchBoardProvider.selectedInterestTalentKeywordCodes.isEmpty ? '' : matchBoardProvider.selectedInterestTalentKeywordCodes.length}',
              selected: matchBoardProvider
                  .selectedInterestTalentKeywordCodes.isNotEmpty,
              function: () {
                matchBoardProvider.matchInterestKeywordList();
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  builder: (BuildContext context) {
                    return Consumer<MatchBoardProvider>(
                      builder: (context, matchBoardProvider, child) {
                        return KeywordFilterBottomSheet(
                          sheetTitle: '받고 싶은 재능',
                          keywordCodes:
                              matchBoardProvider.interestTalentKeywordCodes,
                          tabController:
                              matchBoardProvider.interestTalentTabController,
                          removeFunction: (code) {
                            matchBoardProvider.removeInterestKeywordList(code);
                          },
                          updateFunction: (codes) {
                            matchBoardProvider.updateInterestKeywordList(codes);
                          },
                          registerFunction: () {
                            matchBoardProvider.registerInterestKeywordList();
                            commonBoardProvider.updateInitState(false);
                            getList(commonProvider, boardViewModel,
                                matchBoardProvider);
                          },
                          resetFunction: () =>
                              matchBoardProvider.resetInterestKeywordList(),
                        );
                      },
                    );
                  },
                );
              },
            ),
            BoardFilterChip(
              content:
                  '주고 싶은 재능 ${matchBoardProvider.selectedGiveTalentKeywordCodes.isEmpty ? '' : matchBoardProvider.selectedGiveTalentKeywordCodes.length}',
              selected:
                  matchBoardProvider.selectedGiveTalentKeywordCodes.isNotEmpty,
              function: () {
                matchBoardProvider.matchGiveKeywordList();
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  builder: (BuildContext context) {
                    return Consumer<MatchBoardProvider>(
                      builder: (context, matchBoardProvider, child) {
                        return KeywordFilterBottomSheet(
                          sheetTitle: '주고 싶은 재능',
                          keywordCodes:
                              matchBoardProvider.giveTalentKeywordCodes,
                          tabController:
                              matchBoardProvider.giveTalentTabController,
                          removeFunction: (code) {
                            matchBoardProvider.removeGiveKeywordList(code);
                          },
                          updateFunction: (codes) {
                            matchBoardProvider.updateGiveKeywordList(codes);
                          },
                          registerFunction: () {
                            matchBoardProvider.registerGiveKeywordList();
                            commonBoardProvider.updateInitState(false);
                            getList(commonProvider, boardViewModel,
                                matchBoardProvider);
                          },
                          resetFunction: () =>
                              matchBoardProvider.resetGiveKeywordList(),
                        );
                      },
                    );
                  },
                );
              },
            ),
            //진행방식
            BoardFilterChip(
              content: matchBoardProvider.selectedOperationType == ''
                  ? '방식'
                  : GlobalValueConstants.operationTypes.firstWhere(
                      (option) =>
                          option['code'] ==
                          matchBoardProvider.selectedOperationType,
                    )['value']!,
              selected: matchBoardProvider.selectedOperationType != '',
              function: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  builder: (BuildContext context) {
                    return RadioBottomSheet(
                      sheetTitle: "진행 방식",
                      bottomSheetContent: GlobalValueConstants.operationTypes,
                      selectedCode: matchBoardProvider.selectedOperationType,
                      changedFunction: (code) {
                        matchBoardProvider.updateOperationType(code);
                        commonBoardProvider.updateInitState(false);
                        getList(
                            commonProvider, boardViewModel, matchBoardProvider);
                      },
                    );
                  },
                );
              },
            ),
            //진행기간
            BoardFilterChip(
              content: matchBoardProvider.selectedDurationType == ''
                  ? '기간'
                  : GlobalValueConstants.durationTypes.firstWhere(
                      (option) =>
                          option['code'] ==
                          matchBoardProvider.selectedDurationType,
                    )['value']!,
              selected: matchBoardProvider.selectedDurationType != '',
              function: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  builder: (BuildContext context) {
                    return RadioBottomSheet(
                      sheetTitle: "진행 기간",
                      bottomSheetContent: GlobalValueConstants.durationTypes,
                      selectedCode: matchBoardProvider.selectedDurationType,
                      changedFunction: (code) {
                        matchBoardProvider.updateDurationType(code);
                        commonBoardProvider.updateInitState(false);
                        getList(
                            commonProvider, boardViewModel, matchBoardProvider);
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 56;

  @override
  double get minExtent => 56;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

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
            null,
            null,
            null,
            null,
            null,
            "reset")
        .whenComplete(() => commonProvider.changeIsLoading(false));
  }
}
