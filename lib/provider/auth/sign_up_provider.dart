import 'dart:async';

import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../clear_text.dart';

class SignUpProvider extends ChangeNotifier with ClearText {
  int _signUpPage = 0;
  final PageController _pageController = PageController();
  final ValueNotifier<int> _certTimerSeconds = ValueNotifier<int>(180);
  Timer? _timer;
  bool _isFirstVisit = true;

  final TextEditingController _nickNameController = TextEditingController();
  final FocusNode _nickNameFocusNode = FocusNode();
  bool _checkNickNameDuplication = false; //중복체크 false - 중복아님
  bool _changeNickName = false; //닉네임 변경했는지
  bool _nickNameValid = true;
  String _nickNameValidMessage = '';
  bool _isNickNameInfoValid = false;
  String _nickNameInfoValidMessage = '';
  bool _isNickNameInfo = true;
  String _nickNameInfoMessage = '랜덤으로 지정된 닉네임입니다. 자유롭게 수정 가능해요';
  String _nickNameInfoType = 'checkInfo';
  String _nickNameHelperType = '';
  bool _nickNameHelper = false;

  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  bool _nameValid = true;
  String _nameValidMessage = '';

  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  bool _checkEmailDuplication = false; //중복체크 false - 중복아님
  bool _emailValid = true;
  String _emailValidMessage = '';
  String _emailHelperType = '';
  bool _emailHelper = false;

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
  bool _isPhoneNumEnabled = true;
  final TextEditingController _certNumController = TextEditingController();
  final FocusNode _certNumFocusNode = FocusNode();
  bool _isCertNumEnabled = true;
  int _certNumCount = 0;
  bool _cerNumValid = true;
  String _cerNumValidMessage = '';
  bool _checkSmsValidation = false;

  int _gender = 0;
  bool _allCheck = false;
  bool _requiredTermsOfUseCheck = false;
  bool _personalInfoCheck = false;
  bool _marketingCheck = false;
  bool _termsOfUseCheck = false;

  bool _isSignUpSub2NextButtonEnabled = false;

  bool _sendCertNum = false;

  int get signUpPage => _signUpPage;

  ValueNotifier<int> get certTimerSeconds => _certTimerSeconds;

  Timer? get timer => _timer;

  PageController get pageController => _pageController;

  bool get isFirstVisit => _isFirstVisit;

  bool get isSignUpSub1ButtonEnabled =>
      _requiredTermsOfUseCheck && _personalInfoCheck;

  bool get isSignUpSub3ButtonEnabled =>
      _nickNameController.text.isNotEmpty &&
      _nameController.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _passwordCheckController.text.isNotEmpty &&
      _nickNameValid &&
      _nameValid &&
      _emailValid &&
      _passwordValid &&
      _passwordCheckValid &&
      _addListenerPasswordCheck;

  bool get isSignUpSub2ButtonEnabled =>
      _phoneNumValid &&
      _phoneNumController.text.isNotEmpty &&
      _phoneNumController.text.length == 11;

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

  bool get isNickNameInfoValid => _isNickNameInfoValid;

  bool get changeNickName => _changeNickName;

  String get nickNameInfoValidMessage => _nickNameInfoValidMessage;

  bool get isNickNameInfo => _isNickNameInfo;

  String get nickNameInfoMessage => _nickNameInfoMessage;

  String get nickNameInfoType => _nickNameInfoType;

  String get nickNameHelperType => _nickNameHelperType;

  bool get nickNameHelper => _nickNameHelper;

  TextEditingController get emailController => _emailController;

  FocusNode get emailFocusNode => _emailFocusNode;

  bool get emailValid => _emailValid;

  String get emailValidMessage => _emailValidMessage;

  String get emailHelperType => _emailHelperType;

  bool get emailHelper => _emailHelper;

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

  bool get isPhoneNumEnabled => _isPhoneNumEnabled;

  TextEditingController get certNumController => _certNumController;

  FocusNode get certNumFocusNode => _certNumFocusNode;

  bool get isCertNumEnabled => _isCertNumEnabled;

  bool get cerNumValid => _cerNumValid;

  String get cerNumValidMessage => _cerNumValidMessage;

  int get certNumCount => _certNumCount;

  bool get checkSmsValidation => _checkSmsValidation;

  int get gender => _gender;

  bool get allCheck => _allCheck;

  bool get requiredTermsOfUseCheck => _requiredTermsOfUseCheck;

  bool get personalInfoCheck => _personalInfoCheck;

  bool get marketingCheck => _marketingCheck;

  bool get termsOfUseCheck => _termsOfUseCheck;

  void clearProvider() {
    _signUpPage = 0;
    _pageController.initialPage;
    _isFirstVisit = true;

    _nickNameController.clear();
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _passwordCheckController.clear();
    _phoneNumController.clear();
    _certNumController.clear();

    _nameFocusNode.unfocus();
    _nickNameFocusNode.unfocus();
    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();
    _phoneNumFocusNode.unfocus();
    _certNumFocusNode.unfocus();
    _passwordCheckFocusNode.unfocus();

    _nickNameValid = true;
    _nickNameValidMessage = '';
    _nickNameInfoMessage = '랜덤으로 지정된 닉네임입니다. 자유롭게 수정 가능해요';
    _nickNameInfoType = 'checkInfo';
    _isNickNameInfo = true;

    _nameValid = true;
    _nameValidMessage = '';
    _emailValid = true;
    _emailValidMessage = '';
    _passwordObscure = true;
    _passwordValid = true;
    _passwordValidMessage = '';
    _isNickNameInfoValid = false;
    _nickNameInfoValidMessage = '';
    _passwordCheckValid = true;
    _passwordCheckValidMessage = '';
    _phoneNumValid = true;
    _phoneNumValidMessage = '';
    _cerNumValid = true;
    _cerNumValidMessage = '';
    _checkSmsValidation = false;

    _nickNameHelperType = '';
    _nickNameHelper = false;
    _emailHelperType = '';
    _emailHelper = false;

    _checkNickNameDuplication = false;
    _checkEmailDuplication = false;
    _changeNickName = false;

    _passwordCheckObscure = false;
    _addListenerPasswordCheck = false;
    _isSignUpSub2NextButtonEnabled = false;
    _sendCertNum = false;

    _gender = 0;
    _allCheck = false;
    _requiredTermsOfUseCheck = false;
    _personalInfoCheck = false;
    _marketingCheck = false;
    _termsOfUseCheck = false;

    _isPhoneNumEnabled = true;
    _isCertNumEnabled = true;
    _certNumCount = 0;

    resetTimer(180);
    _timer?.cancel();
    _timer = null;

    notifyListeners();
  }

