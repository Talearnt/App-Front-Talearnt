import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../provider/common/common_provider.dart';
import '../theme.dart';
import 'error_helper.dart';
import 'info_helper.dart';

class BaseTextField extends StatefulWidget {
  final String hint;
  final TextEditingController textEditingController;
  final Function(String) onChanged;
  final bool isEnabled;
  final int? maxTextLength;
  final String keyboardType;
  final Widget? suffixIcon;
  final bool? obscureText; // nullable로 변경
  final String helperType;

  //검증관련
  final String validType;
  final FocusNode? focusNode;
  final String validMessage;
  final bool isValid;
  final Function(String)? validFunc;

  //다른 검증이 하나 더 들어갈때
  final bool isOtherValid; //비밀번호 넣을때 이메일에 대한 선행이 먼저 이뤄져야하는 경우 사용 고민 중..
  final Function()? checkOtherValidFun;

  //helper text 예외 상황.. 이거 그냥 따로 빼는게 나으려나..
  final bool isInfo;
  final bool isInfoValid;
  final String infoMessage;
  final String infoValidMessage;
  final String infoType;
  final Function(String, String)? infoFunc;
  final Future<void> Function(String?)? onServerCheck;

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
    this.helperType = 'error',
    this.isOtherValid = false,
    this.checkOtherValidFun,
    this.isInfo = false,
    this.isInfoValid = false,
    this.infoMessage = '',
    this.infoValidMessage = '',
    this.infoType = '',
    this.infoFunc,
    this.onServerCheck,
  });

  @override
  BaseTextFieldState createState() => BaseTextFieldState();
}

class BaseTextFieldState extends State<BaseTextField> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
    focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    focusNode.removeListener(_handleFocusChange);
    super.dispose();
  }

  void _handleFocusChange() {
    final commonProvider = Provider.of<CommonProvider>(context, listen: false);

    if (widget.isOtherValid) {
      commonProvider.checkBeforeValid(widget.checkOtherValidFun!);
    }

    if (!focusNode.hasFocus) {
      if (widget.textEditingController.text.isNotEmpty ||
          widget.textEditingController.text != '') {
        switch (widget.validType) {
          case 'email':
            commonProvider.validateEmailText(widget.textEditingController,
                focusNode.hasFocus, widget.validFunc!);
            break;
          case 'signUpEmail':
            commonProvider.validateSignUpEmailText(widget.textEditingController,
                focusNode.hasFocus, widget.validFunc!, widget.onServerCheck!);
            break;
          case 'password':
            commonProvider.validatePasswordText(widget.textEditingController,
                focusNode.hasFocus, widget.validFunc!);
            break;
          case 'phone':
            commonProvider.validatePhoneNum(widget.textEditingController,
                focusNode.hasFocus, widget.validFunc!);
            break;
          case 'name':
            commonProvider.validateName(widget.textEditingController,
                focusNode.hasFocus, widget.validFunc!);
            break;
          case 'passwordCheck':
            commonProvider.validatePhoneCheckNum(widget.textEditingController,
                focusNode.hasFocus, widget.validFunc!);
            break;
          case 'nickName':
            commonProvider.validateInfoNickName(widget.textEditingController,
                focusNode.hasFocus, widget.validFunc!, widget.onServerCheck!);
            break;
          default:
            break;
        }
      }
    }

    if (focusNode.hasFocus) {
      switch (widget.validType) {
        case 'nickName':
          commonProvider.setInfoNickName(focusNode.hasFocus, widget.infoFunc!);
          break;
        default:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          obscureText: widget.obscureText ?? false,
          focusNode: focusNode,
          controller: widget.textEditingController,
          onChanged: widget.onChanged,
          maxLength: widget.maxTextLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          buildCounter: (context,
              {required int currentLength,
              required bool isFocused,
              required int? maxLength}) {
            return null;
          },
          style: widget.isEnabled
              ? TextTypes.body02(color: Palette.text02)
              : TextTypes.body02(color: Palette.text04),
          enabled: widget.isEnabled,
          keyboardType: widget.keyboardType == 'num'
              ? TextInputType.number
              : TextInputType.text,
          inputFormatters: widget.keyboardType == 'num'
              ? [FilteringTextInputFormatter.digitsOnly]
              : [],
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: const TextStyle(color: Palette.text04),
            border: _getBorder(),
            enabledBorder: _getBorder(),
            focusedBorder: _getFocusedBorder(),
            disabledBorder: _getDisabledBorder(),
            filled: true,
            fillColor: widget.isEnabled ? Colors.transparent : Palette.bgUp01,
            hoverColor: Colors.transparent,
            suffixIcon: widget.suffixIcon,
          ),
        ),
        const SizedBox(height: 4),
        Visibility(
          visible: widget.isInfo,
          child: InfoHelper(type: 'info', content: widget.infoMessage),
        ),
        Visibility(
          visible: widget.isInfo && widget.isInfoValid,
          child: InfoHelper(
              type: widget.infoType, content: widget.infoValidMessage),
        ),
        Visibility(
          visible: !widget.isValid && widget.validMessage.isNotEmpty,
          child: Column(
            children: [
              ErrorHelper(type: widget.helperType, content: widget.validMessage)
            ],
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _getBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: !widget.isValid
            ? (widget.helperType == 'error' ? Palette.error02 : Palette.line01)
            : Palette.line01,
      ),
    );
  }

  OutlineInputBorder _getFocusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: !widget.isValid
            ? (widget.helperType == 'error'
                ? Palette.error02
                : Palette.primary01)
            : Palette.primary01,
      ),
    );
  }

  OutlineInputBorder _getDisabledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Palette.line01),
    );
  }
}
