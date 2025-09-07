import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationPermissionService {
  /// Android 13+ 에서 알림 권한을 보장
  static Future<bool> ensurePermission() async {
    if (!Platform.isAndroid) return true;

    final settings = await FirebaseMessaging.instance.getNotificationSettings();
    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      return true;
    }

    final result = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    return result.authorizationStatus == AuthorizationStatus.authorized ||
        result.authorizationStatus == AuthorizationStatus.provisional;
  }
}
