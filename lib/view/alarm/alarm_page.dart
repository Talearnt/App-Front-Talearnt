import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:app_front_talearnt/provider/notification/notification_provider.dart';
import 'package:app_front_talearnt/view/alarm/widget/alarm_tile.dart';
import 'package:app_front_talearnt/view/alarm/widget/no_alarm_title.dart';
import 'package:app_front_talearnt/view_model/notification_view_model.dart';
import 'package:app_front_talearnt/data/model/respone/notification.dart';
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
    final notificationViewModel = Provider.of<NotificationViewModel>(context);
    final commonProvider = Provider.of<CommonProvider>(context);

    List<NotificationData> _getNotificationsForCurrentTab(
        NotificationProvider p) {
      final idx = p.notificationTabController.index;
      final all = p.notifications;
      if (idx == 1) {
        return all
            .where(
                (n) => n.notificationType == '댓글' || n.notificationType == '답글')
            .toList();
      } else if (idx == 2) {
        return all.where((n) => n.notificationType == '관심 키워드').toList();
      }
      return all;
    }

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
            icon: SvgPicture.asset('assets/icons/setting_black.svg'),
            onPressed: () {
              context.push('/alarm-setting');
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
                  borderSide: BorderSide(width: 2.0),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Palette.text01,
                indicatorWeight: 1.0,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 4),
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
            AnimatedBuilder(
              animation: notificationProvider.notificationTabController,
              builder: (context, _) {
                final currentList =
                    _getNotificationsForCurrentTab(notificationProvider);
                final unreadNos = currentList
                    .where((n) => !n.isRead)
                    .map((n) => n.notificationNo)
                    .toList();

                if (currentList.isEmpty) {
                  return const SizedBox.shrink();
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 11),
                      child: TextBtnS(
                        content: '모두읽기 ${unreadNos.length}',
                        onPressed: () async {
                          if (unreadNos.isNotEmpty) {
                            await notificationViewModel
                                .readNotification(unreadNos);
                          }
                        },
                        btnStyle: TextTypes.caption01(color: Palette.primary01),
                      ),
                    ),
                  ],
                );
              },
            ),
            Expanded(
              child: TabBarView(
                controller: notificationProvider.notificationTabController,
                children: [
                  Builder(builder: (context) {
                    final list = notificationProvider.notifications;
                    if (list.isEmpty) return const NoAlarmTitle();
                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) =>
                          AlarmTile(alarm: list[index]),
                    );
                  }),
                  Builder(builder: (context) {
                    final list = notificationProvider.notifications
                        .where((n) =>
                            n.notificationType == '댓글' ||
                            n.notificationType == '답글')
                        .toList();
                    if (list.isEmpty) return const NoAlarmTitle();
                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) =>
                          AlarmTile(alarm: list[index]),
                    );
                  }),
                  Builder(builder: (context) {
                    final list = notificationProvider.notifications
                        .where((n) => n.notificationType == '관심 키워드')
                        .toList();
                    if (list.isEmpty) return const NoAlarmTitle();
                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) =>
                          AlarmTile(alarm: list[index]),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
