import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../common/theme.dart';
import '../../common/widget/button.dart';

class NoBoardListPage extends StatelessWidget {
  final String boardType;

  const NoBoardListPage({super.key, required this.boardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(
            height: 138,
          ),
          SvgPicture.asset('assets/icons/add_board_large_logo.svg'),
          const SizedBox(height: 28),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '첫 게시글을 작성해 보세요!',
                style: TextTypes.heading2(color: Palette.text01),
              ),
              const SizedBox(height: 8),
              Text(
                'talearnt가 여러분의 게시글을 기다리고 있어요',
                style: TextTypes.bodyMedium01(color: Palette.text02),
              ),
            ],
          ),
          const SizedBox(height: 56),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: PrimaryM(
              content: '게시물 작성하기',
              onPressed: () {
                boardType == 'match'
                    ? context.push('/match_write1')
                    : context.push('/match_write1');//이후에 커뮤니티 작성 으로 변경해야됨
              },
            ),
          ),
        ],
      ),
    );
  }
}
