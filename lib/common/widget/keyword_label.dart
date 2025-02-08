import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';

class KeywordLabel extends StatelessWidget {
  final String content;

  const KeywordLabel({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Text(content, style: TextTypes.body02(color: Palette.text02));
  }
}
