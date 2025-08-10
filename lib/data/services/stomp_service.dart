import 'dart:async';
import 'dart:convert';

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
          callback: (frame) {
            final result = json.decode(frame.body!);
            print("result:  $result");
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
