import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/provider/notification/notification_provider.dart';
import 'package:app_front_talearnt/view/alarm/widget/alarm_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/widget/button.dart';
import '../../common/widget/top_app_bar.dart';

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);

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
        appBar: TopAppBar(
          content: '알림',
          leftIcon: true,
          first: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/setting_black.svg',
            ),
            onPressed: () {
              //세팅 관련 함수 아직 나온거 없음
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TabBar(
                controller: notificationProvider.notificationTabController,
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
                labelPadding: EdgeInsets.zero,
                unselectedLabelStyle: TextTypes.body02(color: Palette.text03),
                tabs: const [
                  Tab(text: '전체'),
                  Tab(text: '댓글'),
                  Tab(text: '관심 키워드'),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 11),
                  child: TextBtnS(
                    content:
                        '모두읽기 ${notificationProvider.notifications.where((notification) => !notification.isRead).length}',
                    onPressed: () {},
                    btnStyle: TextTypes.caption01(color: Palette.primary01),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: notificationProvider.notificationTabController,
                children: [
                  // 전체
                  ListView.builder(
                    itemCount: notificationProvider.notifications.length,
                    itemBuilder: (context, index) {
                      return AlarmTile(
                          alarm: notificationProvider.notifications[index]);
                    },
                  ),
                  // 댓글
                  ListView.builder(
                    itemCount: notificationProvider.notifications
                        .where((notification) =>
                            notification.notificationType == '댓글' ||
                            notification.notificationType == '답글')
                        .length,
                    itemBuilder: (context, index) {
                      final commentNotifications = notificationProvider
                          .notifications
                          .where((notification) =>
                              notification.notificationType == '댓글' ||
                              notification.notificationType == '답글')
                          .toList();
                      return AlarmTile(alarm: commentNotifications[index]);
                    },
                  ),
                  // 관심 키워드
                  ListView.builder(
                    itemCount: notificationProvider.notifications
                        .where((notification) =>
                            notification.notificationType == '관심 키워드')
                        .length,
                    itemBuilder: (context, index) {
                      final keywordNotifications = notificationProvider
                          .notifications
                          .where((notification) =>
                              notification.notificationType == '관심 키워드')
                          .toList();
                      return AlarmTile(alarm: keywordNotifications[index]);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
