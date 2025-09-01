import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
    await _plugin.initialize(settings);
    _inited = true;
  }

  Future<void> show({required String title, required String body}) async {
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
    );
  }
}
