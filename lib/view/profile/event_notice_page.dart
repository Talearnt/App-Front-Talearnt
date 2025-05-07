import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/widget/top_app_bar.dart';
import '../../provider/profile/profile_provider.dart';
import 'no_event_notice_page.dart';

class EventNoticePage extends StatelessWidget {
  const EventNoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (!didPop) {
          if (context.mounted) {
            context.pop();
          }
        }
      },
      child: Scaffold(
        backgroundColor: Palette.bgBackGround,
        appBar: const TopAppBar(
          content: '이벤트/공지사항',
          leftIcon: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TabBar(
                controller: profileProvider.eventNoticeTabController,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 2.0,
                  ),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Palette.text01,
                indicatorWeight: 1.0,
                indicatorPadding: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                dividerColor: Colors.transparent,
                labelColor: Palette.text01,
                labelStyle: TextTypes.body02(color: Palette.text01),
                unselectedLabelStyle: TextTypes.body02(color: Palette.text03),
                tabs: const [
                  Tab(text: '이벤트'),
                  Tab(text: '공지사항'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: profileProvider.eventNoticeTabController,
                children: const [
                  NoEventNoticePage(
                    type: 'event',
                  ),
                  NoEventNoticePage(
                    type: 'notice',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
