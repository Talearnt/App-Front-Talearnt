import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/theme.dart';
import '../../../../constants/global_value_constants.dart';
import '../../../../provider/board/community_board_provider.dart';

class CommunityBoardListTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final communityBoardProvider = Provider.of<CommunityBoardProvider>(context);

    return Container(
        height: maxExtent,
        padding: const EdgeInsets.only(left: 16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              controller: communityBoardProvider.communityTabController,
              tabAlignment: TabAlignment.center,
              isScrollable: true,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 2.0, // 선 두께 조절
                ),
                insets: EdgeInsets.zero, // 기본 여백 제거
              ),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Palette.text01,
              indicatorWeight: 1.0,
              indicatorPadding: EdgeInsets.zero,
              dividerColor: Palette.bgUp02,
              dividerHeight: 1.0,
              labelColor: Palette.text01,
              labelStyle: TextTypes.bodyMedium03(color: Palette.text01),
              unselectedLabelStyle:
                  TextTypes.bodyMedium03(color: Palette.text03),
              padding: EdgeInsets.zero,
              tabs: GlobalValueConstants.communityCategoryTypes.map(
                (tabText) {
                  return Container(
                    alignment: Alignment.center,
                    child: Tab(
                      height: 30,
                      child: Text(
                        tabText['value']!,
                        style: TextTypes.bodyMedium03(color: Palette.text01),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ));
  }

  @override
  double get maxExtent => 43;

  @override
  double get minExtent => 43;

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
