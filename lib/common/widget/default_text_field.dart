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

  //helper text 예외 상황.. 이거 그냥 따로 빼는게 나으려나..
  final bool isInfo;
  final bool isInfoValid;
  final String infoMessage;
  final String infoValidMessage;
  final String infoType;
  final Function(String, String)? infoFunc;
  final Future<void> Function(String?)? onServerCheck;
  final bool isTextAvailableOnServer;

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
    this.isInfo = false,
    this.isInfoValid = false,
    this.infoMessage = '',
    this.infoValidMessage = '',
    this.infoType = '',
    this.infoFunc,
    this.onServerCheck,
    this.isTextAvailableOnServer = false,
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
      isInfo: isInfo,
      isInfoValid: isInfoValid,
      infoMessage: infoMessage,
      infoValidMessage: infoValidMessage,
      infoType: infoType,
      infoFunc: infoFunc,
      onServerCheck: onServerCheck,
    );
  }

  Widget? _getSuffixIcon() {
    final showDeleteIcon =
        textEditingController.text.isNotEmpty && focusNode!.hasFocus;
    final showTimeSet = type == "cert" && isSendAuth;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showDeleteIcon)
          GestureDetector(
            onTap: () {
              provider.clearText(textEditingController);
            },
            child: SvgPicture.asset("assets/icons/text_delete.svg"),
          ),
        if (showTimeSet)
          Row(
            children: [
              ValueListenableBuilder<int>(
                  valueListenable: timeSeconds!, // ValueNotifier를 감시
                  builder: (context, value, child) {
                    return TimeSet(timerSeconds: timeSeconds);
                  }),
              const SizedBox(width: 8)
            ],
          ),
      ],
    );
  }
}
