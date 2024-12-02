import 'package:app_front_talearnt/common/widget/time_set.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../provider/clear_text.dart';
import 'base_text_field.dart';

class DefaultTextField extends StatelessWidget {
  final String type;
  final String keyboardType;
  final String hint;
  final TextEditingController textEditingController;
  final ClearText provider;
  final Function(String) onChanged;
  final bool isEnabled;
  final bool isSendAuth;
  final int? maxTextLength;

  //cert일 경우 시간에 대한 정의
  final ValueNotifier<int>? timeSeconds;

  //검증관련
  final String validType;
  final FocusNode? focusNode;
  final Function(String)? validFunc;
  final String validMessage;
  final bool isValid;

  final bool isOtherValid; //결국 여기도 사용하는군
  final Function()? checkOtherValidFun;

  const DefaultTextField({
    super.key,
    required this.type,
    this.keyboardType = 'default',
    required this.hint,
    required this.textEditingController,
    required this.provider,
    required this.onChanged,
    this.isEnabled = true,
    this.isSendAuth = false,
    this.maxTextLength,
    this.validType = 'default',
    this.focusNode,
    this.validFunc,
    this.validMessage = '',
    this.isValid = true,
    this.timeSeconds,
    this.isOtherValid = false,
    this.checkOtherValidFun,
  });

  @override
  Widget build(BuildContext context) {
    return BaseTextField(
      hint: hint,
      textEditingController: textEditingController,
      onChanged: onChanged,
      isEnabled: isEnabled,
      maxTextLength: maxTextLength,
      focusNode: focusNode,
      validMessage: validMessage,
      isValid: isValid,
      validFunc: validFunc,
      validType: validType,
      keyboardType: keyboardType,
      isOtherValid: isOtherValid,
      checkOtherValidFun: checkOtherValidFun,
      suffixIcon: _getSuffixIcon(),
    );
  }

  Widget? _getSuffixIcon() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (textEditingController.text.isNotEmpty && focusNode!.hasFocus)
          GestureDetector(
            onTap: () {
              provider.clearText(textEditingController);
            },
            child: SvgPicture.asset("assets/icons/text_delete.svg"),
          ),
        if (type == "cert" && isSendAuth)
          Row(
            children: [
              TimeSet(timerSeconds: timeSeconds),
              const SizedBox(width: 8)
            ],
          ),
      ],
    );
  }
}
