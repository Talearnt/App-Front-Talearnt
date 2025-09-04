import 'dart:convert';

import 'package:app_front_talearnt/main.dart';
import 'package:app_front_talearnt/view_model/board_view_model.dart';
import 'package:app_front_talearnt/view_model/notification_view_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

class LocalNotificationService {
  LocalNotificationService._();
  static final LocalNotificationService I = LocalNotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _inited = false;

  Future<void> init() async {
    if (_inited) return;

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        final context = navigatorKey.currentContext;
        if (context == null) return;

        final payload = response.payload;
        if (payload == null) return;

        Map<String, dynamic> payloadMap;
        try {
          payloadMap = json.decode(payload) as Map<String, dynamic>;
        } catch (_) {
          final legacyTargetNo = int.tryParse(payload);
          if (legacyTargetNo == null) return;
          payloadMap = {
            'targetNo': legacyTargetNo,
            'notificationType': null,
            'notificationNo': null,
          };
        }

        final int? targetNo = payloadMap['targetNo'] is int
            ? payloadMap['targetNo'] as int
            : int.tryParse('${payloadMap['targetNo']}');
        final String? notificationType =
            payloadMap['notificationType']?.toString();
        final int? notificationNo = payloadMap['notificationNo'] is int
            ? payloadMap['notificationNo'] as int
            : int.tryParse('${payloadMap['notificationNo']}');
        if (targetNo == null) return;

        final boardViewModel =
            Provider.of<BoardViewModel>(context, listen: false);
        final notificationViewModel =
            Provider.of<NotificationViewModel>(context, listen: false);

        if (notificationType == '댓글' || notificationType == '답글') {
          if (notificationNo != null) {
            await notificationViewModel.readNotification([notificationNo]);
          }
          await boardViewModel.getCommunityDetailBoard(targetNo);
          await boardViewModel.getComments(targetNo, 0);
        } else if (notificationType == '관심 키워드') {
          if (notificationNo != null) {
            await notificationViewModel.readNotification([notificationNo]);
          }
          await boardViewModel.getMatchDetailBoard(targetNo);
        }
      },
    );

    _inited = true;
  }

  Future<void> show(
      {required String title,
      required String body,
      required String payload}) async {
    const android = AndroidNotificationDetails(
      'default_channel',
      '일반 알림',
      channelDescription: '기본 알림 채널',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );
    const details = NotificationDetails(android: android);
    await _plugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
      payload: payload,
    );
  }
}
