import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../provider/board/common_board_provider.dart';

class BoardCustomAppBar extends StatelessWidget {
  final String type;

  const BoardCustomAppBar({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final CommonBoardProvider commonBoardProvider =
        Provider.of<CommonBoardProvider>(context);
    return Container(
      height: kToolbarHeight,
      decoration: const BoxDecoration(
        color: Palette.bgBackGround,
        border: Border(
          bottom: BorderSide(
            color: Palette.line02,
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 왼쪽 버튼 그룹
          Row(
            children: [
              TextButton(
                onPressed: () {
                  commonBoardProvider.setBoardType("match");
                },
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                child: Text('매칭',
                    style: TextTypes.bodySemi01(
                        color:
                            type == "match" ? Palette.text01 : Palette.text04)),
              ),
              const SizedBox(width: 20),
              TextButton(
                onPressed: () {
                  commonBoardProvider.setBoardType("community");
                },
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                child: Text('커뮤니티',
                    style: TextTypes.bodySemi01(
                        color: type == "community"
                            ? Palette.text01
                            : Palette.text04)),
              ),
            ],
          ),
          // 오른쪽 아이콘 버튼
          IconButton(
            hoverColor: Colors.transparent,
            icon: SvgPicture.asset(
              'assets/icons/bell_off.svg',
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
