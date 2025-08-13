import 'package:app_front_talearnt/data/model/respone/notification.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationData> _notifications = [];

  // Getters
  List<NotificationData> get notifications => _notifications;

  // 알림 목록 설정
  void setNotifications(List<NotificationData> notifications) {
    _notifications = notifications;
    notifyListeners();
  }
}
