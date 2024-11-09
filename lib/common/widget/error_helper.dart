import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ErrorHelper extends StatelessWidget {
  final String type;
  final String content;

  const ErrorHelper({Key? key, required this.type, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle;
    String iconPath;

    if (type == 'error') {
      textStyle = TextTypes.caption02(color: Palette.error01);
      iconPath = 'assets/icons/fail_helper.svg';
    } else {
      textStyle = TextTypes.caption02(color: Palette.primary01);
      iconPath = 'assets/icons/success_helper.svg';
    }

    return Row(
      children: [
        SizedBox(
          width: 14,
          height: 14,
          child: SvgPicture.asset(
            iconPath,
            width: 12,
            height: 12,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(content, style: textStyle)
      ],
    );
  }
}
