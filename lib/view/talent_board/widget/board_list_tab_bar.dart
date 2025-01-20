import 'package:app_front_talearnt/view/talent_board/widget/radio_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_value_constants.dart';
import '../../../provider/talent_board/talent_board_provider.dart';
import 'board_filter_chip.dart';
import 'keyword_bottom_sheet.dart';

class BoardListTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final TalentBoardProvider talentBoardProvider =
        context.watch<TalentBoardProvider>();
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
                    option['code'] == talentBoardProvider.selectedOrderType,
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
                      selectedCode: talentBoardProvider.selectedOrderType,
                      changedFunction: (code) {
                        talentBoardProvider.updateOrderType(code);
                      },
                    );
                  },
                );
              },
            ),
            BoardFilterChip(
              content:
                  '받고 싶은 재능 ${talentBoardProvider.interestTalentKeywordCodes.isEmpty ? '' : talentBoardProvider.interestTalentKeywordCodes.length}',
              selected:
                  talentBoardProvider.interestTalentKeywordCodes.isNotEmpty,
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
                    return KeywordBottomSheet(
                      sheetTitle: '받고 싶은 재능',
                      keywordCodes:
                          talentBoardProvider.interestTalentKeywordCodes,
                      tabController:
                          talentBoardProvider.interestTalentTabController,
                      removeFunction: (code) {
                        talentBoardProvider.removeInterestKeywordList(code);
                      },
                      updateFunction: (codes) {
                        talentBoardProvider.updateInterestKeywordList(codes);
                      },
                    );
                  },
                );
              },
            ),
            BoardFilterChip(
              content:
                  '주고 싶은 재능 ${talentBoardProvider.giveTalentKeywordCodes.isEmpty ? '' : talentBoardProvider.giveTalentKeywordCodes.length}',
              selected: talentBoardProvider.giveTalentKeywordCodes.isNotEmpty,
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
                    return KeywordBottomSheet(
                      sheetTitle: '주고 싶은 재능',
                      keywordCodes: talentBoardProvider.giveTalentKeywordCodes,
                      tabController:
                          talentBoardProvider.giveTalentTabController,
                      removeFunction: (code) {
                        talentBoardProvider.removeGiveKeywordList(code);
                      },
                      updateFunction: (codes) {
                        talentBoardProvider.updateGiveKeywordList(codes);
                      },
                    );
                  },
                );
              },
            ),
            //진행방식
            BoardFilterChip(
              content: talentBoardProvider.selectedOperationType == ''
                  ? '방식'
                  : GlobalValueConstants.operationTypes.firstWhere(
                      (option) =>
                          option['code'] ==
                          talentBoardProvider.selectedOperationType,
                    )['value']!,
              selected: talentBoardProvider.selectedOperationType != '',
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
                      selectedCode: talentBoardProvider.selectedOperationType,
                      changedFunction: (code) {
                        talentBoardProvider.updateOperationType(code);
                      },
                    );
                  },
                );
              },
            ),
            //진행기간
            BoardFilterChip(
              content: talentBoardProvider.selectedDurationType == ''
                  ? '기간'
                  : GlobalValueConstants.durationTypes.firstWhere(
                      (option) =>
                          option['code'] ==
                          talentBoardProvider.selectedDurationType,
                    )['value']!,
              selected: talentBoardProvider.selectedDurationType != '',
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
                      selectedCode: talentBoardProvider.selectedDurationType,
                      changedFunction: (code) {
                        talentBoardProvider.updateDurationType(code);
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
}