  @override
  void clearText(TextEditingController controller) {
    controller.clear();
    notifyListeners();
  }

  void updateSignUp(int pageNum) {
    if (pageNum == 2 && _isFirstVisit) {
      _isFirstVisit = false;
    }
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

  void setNickName(String randomNickName) {
    _nickNameController.text = randomNickName;
    notifyListeners();
  }

  void checkNickNameDuplication(bool isNickNameDuplication) {
    _checkNickNameDuplication = isNickNameDuplication;
    _nickNameHelper = false;
    if (_checkNickNameDuplication) {
      _isNickNameInfo = false;
      _nickNameHelperType = 'error';
      _nickNameValid = false;
      _nickNameValidMessage = "이미 등록된 닉네임 입니다.";
    } else {
      _isNickNameInfo = false;
      _nickNameHelperType = 'check';
      _nickNameValid = true;
      _nickNameValidMessage = "사용가능한 닉네임 입니다.";
    }

    notifyListeners();
  }

  void checkEmailDuplication(bool isUserIdDuplication) {
    _checkEmailDuplication = isUserIdDuplication;
    _emailHelper = false;
    if (_checkEmailDuplication) {
      _emailHelperType = 'error';
      _emailValid = false;
      _emailValidMessage = "이미 가입된 이메일 주소입니다. 다시 확인해 주세요";
    } else {
      _emailHelperType = 'check';
      _emailValid = true;
      _emailValidMessage = "사용 가능한 아이디 입니다.";
    }

    notifyListeners();
  }

  void updateNickNameChange(bool change) {
    _changeNickName = change;
    notifyListeners();
  }

  void updateEmailValid(String message) {
    if (message == '') {
      _emailHelper = true;
      _emailHelperType = '';
      _emailValid = true;
      _emailValidMessage = '';
    } else {
      _emailHelper = false;
      _emailHelperType = 'error';
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
      _emailHelperType = 'error';
      _emailValid = false;
      _emailValidMessage = '이메일 입력은 필수입니다.';
    }
    if (_nameController.text.isEmpty) {
      _nameValid = false;
      _nameValidMessage = '이름 입력은 필수입니다.';
    }
    notifyListeners();
  }

  void checkBeforePasswordCheckValid() {
    if (_emailController.text.isEmpty) {
      _emailHelperType = 'error';
      _emailValid = false;
      _emailValidMessage = '이메일 입력은 필수입니다.';
    }
    if (_nameController.text.isEmpty) {
      _nameValid = false;
      _nameValidMessage = '이름 입력은 필수입니다.';
    }
    if (_passwordController.text.isEmpty) {
      _passwordValid = false;
      _passwordValidMessage = '비밀번호 입력은 필수입니다.';
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

  void updateNickNameInfo(String info, String infoGuide) {
    _nickNameHelper = true;
    _isNickNameInfoValid = true;
    _nickNameInfoMessage = info;
    _nickNameInfoValidMessage = infoGuide;
    notifyListeners();
  }

  void updateNickNameInfoValid(String type) {
    if (type == '' && !_isFirstVisit) {
      _isNickNameInfo = false;
      _isNickNameInfoValid = false;
      _nickNameInfoValidMessage = '';
      _changeNickName = true;
    } else {
      _isNickNameInfo = true;
      _isNickNameInfoValid = true;
      _nickNameInfoType = type;
      _nickNameValid = false;
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

  void finishCheckCertNum() {
    _isPhoneNumEnabled = false;
    _isCertNumEnabled = false;
    notifyListeners();
  }

  void updateSmsValidation(bool result) {
    _checkSmsValidation = result;
    notifyListeners();
  }

  void failedValidChkCertNum() {
    _certNumCount++;
    _cerNumValid = false;
    _cerNumValidMessage = "인증번호가 일치하지 않습니다 ($certNumCount/5)";
    notifyListeners();
  }

  void reSendCertNum() {
    _certNumCount = 0;
    _cerNumValid = true;
    _cerNumValidMessage = '';
    notifyListeners();
  }

  void startTimer(BuildContext context) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_certTimerSeconds.value > 0) {
        _certTimerSeconds.value -= 1;
      } else {
        SingleBtnDialog.show(context,
            content: '인증번호 시간 초과\n다시 시도해 주세요.',
            timer: false,
            button: PrimaryM(
              content: '확인',
              onPressed: () {
                overValidTime();
                context.pop();
              },
            ));
        timer.cancel();
      }
    });
  }

  void resetTimer(int timeSeconds) {
    stopTimer();
    _certTimerSeconds.value = timeSeconds;
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void authFailed() {
    _sendCertNum = false;
    resetTimer(180);
    notifyListeners();
  }

  void overValidTime() {
    _sendCertNum = false;
    resetTimer(180);
    notifyListeners();
  }
}
