import 'dart:async';
import 'dart:convert';

import 'package:app_front_talearnt/data/services/local_notification_service.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

/// SockJS 프로토콜로 연결하는 StompClient 팩토리 함수
StompClient createStompClient({
  required String token,
  String url = 'https://api.talearnt.net/ws', // HTTPS로 시작
}) {
  // ① 인스턴스를 담을 변수 선언
  late final StompClient client;

  client = StompClient(
    config: StompConfig.sockJS(
      url: url,
      beforeConnect: () async {
        print('waiting to connect...');
        await Future.delayed(const Duration(milliseconds: 200));
        print('connecting...');
      },
      onConnect: (StompFrame frame) {
        print('✅ STOMP 연결 성공! frame.headers: ${frame.headers}');
        client.subscribe(
          destination: '/user/queue/notifications',
          callback: (frame) async {
            final result = json.decode(frame.body!);
            print("result: $result");

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
              payload: result['targetNo']?.toString() ?? '',
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

  return client;
}
