import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import 'base_text_field.dart';

class ObscureTextField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final Function(String) textOnChanged;
  final bool isEnabled;
  final bool isObscured;
  final Function() changeObscured;

  final String validType;
  final FocusNode? focusNode;
  final Function(String)? validFunc;
  final String validMessage;
  final bool isValid;
  final bool isOtherValid; //비밀번호 넣을때 이메일에 대한 선행이 먼저 이뤄져야하는 경우 사용 고민 중..
  final Function()? checkOtherValidFun;

  const ObscureTextField({
    super.key,
    required this.hint,
    required this.textEditingController,
    required this.textOnChanged,
    this.isEnabled = true,
    required this.isObscured,
    this.validType = 'default',
    this.focusNode,
    this.validFunc,
    this.validMessage = '',
    this.isValid = true,
    required this.changeObscured,
    this.isOtherValid = false,
    this.checkOtherValidFun,
  });

  @override
  Widget build(BuildContext context) {
    return BaseTextField(
      obscureText: isObscured,
      hint: hint,
      textEditingController: textEditingController,
      onChanged: textOnChanged,
      isEnabled: isEnabled,
      validMessage: validMessage,
      isValid: isValid,
      validFunc: validFunc,
      validType: validType,
      focusNode: focusNode,
      isOtherValid: isOtherValid,
      checkOtherValidFun: checkOtherValidFun,
      suffixIcon: _getSuffixIcon(), // ObscureTextField에서 suffixIcon 처리
    );
  }

  Widget? _getSuffixIcon() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (textEditingController.text.isNotEmpty)
          GestureDetector(
            onTap: changeObscured,
            child: SvgPicture.asset(
              isObscured
                  ? 'assets/icons/eye_close.svg'
                  : 'assets/icons/eye_open.svg',
              width: 24,
              height: 24,
            ),
          ),
      ],
    );
  }
}
