import 'package:flutter/material.dart';

class SimpleLoginForm extends StatelessWidget {
  const SimpleLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(child: Divider()),
          SizedBox(width: 16),
          Text(
            '간편로그인',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(width: 16),
          Expanded(child: Divider()),
        ]),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24.0,
              backgroundColor: Colors.green, // 첫 번째 아이콘 색상
              child: Image.asset('assets/img/login_naver.png'),
            ),
            const SizedBox(width: 16.0),
            CircleAvatar(
              radius: 24.0,
              backgroundColor: Colors.yellow, // 두 번째 아이콘 색상
              child: Image.asset('assets/img/login_kakao.png'),
            ),
          ],
        ),
      ],
    );
  }
}
