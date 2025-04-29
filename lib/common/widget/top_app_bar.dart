import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String content;
  final bool leftIcon;
  final Widget? leftWidget;
  final Widget? first;
  final Widget? second;
  final VoidCallback? onPressed;
  final Color? bgColor;

  const TopAppBar({
    super.key,
    this.content = "",
    this.leftIcon = true,
    this.leftWidget,
    this.first,
    this.second,
    this.onPressed,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: bgColor ?? Palette.bgBackGround,
      centerTitle: true,
      leading: leftIcon
          ? leftWidget ??
              IconButton(
                hoverColor: Colors.transparent,
                icon: SvgPicture.asset(
                  'assets/icons/back_arrow.svg', // SVG 파일 경로
                ),
                onPressed: onPressed ??
                    () {
                      context.pop();
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
