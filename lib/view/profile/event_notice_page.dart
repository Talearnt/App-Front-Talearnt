import 'package:app_front_talearnt/common/theme.dart';
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
    final provider = context.watch<ProfileProvider>();

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
              controller: provider.eventNoticeTabController,
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
              controller: provider.eventNoticeTabController,
              children: [
                _buildEventTab(provider),
                const NoEventNoticePage(type: 'notice'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventTab(ProfileProvider provider) {
    // 1) 초기 로딩 상태 (아직 한 번도 데이터가 안 들어왔을 때)
    if (provider.eventList.isEmpty && provider.eventHasNext) {
      return const Center(child: CircularProgressIndicator());
    }
    // 2) 데이터가 없고 더 가져올 페이지도 없을 때
    if (provider.eventList.isEmpty && !provider.eventHasNext) {
      return const NoEventNoticePage(type: 'event');
    }
    // 3) 리스트 + 무한 스크롤
    return ListView.builder(
      controller: provider.scrollController,
      itemCount: provider.eventList.length + (provider.eventHasNext ? 1 : 0),
      itemBuilder: (context, index) {
        // 맨 끝 로딩 인디케이터
        if (index == provider.eventList.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final event = provider.eventList[index];
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
