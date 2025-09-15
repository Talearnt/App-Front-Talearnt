import 'dart:async';
import 'dart:convert';
import 'package:app_front_talearnt/data/services/local_notification_service.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

StompClient? stompClient;
StompUnsubscribe? _notificationSub;

StompClient createStompClient({
  required String token,
  String url = 'https://api.talearnt.net/ws',
}) {
  late final StompClient client;

  client = StompClient(
    config: StompConfig.sockJS(
      url: url,
      beforeConnect: () async {
        await Future.delayed(const Duration(milliseconds: 200));
      },
      onConnect: (frame) {
        print('✅ STOMP 연결 성공! frame.headers: ${frame.headers}');
        _notificationSub = client.subscribe(
          destination: '/user/queue/notifications',
          callback: (frame) async {
            final result = json.decode(frame.body!);
            final type = result['notificationType']?.toString();
            final sender = result['senderNickname']?.toString() ?? '';
            String title;
            switch (type) {
              case '관심 키워드':
                title = '회원님이 원하는 매칭 게시글이 나타났어요!';
                break;
              case '댓글':
                title = '$sender님이 내 게시물에 댓글을 달았어요!';
                break;
              case '답글':
                title = '$sender님이 내 댓글에 답글을 달았어요!';
                break;
              default:
                title = type ?? '알림';
            }
            final body = (result['content'] ?? '').toString();
            await LocalNotificationService.I.show(
              title: title,
              body: body,
              payload: json.encode({
                'targetNo': result['targetNo'],
                'notificationType': result['notificationType'],
                'notificationNo': result['notificationNo'],
              }),
            );
          },
        );
      },
      onWebSocketError: (dynamic error) => print(error.toString()),
      stompConnectHeaders: {
        'Authorization': 'Bearer $token',
      },
    ),
  );

  stompClient = client;
  return client;
}

Future<void> unsubscribeNotification() async {
  if (_notificationSub != null) {
    _notificationSub!(); // 함수 호출 = 구독 해지
    _notificationSub = null;
  }
}

Future<void> disconnectStomp() async {
  stompClient?.deactivate(); // deactivate()는 void 반환
  stompClient = null;
}
