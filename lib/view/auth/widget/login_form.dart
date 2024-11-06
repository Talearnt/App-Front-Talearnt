import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          '아이디(이메일)',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 4),
        TextField(
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: '메일을 입력해주세요',
              hintStyle: const TextStyle(color: Color(0xFF98A3A9)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            )),
        const SizedBox(height: 16.0),
        const Text(
          '비밀번호',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 4),
        TextField(
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: '비밀번호를 입력해주세요',
              hintStyle: const TextStyle(color: Color(0xFF98A3A9)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            )),
        const SizedBox(height: 24.0),
        ElevatedButton(
          onPressed: () {
            // 버튼 동작 없음
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1B76FF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(11.5),
            child: Text(
              '로그인',
              style:
                  TextStyle(fontSize: 18, color: Color(0xFFFFFFFF)),
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          height: 18,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      // 아이디 찾기 동작
                    },
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                    ),
                    child: const Text(
                      '아이디 찾기',
                      style: TextStyle(fontSize: 14, color: Color(0xFF98A3A9)),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                    child: VerticalDivider(width: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      // 비밀번호 찾기 동작
                    },
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                    ),
                    child: const Text(
                      '비밀번호 찾기',
                      style: TextStyle(fontSize: 14, color: Color(0xFF98A3A9)),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  // 회원가입 동작
                },
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                  textStyle: WidgetStateProperty.all(
                    const TextStyle(fontSize: 14),
                  ),
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                child: const Text(
                  '회원가입',
                  style: TextStyle(fontSize: 14, color: Color(0xFF414A4E)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
