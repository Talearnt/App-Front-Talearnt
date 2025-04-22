import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';

class InfoHelper extends StatelessWidget {
  final String type;
  final String content;

  const InfoHelper({Key? key, required this.type, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle;

    if (type == 'errorInfo') {
      textStyle = TextTypes.captionSemi02(color: Palette.error01);
    } else if (type == 'checkInfo') {
      textStyle = TextTypes.captionSemi02(color: Palette.primary01);
    } else {
      textStyle = TextTypes.captionSemi02(color: Palette.text03);
    }

    return Text(content, style: textStyle);
  }
}
