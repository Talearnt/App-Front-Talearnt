import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/theme.dart';
import '../../../../constants/global_value_constants.dart';
import '../../../../provider/board/common_board_provider.dart';
import '../../../../provider/board/community_board_provider.dart';
import '../../widget/board_filter_chip.dart';
import '../../widget/radio_bottom_sheet.dart';

class CommunityBoardListTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final communityBoardProvider = Provider.of<CommunityBoardProvider>(context);
    // final boardViewModel = Provider.of<BoardViewModel>(context);
    // final commonProvider = Provider.of<CommonProvider>(context);
    final commonBoardProvider = Provider.of<CommonBoardProvider>(context);

    return Container(
        height: maxExtent,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              controller: communityBoardProvider.communityTabController,
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Palette.text01,
              indicatorWeight: 1.0,
              indicatorPadding: EdgeInsets.zero,
              dividerColor: Palette.bgUp02,
              dividerHeight: 2.0,
              labelColor: Palette.text01,
              labelStyle: TextTypes.bodyMedium03(color: Palette.text01),
              unselectedLabelStyle:
                  TextTypes.bodyMedium03(color: Palette.text02),
              padding: EdgeInsets.zero,
              tabs: [
                for (var tabText in GlobalValueConstants.keywordCategoris)
                  Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      child: Tab(
                        height: 32,
                        child: Text(
                          tabText.name,
                          style: TextTypes.bodyMedium03(color: Palette.text01),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //정렬방식
                    BoardFilterChip(
                      content: GlobalValueConstants.orderTypes.firstWhere(
                        (option) =>
                            option['code'] ==
                            communityBoardProvider.selectedOrderType,
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
                              bottomSheetContent:
                                  GlobalValueConstants.orderTypes,
                              selectedCode:
                                  communityBoardProvider.selectedOrderType,
                              changedFunction: (code) {
                                communityBoardProvider.updateOrderType(code);
                                commonBoardProvider.updateInitState(false);
                                // getList(commonProvider, boardViewModel,
                                //     communityBoardProvider);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  @override
  double get maxExtent => 89;

  @override
  double get minExtent => 89;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

// Future<void> getList(
//     CommonProvider commonProvider,
//     BoardViewModel boardViewModel,
//     MatchBoardProvider talentBoardProvider) async {
//   commonProvider.changeIsLoading(true);
//   await boardViewModel
//       .getTalentExchangePosts(
//           talentBoardProvider.selectedGiveTalentKeywordCodes
//               .map((e) => e.toString())
//               .toList(),
//           talentBoardProvider.selectedInterestTalentKeywordCodes
//               .map((e) => e.toString())
//               .toList(),
//           talentBoardProvider.selectedOrderType,
//           talentBoardProvider.selectedDurationType,
//           talentBoardProvider.selectedOperationType,
//           null,
//           null,
//           null,
//           null,
//           null)
//       .whenComplete(() => commonProvider.changeIsLoading(false));
// }
}
