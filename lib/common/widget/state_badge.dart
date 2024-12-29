import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';

class StateBadge extends StatelessWidget {
  final bool state;
  final String content;

  const StateBadge({
    super.key,
    this.state = false, // 기본값 설정
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return state
        ? Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 9.5,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                8,
              ),
              color: Palette.primaryBG01,
            ),
            child: Text(
              content,
              style: TextTypes.bodyLarge02(
                color: Palette.primary01,
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 9.5,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                8,
              ),
              color: Palette.bgUp02,
            ),
            child: Text(
              content,
              style: TextTypes.bodyLarge02(
                color: Palette.text04,
              ),
            ),
          );
  }
}
