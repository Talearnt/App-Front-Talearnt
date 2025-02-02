import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/theme.dart';

class BoardFilterChip extends StatelessWidget {
  final String content;
  final VoidCallback? function;
  final bool selected;

  const BoardFilterChip(
      {super.key, required this.content, this.function, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        onPressed: function ?? () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? Palette.icon01 : Palette.bgBackGround,
          foregroundColor: selected ? Palette.bgBackGround : Palette.text02,
          shadowColor: Colors.transparent,
          overlayColor: Colors.transparent,
          elevation: 0,
          padding: const EdgeInsets.fromLTRB(12, 7, 6, 7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: const BorderSide(color: Palette.icon04),
          ),
        ),
        child: Row(
          children: [
            Text(content),
            const SizedBox(width: 4),
            selected
                ? SvgPicture.asset(
                    'assets/icons/filter_chip_selected_arrow.svg')
                : SvgPicture.asset('assets/icons/filter_chip_arrow.svg'),
          ],
        ),
      ),
    );
  }
}
