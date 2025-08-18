import 'package:app_front_talearnt/data/model/respone/notification.dart';
import 'package:app_front_talearnt/provider/common/custom_ticker_provider.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationProvider() : _tickerProvider = CustomTickerProvider() {
    _notificationTabController =
        TabController(length: 3, vsync: _tickerProvider);
  }

  final CustomTickerProvider _tickerProvider;

  List<NotificationData> _notifications = [];

  bool _allNotification = false;
  bool _commentNotification = false;
  bool _keywordNotification = false;
  late TabController _notificationTabController;

  List<NotificationData> get notifications => _notifications;
  bool get allNotification => _allNotification;
  bool get commentNotification => _commentNotification;
  bool get keywordNotification => _keywordNotification;
  TabController get notificationTabController => _notificationTabController;

  void clearProvider() {
    _allNotification = false;
    _commentNotification = false;
    _keywordNotification = false;
  }

  void changeAllNotification(bool notification) {
    _allNotification = notification;
    _commentNotification = notification;
    _keywordNotification = notification;
    notifyListeners();
  }

  void changeCommentNotification(bool notification) {
    _commentNotification = notification;
    if (_commentNotification && _keywordNotification) {
      _allNotification = true;
    } else {
      _allNotification = false;
    }
    notifyListeners();
  }

  void changeKeywordNotification(bool notification) {
    _keywordNotification = notification;
    if (_commentNotification && _keywordNotification) {
      _allNotification = true;
    } else {
      _allNotification = false;
    }
    notifyListeners();
  }

  void setNotifications(List<NotificationData> notifications) {
    _notifications = notifications;
    notifyListeners();
  }

  void markAsRead(List<int> notificationNos) {
    for (int i = 0; i < _notifications.length; i++) {
      if (notificationNos.contains(_notifications[i].notificationNo)) {
        _notifications[i] = NotificationData(
          notificationNo: _notifications[i].notificationNo,
          senderNickname: _notifications[i].senderNickname,
          targetNo: _notifications[i].targetNo,
          content: _notifications[i].content,
          notificationType: _notifications[i].notificationType,
          talentCodes: _notifications[i].talentCodes,
          isRead: true, // 읽음 처리
          unreadCount: _notifications[i].unreadCount,
          createdAt: _notifications[i].createdAt,
        );
      }
    }
    notifyListeners();
  }
}
