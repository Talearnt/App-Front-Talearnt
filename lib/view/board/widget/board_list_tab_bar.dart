
import 'package:app_front_talearnt/view/board/widget/radio_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_value_constants.dart';
import '../../../provider/board/match_board_provider.dart';
import '../../../provider/common/common_provider.dart';
import '../../../view_model/board_view_model.dart';
import 'board_filter_chip.dart';
import 'keyword_bottom_sheet.dart';

class BoardListTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final matchBoardProvider = Provider.of<MatchBoardProvider>(context);
    final boardViewModel = Provider.of<BoardViewModel>(context);
    final commonProvider = Provider.of<CommonProvider>(context);
    return Container(
      height: maxExtent,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 18),
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
                        return KeywordBottomSheet(
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
                        return KeywordBottomSheet(
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
      BoardViewModel talentBoardViewModel,
      MatchBoardProvider talentBoardProvider) async {
    commonProvider.changeIsLoading(true);
    await talentBoardViewModel
        .getTalentExchangePosts(
            talentBoardProvider.selectedGiveTalentKeywordCodes
                .map((e) => e.toString())
                .toList(),
            talentBoardProvider.selectedInterestTalentKeywordCodes
                .map((e) => e.toString())
                .toList(),
            talentBoardProvider.selectedOrderType,
            talentBoardProvider.selectedDurationType,
            talentBoardProvider.selectedOperationType,
            null,
            null,
            null,
            null,
            null)
        .whenComplete(() => commonProvider.changeIsLoading(false));
  }
}
