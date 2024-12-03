import 'package:flutter/material.dart';

import '../clear_text.dart';

class SignUpProvider extends ChangeNotifier with ClearText {
  int _signUpPage = 0;
  final PageController _pageController = PageController();
  final ValueNotifier<int> _certTimerSeconds = ValueNotifier<int>(180);

  final TextEditingController _nickNameController = TextEditingController();
  final FocusNode _nickNameFocusNode = FocusNode();
  bool _nickNameValid = true;
  String _nickNameValidMessage = '';

  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  bool _nameValid = true;
  String _nameValidMessage = '';

  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  bool _emailValid = true;
  String _emailValidMessage = '';

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

  final TextEditingController _phoneNumController = TextEditingController();
  final FocusNode _phoneNumFocusNode = FocusNode();
  bool _phoneNumValid = true;
  String _phoneNumValidMessage = '';
  final TextEditingController _certNumController = TextEditingController();
  final FocusNode _certNumFocusNode = FocusNode();

  int _gender = 0;
  bool _allCheck = false;
  bool _requiredTermsOfUseCheck = false;
  bool _personalInfoCheck = false;
  bool _marketingCheck = false;
  bool _termsOfUseCheck = false;

  bool _isSignUpSub2ButtonEnabled = false;
  bool _isSignUpSub2NextButtonEnabled = false;

  bool _sendCertNum = false;

  int get signUpPage => _signUpPage;

  ValueNotifier<int> get certTimerSeconds => _certTimerSeconds;

  PageController get pageController => _pageController;

  bool get isSignUpSub1ButtonEnabled =>
      _requiredTermsOfUseCheck && _personalInfoCheck;

  bool get isSignUpSub3ButtonEnabled =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _passwordCheckController.text.isNotEmpty &&
      _emailValid &&
      _passwordValid &&
      _passwordCheckValid &&
      _addListenerPasswordCheck;

  bool get isSignUpSub2ButtonEnabled => _isSignUpSub2ButtonEnabled;

  bool get isSignUpSub2NextButtonEnabled => _isSignUpSub2NextButtonEnabled;

  bool get sendCertNum => _sendCertNum;

  TextEditingController get nameController => _nameController;

  FocusNode get nameFocusNode => _nameFocusNode;

  bool get nameValid => _nameValid;

  String get nameValidMessage => _nameValidMessage;

  TextEditingController get nickNameController => _nickNameController;

  FocusNode get nickNameFocusNode => _nickNameFocusNode;

  bool get nickNameValid => _nickNameValid;

  String get nickNameValidMessage => _nickNameValidMessage;

  TextEditingController get emailController => _emailController;

  FocusNode get emailFocusNode => _emailFocusNode;

  bool get emailValid => _emailValid;

  String get emailValidMessage => _emailValidMessage;

  TextEditingController get passwordController => _passwordController;

  bool get passwordObscure => _passwordObscure;

  FocusNode get passwordFocusNode => _passwordFocusNode;

  bool get passwordValid => _passwordValid;

  String get passwordValidMessage => _passwordValidMessage;

  TextEditingController get passwordCheckController => _passwordCheckController;

  bool get passwordCheckObscure => _passwordCheckObscure;

  FocusNode get passwordCheckFocusNode => _passwordCheckFocusNode;

  bool get passwordCheckValid => _passwordCheckValid;

  String get passwordCheckValidMessage => _passwordCheckValidMessage;

  TextEditingController get phoneNumController => _phoneNumController;

  FocusNode get phoneNumFocusNode => _phoneNumFocusNode;

  bool get phoneNumValid => _phoneNumValid;

  String get phoneNumValidMessage => _phoneNumValidMessage;

  TextEditingController get certNumController => _certNumController;

  FocusNode get certNumFocusNode => _certNumFocusNode;

  int get gender => _gender;

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

  void updateSignUp(int pageNum) {
    _signUpPage = pageNum;
    notifyListeners(); // 상태 변경 통지
  }

