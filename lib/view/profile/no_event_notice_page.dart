import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/theme.dart';
import '../../common/widget/button.dart';

class NoEventNoticePage extends StatelessWidget {
  final String type; //event, notice

  const NoEventNoticePage({super.key, required this.type});

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
              Text(
                type == 'event' ? '등록된 이벤트가 없어요' : '등록된 공지사항이 없어요',
                style: TextTypes.heading2(color: Palette.text01),
              ),
              const SizedBox(height: 8),
              Text(
                type == 'event' ? '좋은 이벤트를 가져올게요' : '좋은 소식을 가져올게요',
                style: TextTypes.bodyMedium01(color: Palette.text02),
              ),
              Text(
                '조금만 기다려 주세요',
                style: TextTypes.bodyMedium01(color: Palette.text02),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: PrimaryM(
              content: '게시물 작성하기',
              onPressed: () {
                context.pop('/board-list');
              },
            ),
          ),
        ],
      ),
    );
  }
}
