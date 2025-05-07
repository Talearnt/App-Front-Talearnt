import 'package:flutter/material.dart';

import '../clear_text.dart';

class LoginProvider extends ChangeNotifier with ClearText {
  bool _initLoggedIn = true;
  bool _autoLoggedIn = false;
  bool _isLoggedIn = false;
  String _loginRoot = 'login';
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  bool _emailValid = true;
  String _emailValidMessage = '';

  final TextEditingController _passwordController = TextEditingController();
  bool _passwordObscure = true;
  final FocusNode _passwordFocusNode = FocusNode();
  bool _passwordValid = true;
  String _passwordValidMessage = '';

  bool get initLoggedIn => _initLoggedIn;

  bool get autoLoggedIn => _autoLoggedIn;

  bool get isLoggedIn => _isLoggedIn;

  String get loginRoot => _loginRoot;

  TextEditingController get emailController => _emailController;

  FocusNode get emailFocusNode => _emailFocusNode;

  bool get emailValid => _emailValid;

  TextEditingController get passwordController => _passwordController;

  String get emailValidMessage => _emailValidMessage;

  FocusNode get passwordFocusNode => _passwordFocusNode;

  bool get passwordValid => _passwordValid;

  String get passwordValidMessage => _passwordValidMessage;

  bool get passwordObscure => _passwordObscure;

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

  void changePasswordObscure() {
    _passwordObscure = !_passwordObscure;
    notifyListeners();
  }

  updateLoginFormFail(String message) {
    _emailValid = false;
    _passwordValid = false;
    _passwordValidMessage = message;
    notifyListeners();
  }

  updateLoginFormSuccess() {
    _emailValid = true;
    _passwordValid = true;
    _passwordValidMessage = '';
    _isLoggedIn = true;
    notifyListeners();
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

  bool checkLoginValidity() {
    if (_emailController.text.isEmpty) {
      _emailValid = false;
      _emailValidMessage = '이메일을 입력해 주세요!';
      notifyListeners();
      return false;
    }
    if (_passwordController.text.isEmpty) {
      _passwordValid = false;
      _passwordValidMessage = '비밀번호를 입력해 주세요!';
      notifyListeners();
      return false;
    }
    return true;
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  void setAutoLogin() {
    _autoLoggedIn = !_autoLoggedIn;
    notifyListeners();
  }

  void updateInitLoggedIn(bool loggedIn) {
    _initLoggedIn = loggedIn;
    notifyListeners();
  }

  void testAutoLogin() {
    _emailController.text = "test@test.com";
    _passwordController.text = "!1q2w3e4r";
    notifyListeners();
  }

  Future<void> changeRoot(String newRoot) async {
    _loginRoot = newRoot;
    notifyListeners();
  }
}
