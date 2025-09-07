import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class NoAlarmTitle extends StatelessWidget {
  const NoAlarmTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/img/mako_normal.svg',
                width: 140,
                height: 140,
              ),
              const SizedBox(height: 28),
              Text(
                '새로운 알림이 없어요',
                style: TextTypes.heading4(color: Palette.text01),
              ),
              const SizedBox(height: 8),
              Text(
                '탤런트의 댓글과 관심 키워드 알림을',
                style: TextTypes.body02(color: Palette.text03),
              ),
              Text(
                '이곳에서 모아볼 수 있어요',
                style: TextTypes.body02(color: Palette.text03),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
