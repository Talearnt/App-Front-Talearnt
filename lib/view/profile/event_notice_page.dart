import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:app_front_talearnt/view/profile/widget/event_tab.dart';
import 'package:app_front_talearnt/view/profile/widget/notice_tab.dart';
import 'package:app_front_talearnt/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common/widget/top_app_bar.dart';
import '../../provider/profile/profile_provider.dart';
import 'no_event_notice_page.dart';

class EventNoticePage extends StatelessWidget {
  const EventNoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);
    final commonProvider = context.read<CommonProvider>();
    final profileProvider = context.watch<ProfileProvider>();

    profileProvider.setViewModel(viewModel);
    return Scaffold(
      backgroundColor: Palette.bgBackGround,
      appBar: const TopAppBar(
        content: '이벤트/공지사항',
        leftIcon: true,
      ),
      body: Column(
        children: [
          // TabBar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TabBar(
              controller: profileProvider.eventNoticeTabController,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(width: 2),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Palette.text01,
              labelColor: Palette.text01,
              labelStyle: TextTypes.body02(color: Palette.text01),
              unselectedLabelStyle: TextTypes.body02(color: Palette.text03),
              tabs: const [
                Tab(text: '이벤트'),
                Tab(text: '공지사항'),
              ],
            ),
          ),

          // TabBarView
          Expanded(
            child: TabBarView(
              controller: profileProvider.eventNoticeTabController,
              children: [
                EventTab(profileProvider),
                NoticeTab(profileProvider),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
