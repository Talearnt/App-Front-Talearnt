import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class TimeSet extends StatelessWidget {
  final ValueNotifier<int>? timerSeconds;

  const TimeSet({Key? key, required this.timerSeconds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<CommonProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          timerProvider.getFormattedTime(timerSeconds),
          style: TextTypes.body02(color: Palette.primary01),
        ),
      ],
    );
  }
}
