import 'package:flutter/material.dart';

import '../clear_text.dart';

class AuthProvider extends ChangeNotifier with ClearText {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordObscure = true;

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

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

  void changePasswordObscure(bool newObscure) {
    _passwordObscure = newObscure;
    notifyListeners();
  }
}
