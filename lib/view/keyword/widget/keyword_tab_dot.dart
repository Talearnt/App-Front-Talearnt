import 'package:flutter/material.dart';

import '../../../common/theme.dart';

class KeywordTabDot extends StatelessWidget {
  const KeywordTabDot({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 7,
      right: 12,
      child: Container(
        width: 6,
        height: 6,
        decoration: const BoxDecoration(
          color: Palette.primary01,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
