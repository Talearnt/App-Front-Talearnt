import 'package:app_front_talearnt/view/auth/kakao_sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/theme.dart';

class SimpleLoginForm extends StatelessWidget {
  const SimpleLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Expanded(child: Divider()),
          const SizedBox(width: 16),
          Text(
            '간편로그인',
            style: TextTypes.caption01(color: Palette.text03),
          ),
          const SizedBox(width: 16),
          const Expanded(child: Divider()),
        ]),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24.0,
              backgroundColor: Colors.green, // 첫 번째 아이콘 색상
              child: SvgPicture.asset('assets/icons/sns_naver.svg'),
            ),
            const SizedBox(width: 16.0),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KakaoSignUpPage(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(24.0),
              // 클릭 효과를 CircleAvatar와 일치시키기 위해
              child: CircleAvatar(
                radius: 24.0,
                backgroundColor: Colors.yellow,
                child: SvgPicture.asset('assets/icons/sns_kakao.svg'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
