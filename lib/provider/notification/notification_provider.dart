import 'dart:async';
import 'package:app_front_talearnt/view_model/notification_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:app_front_talearnt/data/model/respone/notification.dart';
import 'package:app_front_talearnt/provider/common/custom_ticker_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import '../../firebase_options.dart';

import 'package:provider/provider.dart';
import 'package:app_front_talearnt/main.dart'; // navigatorKey
import 'package:app_front_talearnt/view_model/board_view_model.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
}

class NotificationProvider extends ChangeNotifier {
  NotificationProvider() : _tickerProvider = CustomTickerProvider() {
    _notificationTabController =
        TabController(length: 3, vsync: _tickerProvider);
  }

  final CustomTickerProvider _tickerProvider;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  List<NotificationData> _notifications = [];
  bool _allNotification = true;
  bool _commentNotification = true;
  bool _keywordNotification = true;
  late TabController _notificationTabController;

  String? _fcmToken;
  StreamSubscription<RemoteMessage>? _onMessageSub;
  StreamSubscription<RemoteMessage>? _onOpenedSub;
  bool _initialized = false;

  final _fln = FlutterLocalNotificationsPlugin();

  List<NotificationData> get notifications => _notifications;
  bool get allNotification => _allNotification;
  bool get commentNotification => _commentNotification;
  bool get keywordNotification => _keywordNotification;
  TabController get notificationTabController => _notificationTabController;
  String? get fcmToken => _fcmToken;
  bool get isFcmInitialized => _initialized;

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
    _allNotification = _commentNotification && _keywordNotification;
    notifyListeners();
  }

  void changeKeywordNotification(bool notification) {
    _keywordNotification = notification;
    _allNotification = _commentNotification && _keywordNotification;
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
          isRead: true,
          unreadCount: _notifications[i].unreadCount,
          createdAt: _notifications[i].createdAt,
        );
      }
    }
    notifyListeners();
  }

  void myCustomMethod(dynamic data) async {
    final String? targetNoStr =
        (data['targetNo'] ?? data['postNo'] ?? data['communityPostNo'])
            ?.toString();
    final int? targetNo =
        targetNoStr == null ? null : int.tryParse(targetNoStr);

    final String? notificationType =
        (data['notificationType'] ?? data['type'] ?? data['notification_type'])
            ?.toString();

    final String? notificationNoStr = data['notificationNo']?.toString();
    final int? notificationNo =
        notificationNoStr == null ? null : int.tryParse(notificationNoStr);

    final context = navigatorKey.currentContext;
    if (context == null) {
      debugPrint('myCustomMethod: context 미준비로 스킵');
      return;
    }

    final boardViewModel = Provider.of<BoardViewModel>(context, listen: false);
    final notificationViewModel =
        Provider.of<NotificationViewModel>(context, listen: false);
    if (notificationType == '댓글' || notificationType == '답글') {
      await notificationViewModel.readNotification([notificationNo!]);

      await boardViewModel.getCommunityDetailBoard(targetNo!);
      await boardViewModel.getComments(targetNo!, 0);
    } else if (notificationType == '관심 키워드') {
      await notificationViewModel.readNotification([notificationNo!]);

      await boardViewModel.getMatchDetailBoard(targetNo!);
    }
  }

  Future<void> startFCM() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
    }
    if (_initialized) return;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    _fcmToken = await _messaging.getToken();

    _onMessageSub = FirebaseMessaging.onMessage.listen((m) {
      notifyListeners();
    });

    _onOpenedSub = FirebaseMessaging.onMessageOpenedApp.listen((m) {
      myCustomMethod(m.data);
      notifyListeners();
    });

    final initial = await _messaging.getInitialMessage();
    if (initial != null) {
      myCustomMethod(initial.data);
    }

    _initialized = true;
    notifyListeners();
  }

  Future<void> stopFCM() async {
    await _onMessageSub?.cancel();
    await _onOpenedSub?.cancel();
    _onMessageSub = null;
    _onOpenedSub = null;
    _fcmToken = null;
    _initialized = false;
    notifyListeners();
  }

  Future<void> _initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const init = InitializationSettings(android: android);
    await _fln.initialize(init);
    const channel = AndroidNotificationChannel(
      'default_channel',
      'General',
      description: 'Default notifications',
      importance: Importance.high,
    );
    await _fln
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  @override
  void dispose() {
    _onMessageSub?.cancel();
    _onOpenedSub?.cancel();
    _notificationTabController.dispose();
    _tickerProvider.dispose();
    super.dispose();
  }
}
