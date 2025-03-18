import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/theme.dart';
import '../../../../constants/global_value_constants.dart';
import '../../../../provider/board/community_board_provider.dart';
import '../../../../view_model/board_view_model.dart';

class CommunityBoardListTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final communityBoardProvider = Provider.of<CommunityBoardProvider>(context);
    final boardViewModel = Provider.of<BoardViewModel>(context);
    final commonProvider = Provider.of<CommonProvider>(context);

    return Container(
        height: maxExtent,
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
              padding: const EdgeInsets.only(left: 16.0),
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
              onTap: (index) async {
                commonProvider.changeIsLoading(true);
                communityBoardProvider.updatePostType(GlobalValueConstants
                    .communityCategoryTypes[index]['code']!);
                await boardViewModel.getCommunityBoardList(
                  communityBoardProvider.selectedPostType,
                  communityBoardProvider.selectedOrderType,
                  null,
                  null,
                  null,
                  null,
                );
                commonProvider.changeIsLoading(false);
              },
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
}