  double getSignUpProgress() {
    return (_signUpPage + 1) / 3;
  }

  //포커스 아웃시에 처리되는 애들은 여기로 넣고 아닌 애들은 따로 만든다.
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

  void checkBeforeEmailValid() {
    if (_nameController.text.isEmpty) {
      _nameValid = false;
      _nameValidMessage = '이름 입력은 필수입니다.';
    }
    notifyListeners();
  }

  void checkBeforePasswordValid() {
    if (_emailController.text.isEmpty) {
      _emailValid = false;
      _emailValidMessage = '이메일 입력은 필수입니다.';
    }
    if (_nameController.text.isEmpty) {
      _nameValid = false;
      _nameValidMessage = '이름 입력은 필수입니다.';
    }
    notifyListeners();
  }

  void updatePasswordValid(String message) {
    if (_passwordCheckController.text.isNotEmpty) {
      updatePasswordCheckValid('');
    }
    if (message == '') {
      _passwordValid = true;
      _passwordValidMessage = '';
    } else {
      _passwordValid = false;
      _passwordValidMessage = message;
    }
    notifyListeners();
  }

  void updateNickNameValid(String message) {
    if (message == '') {
      _nickNameValid = true;
      _nickNameValidMessage = '';
    } else {
      _nickNameValid = false;
      _nickNameValidMessage = message;
    }
    notifyListeners();
  }

  void updateNameValid(String message) {
    if (message == '') {
      _nameValid = true;
      _nameValidMessage = '';
    } else {
      _nameValid = false;
      _nameValidMessage = message;
    }
    notifyListeners();
  }

  void updatePasswordCheckValid(String value) {
    if (_passwordCheckController.text == _passwordController.text) {
      _passwordCheckValid = true;
      _passwordCheckValidMessage = '';
    } else {
      _passwordCheckValid = false;
      _passwordCheckValidMessage = '비밀번호가 일치하지 않습니다.';
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

  void updatePhoneNumValid(String message) {
    if (message == '') {
      _phoneNumValid = true;
      _phoneNumValidMessage = '';
    } else {
      _phoneNumValid = false;
      _phoneNumValidMessage = message;
    }
    notifyListeners();
  }

  void updatePhoneNumController() {
    if (_phoneNumController.text.isNotEmpty &&
        _phoneNumController.text.length == 11) {
      _isSignUpSub2ButtonEnabled = true;
    } else {
      _isSignUpSub2ButtonEnabled = false;
    }
    notifyListeners();
  }

  void updateSendCertNum() {
    _sendCertNum = true;
    notifyListeners();
  }

  void updateCerNumController(TextEditingController textEditingController) {
    textEditingController.addListener(() {
      textEditingController.text.length == 4
          ? _isSignUpSub2NextButtonEnabled = true
          : _isSignUpSub2NextButtonEnabled = false;
      notifyListeners();
    });
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

  void resetSignUp() {
    _signUpPage = 0;
    _pageController.initialPage;
    _certTimerSeconds.value = 180;
    _nickNameController.clear();
    _nickNameValid = true;
    _nickNameValidMessage = '';
    _nameController.clear();
    _nameValid = true;
    _nameValidMessage = '';
    _emailController.clear();
    _emailValid = true;
    _emailValidMessage = '';
    _passwordController.clear();
    _passwordObscure = true;
    _passwordValid = true;
    _passwordValidMessage = '';
    _passwordCheckController.clear();
    _passwordCheckObscure = false;
    _phoneNumController.clear();
    _sendCertNum = false;
    _certNumController.clear();
    _gender = 0;
    _allCheck = false;
    _requiredTermsOfUseCheck = false;
    _personalInfoCheck = false;
    _marketingCheck = false;
    _termsOfUseCheck = false;
    _nameFocusNode.unfocus();
    _nickNameFocusNode.unfocus();
    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();
    _phoneNumFocusNode.unfocus();
    _certNumFocusNode.unfocus();
    notifyListeners();
  }
}
