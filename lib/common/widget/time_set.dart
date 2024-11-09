import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';

class TimeSet extends StatelessWidget {
  const TimeSet({Key? key}) : super(key: key);

  static const int _timerSeconds = 180;

  String _formatTimer() {
    int minutes = _timerSeconds ~/ 60;
    int seconds = _timerSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(_formatTimer(),
        style: TextTypes.bodyMedium02(color: Palette.primary01));
  }
}
