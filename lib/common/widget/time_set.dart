import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class TimeSet extends StatelessWidget {
  const TimeSet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<CommonProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          timerProvider.formattedTime,
          style: TextTypes.bodyMedium02(color: Palette.primary01),
        ),
      ],
    );
  }
}
