import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../provider/common/common_provider.dart';
import '../theme.dart';
import 'error_helper.dart';

class BaseTextField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final Function(String) onChanged;
  final bool isEnabled;
  final int? maxTextLength;
  final String keyboardType;
  final Widget? suffixIcon;

  //검증관련
  final String validType;
  final FocusNode? focusNode;
  final String validMessage;
  final bool isValid;
  final Function(String)? validFunc;

  const BaseTextField({
    super.key,
    required this.hint,
    required this.textEditingController,
    required this.onChanged,
    this.isEnabled = true,
    this.maxTextLength,
    this.keyboardType = 'default',
    this.suffixIcon,
    this.validType = 'default',
    this.focusNode,
    this.validMessage = '',
    this.isValid = true,
    this.validFunc,
  });

  @override
  Widget build(BuildContext context) {
    final CommonProvider commonProvider = Provider.of<CommonProvider>(context);

    if (focusNode != null) {
      focusNode?.addListener(() {
        if (!focusNode!.hasFocus) {
          switch (validType) {
            case 'email':
              commonProvider.validateEmailText(
                  textEditingController, focusNode!.hasFocus, validFunc!);
              break;
            case 'password':
              commonProvider.validatePasswordText(
                  textEditingController, focusNode!.hasFocus, validFunc!);
              break;
            case 'phone':
              commonProvider.validatePasswordText(
                  textEditingController, focusNode!.hasFocus, validFunc!);
              break;
            default:
              break;
          }
        }
      });
    }

    return Column(
      children: [
        TextField(
          focusNode: focusNode,
          controller: textEditingController,
          onChanged: onChanged,
          maxLength: maxTextLength,
          style: TextTypes.bodyMedium02(color: Palette.text02),
          enabled: isEnabled,
          keyboardType:
              keyboardType == 'num' ? TextInputType.number : TextInputType.text,
          inputFormatters: keyboardType == 'num'
              ? [FilteringTextInputFormatter.digitsOnly]
              : [],
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Palette.text04),
            border: _getBorder(),
            enabledBorder: _getBorder(),
            focusedBorder: _getFocusedBorder(),
            fillColor: isEnabled ? Colors.transparent : Palette.bgUp02,
            contentPadding: const EdgeInsets.fromLTRB(16, 13, 8, 13),
            suffixIcon: suffixIcon,
          ),
        ),
        Visibility(
          visible: !isValid,
          child: Column(
            children: [
              const SizedBox(height: 4),
              ErrorHelper(type: 'error', content: validMessage)
            ],
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _getBorder() {
    return !isValid
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Palette.error02))
        : OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Palette.line01),
          );
  }

  OutlineInputBorder _getFocusedBorder() {
    return !isValid
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Palette.error02))
        : OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Palette.primary01),
          );
  }
}
