import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../common/widget/top_app_bar.dart';
import '../../provider/profile/profile_provider.dart';
import 'no_event_notice_page.dart';

class EventNoticePage extends StatelessWidget {
  const EventNoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    final commonProvider = context.read<CommonProvider>();
    final profileProvider = context.watch<ProfileProvider>();

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
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                _buildEventTab(profileProvider),
                const NoEventNoticePage(type: 'notice'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventTab(ProfileProvider profileProvider) {
    // if (profileProvider.eventList.isEmpty && profileProvider.eventHasNext) {
    //   return const Center(child: CircularProgressIndicator());
    // }
    if (profileProvider.eventList.isEmpty && !profileProvider.eventHasNext) {
      return const NoEventNoticePage(type: 'event');
    }

    return ListView.builder(
      controller: profileProvider.eventScrollController,
      itemCount: profileProvider.eventList.length +
          (profileProvider.eventHasNext ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == profileProvider.eventList.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final event = profileProvider.eventList[index];
        return Column(
          children: [
            Image.network(
              event.bannerUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (_, __, ___) => const SizedBox(
                height: 200,
                child: Center(child: Icon(Icons.broken_image)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    event.isActive ? "진행 중" : "종료",
                    style: TextTypes.caption01(
                      color:
                          event.isActive ? Palette.primary01 : Palette.text03,
                    ),
                  ),
                  Text(
                    "${DateFormat('yy.MM.dd').format(event.startDate)}"
                    "-${DateFormat('yy.MM.dd').format(event.endDate)}",
                    style: TextTypes.caption01(color: Palette.text03),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
