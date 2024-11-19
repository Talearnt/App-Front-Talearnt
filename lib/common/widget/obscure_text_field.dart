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
