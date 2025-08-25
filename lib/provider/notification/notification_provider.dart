import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:app_front_talearnt/data/model/respone/notification.dart';
import 'package:app_front_talearnt/provider/common/custom_ticker_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import '../../firebase_options.dart';

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
  bool _allNotification = false;
  bool _commentNotification = false;
  bool _keywordNotification = false;
  late TabController _notificationTabController;

  String? _fcmToken;
  StreamSubscription<RemoteMessage>? _onMessageSub;
  StreamSubscription<RemoteMessage>? _onOpenedSub;
  bool _initialized = false;

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

  Future<void> startFCM() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
    if (_initialized) return;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    _fcmToken = await _messaging.getToken();
    debugPrint("FCM Token: $_fcmToken"); // 👉 콘솔에서 토큰 확인

    _onMessageSub = FirebaseMessaging.onMessage.listen((m) {
      notifyListeners();
    });

    _onOpenedSub = FirebaseMessaging.onMessageOpenedApp.listen((m) {
      debugPrint("알림 클릭: ${m.data}");
      notifyListeners();
    });

    final initial = await _messaging.getInitialMessage();
    if (initial != null) {
      debugPrint("종료상태 알림 데이터: ${initial.data}");
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

  // 필드
  final _fln = FlutterLocalNotificationsPlugin();

// 메서드
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
