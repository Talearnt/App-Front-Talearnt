import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String content;
  final bool leftIcon;
  final Widget? first;
  final Widget? second;

  const TopAppBar({
    super.key,
    this.content = "",
    this.leftIcon = true,
    this.first,
    this.second,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.bgBackGround,
      centerTitle: true,
      leading: leftIcon
          ? IconButton(
              icon: SvgPicture.asset(
                'assets/icons/back_arrow.svg', // SVG 파일 경로
              ),
              onPressed: () {
                Navigator.of(context).pop(); // 뒤로 가는 동작
              },
            )
          : Container(),
      title: Text(
        content,
        style: TextTypes.bodySemi01(),
      ),
      actions: [
        if (second != null)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: second!,
          ),
        if (first != null)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: first!,
          ),
      ],
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
