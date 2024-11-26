import 'package:app_front_talearnt/provider/clear_text.dart';
import 'package:flutter/material.dart';

class KakaoProvider extends ChangeNotifier with ClearText {
  int _gender = 0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();

  bool _allCheck = false;
  bool _requiredTermsOfUseCheck = false;
  bool _personalInfoCheck = false;
  bool _marketingCheck = false;
  bool _termsOfUseCheck = false;

  int get gender => _gender;

  TextEditingController get nameController => _nameController;

  TextEditingController get emailController => _emailController;

  TextEditingController get phoneNumController => _phoneNumController;

  bool get allCheck => _allCheck;

  bool get requiredTermsOfUseCheck => _requiredTermsOfUseCheck;

  bool get personalInfoCheck => _personalInfoCheck;

  bool get marketingCheck => _marketingCheck;

  bool get termsOfUseCheck => _termsOfUseCheck;

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

  void changeGender(int newGender) {
    _gender = newGender;
    notifyListeners();
  }

  void updateAllCheck(bool newCheck) {
    _allCheck = !_allCheck;
    if (newCheck) {
      _requiredTermsOfUseCheck = false;
      _personalInfoCheck = false;
      _marketingCheck = false;
      _termsOfUseCheck = false;
    } else {
      _requiredTermsOfUseCheck = true;
      _personalInfoCheck = true;
      _marketingCheck = true;
      _termsOfUseCheck = true;
    }
    notifyListeners();
  }

  void updateRequiredTermsOfUseCheck() {
    _requiredTermsOfUseCheck = !_requiredTermsOfUseCheck;
    isAllCheck();
    notifyListeners();
  }

  void updatePersonalInfoCheck() {
    _personalInfoCheck = !_personalInfoCheck;
    isAllCheck();
    notifyListeners();
  }

  void updateMarketingCheck() {
    _marketingCheck = !_marketingCheck;
    isAllCheck();
    notifyListeners();
  }

  void updateTermsOfUseCheck() {
    _termsOfUseCheck = !_termsOfUseCheck;
    isAllCheck();
    notifyListeners();
  }

  void isAllCheck() {
    if (_requiredTermsOfUseCheck &&
        _personalInfoCheck &&
        _marketingCheck &&
        _termsOfUseCheck) {
      _allCheck = true;
    } else if (!_requiredTermsOfUseCheck ||
        !_personalInfoCheck ||
        !_marketingCheck ||
        !_termsOfUseCheck) {
      _allCheck = false;
    }
  }
}
