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
  final bool? obscureText; // nullable로 변경

  //검증관련
  final String validType;
  final FocusNode? focusNode;
  final String validMessage;
  final bool isValid;
  final Function(String)? validFunc;

  //다른 검증이 하나 더 들어갈때
  final bool isOtherValid; //비밀번호 넣을때 이메일에 대한 선행이 먼저 이뤄져야하는 경우 사용 고민 중..
  final Function()? checkOtherValidFun;

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
    this.obscureText,
    this.isOtherValid = false,
    this.checkOtherValidFun,
  });

  @override
  Widget build(BuildContext context) {
    final CommonProvider commonProvider = Provider.of<CommonProvider>(context);

    if (focusNode != null) {
      focusNode?.addListener(() {
        if (isOtherValid) {
          commonProvider.checkBeforeValid(checkOtherValidFun!);
        }
        if (!focusNode!.hasFocus &&
            (textEditingController.text.isNotEmpty ||
                textEditingController.text != '')) {
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
              commonProvider.validatePhoneNum(
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
          obscureText: obscureText ?? false,
          focusNode: focusNode,
          controller: textEditingController,
          onChanged: onChanged,
          maxLength: maxTextLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          buildCounter: (context,
              {required int currentLength,
              required bool isFocused,
              required int? maxLength}) {
            return null;
          },//maxLength 설정시 하위에 생기는 숫자 제거
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
            suffixIcon: suffixIcon,
          ),
        ),
        Visibility(
          visible: !isValid && validMessage.isNotEmpty,
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
