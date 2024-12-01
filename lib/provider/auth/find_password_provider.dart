import 'package:flutter/material.dart';

import '../clear_text.dart';

class FindPasswordProvider extends ChangeNotifier with ClearText {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  bool _emailValid = true;
  String _emailValidMessage = '';

  final TextEditingController _phoneNumberController = TextEditingController();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  bool _phoneNumberValid = true;
  String _phoneNumberValidMessage = '';

  final TextEditingController _passwordController = TextEditingController();
  bool _passwordObscure = true;
  final FocusNode _passwordFocusNode = FocusNode();
  bool _passwordValid = true;
  String _passwordValidMessage = '';

  final TextEditingController _passwordCheckController =
      TextEditingController();
  bool _passwordCheckObscure = true;
  final FocusNode _passwordCheckFocusNode = FocusNode();
  bool _passwordCheckValid = true;
  bool _addListenerPasswordCheck = false;
  String _passwordCheckValidMessage = '';

  final String _userId = '';
  final String _createdAt = '';

  TextEditingController get emailController => _emailController;
  TextEditingController get phoneNumberController => _phoneNumberController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get passwordCheckController => _passwordCheckController;

  FocusNode get emailFocusNode => _emailFocusNode;
  FocusNode get phoneNumberFocusNode => _phoneNumberFocusNode;
  FocusNode get passwordFocusNode => _passwordFocusNode;
  FocusNode get passwordCheckFocusNode => _passwordCheckFocusNode;

  bool get emailValid => _emailValid;
  bool get phoneNumberValid => _phoneNumberValid;
  bool get passwordValid => _passwordValid;
  bool get passwordCheckValid => _passwordCheckValid;

  String get emailValidMessage => _emailValidMessage;
  String get phoneNumberValidMessage => _phoneNumberValidMessage;
  String get passwordValidMessage => _passwordValidMessage;
  String get passwordCheckValidMessage => _passwordCheckValidMessage;

  bool get isValidEmailAndPhoneNumber =>
      _emailController.text.isNotEmpty &&
      _phoneNumberController.text.isNotEmpty &&
      _emailValid &&
      _phoneNumberValid;

  bool get isVaildNewPassword =>
      _passwordController.text.isNotEmpty &&
      _passwordCheckController.text.isNotEmpty &&
      _passwordValid &&
      _passwordCheckValid;

  String get userId => _userId;
  String get createdAt => _createdAt;

  bool get passwordObscure => _passwordObscure;
  bool get passwordCheckObscure => _passwordCheckObscure;

  @override
  void clearText(TextEditingController controller) {
    controller.clear();
    notifyListeners();
  }

  void updateController(TextEditingController textEditingController) {
    textEditingController.addListener(() {
      notifyListeners();
    });
  }

  void updateEmailValid(String message) {
    if (message == '') {
      _emailValid = true;
      _emailValidMessage = '';
    } else {
      _emailValid = false;
      _emailValidMessage = message;
    }
    notifyListeners();
  }

  void updatePhoneNumberValid(String message) {
    if (message == '') {
      _phoneNumberValid = true;
      _phoneNumberValidMessage = '';
    } else {
      _phoneNumberValid = false;
      _phoneNumberValidMessage = message;
    }
    notifyListeners();
  }

  void updatePasswordValid(String message) {
    if (message == '') {
      _passwordValid = true;
      _passwordValidMessage = '';
    } else {
      _passwordValid = false;
      _passwordValidMessage = message;
    }
    notifyListeners();
  }

  void updatePasswordChkValid(String message) {
    if (message == '') {
      _passwordCheckValid = true;
      _passwordCheckValidMessage = '';
    } else {
      _passwordCheckValid = false;
      _passwordCheckValidMessage = message;
    }
    notifyListeners();
  }

  void changePasswordObscure() {
    _passwordObscure = !_passwordObscure;
    notifyListeners();
  }

  void changePasswordCheckObscure() {
    _passwordCheckObscure = !_passwordCheckObscure;
    notifyListeners();
  }

  void checkBeforePasswordValid() {
    if (_passwordController.text.isEmpty) {
      _passwordCheckValid = false;
      _passwordCheckValidMessage = '이메일을 입력해주세요';
    }
    notifyListeners();
  }

  void updatePasswordCheckController(
      TextEditingController textEditingController) {
    textEditingController.addListener(() {
      _passwordCheckController.text == _passwordController.text
          ? _addListenerPasswordCheck = true
          : _addListenerPasswordCheck = false;
      notifyListeners();
    });
  }

  void updatePasswordCheckValid(String passwordCheckText) {
    if (passwordCheckText == _passwordController.text) {
      _passwordCheckValid = true;
      _passwordCheckValidMessage = '';
    } else {
      _passwordCheckValid = false;
      _passwordCheckValidMessage = '비밀번호가 일치하지 않습니다.';
    }
    notifyListeners();
  }

  void updatePhoneNumCheckController(
      TextEditingController textEditingController) {
    textEditingController.addListener(() {
      _passwordCheckController.text == _passwordController.text
          ? _addListenerPasswordCheck = true
          : _addListenerPasswordCheck = false;
      notifyListeners();
    });
  }
}
