import 'package:app_front_talearnt/provider/clear_text.dart';
import 'package:flutter/material.dart';

import '../../data/model/respone/kakao_sign_up_user_info.dart';

class KakaoProvider extends ChangeNotifier with ClearText {
  int _gender = 0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();

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

  bool _allCheck = false;
  bool _requiredTermsOfUseCheck = false;
  bool _personalInfoCheck = false;
  bool _marketingCheck = false;
  bool _termsOfUseCheck = false;

  int get gender => _gender;

  TextEditingController get nameController => _nameController;

  TextEditingController get emailController => _emailController;

  TextEditingController get phoneNumController => _phoneNumController;

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

  bool get checkNickNameDuplication => _checkNickNameDuplication;

  bool get allCheck => _allCheck;

  bool get requiredTermsOfUseCheck => _requiredTermsOfUseCheck;

  bool get personalInfoCheck => _personalInfoCheck;

  bool get marketingCheck => _marketingCheck;

  bool get termsOfUseCheck => _termsOfUseCheck;

  bool get isEnabledKakaoSignup =>
      requiredTermsOfUseCheck && personalInfoCheck && checkNickNameDuplication;

  void clearProvider() {
    _gender = 0;

    _nameController.clear();
    _emailController.clear();
    _phoneNumController.clear();
    _nickNameController.clear();
    _nickNameFocusNode.unfocus();

    _nickNameValid = true;
    _nickNameValidMessage = '';
    _checkNickNameDuplication = false;

    _allCheck = false;
    _requiredTermsOfUseCheck = false;
    _personalInfoCheck = false;
    _marketingCheck = false;
    _termsOfUseCheck = false;

    notifyListeners();
  }

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

  void updateNickNameController(TextEditingController textEditingController) {
    textEditingController.addListener(() {
      notifyListeners();
    });
  }

  void updateNickNameValid(String message) {
    if (message == '') {
      _nickNameValid = true;
      _nickNameValidMessage = '';
      _checkNickNameDuplication = true;
    } else {
      _nickNameValid = false;
      _nickNameValidMessage = message;
      _checkNickNameDuplication = false;
    }
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

  void updateNickNameInfoValid(String type) {
    if (type == '') {
      _isNickNameInfo = false;
      _isNickNameInfoValid = false;
      _nickNameInfoValidMessage = '';
      _changeNickName = true;
    } else {
      _isNickNameInfo = true;
      _isNickNameInfoValid = true;
      _nickNameInfoType = type;
    }
    notifyListeners();
  }

  void updateNickNameInfo(String info, String infoGuide) {
    _isNickNameInfoValid = true;
    _nickNameInfoMessage = info;
    _nickNameInfoValidMessage = infoGuide;
    notifyListeners();
  }

  void setNickName(String randomNickName) {
    _nickNameController.text = randomNickName;
    _checkNickNameDuplication = true;
    notifyListeners();
  }

  void setKakaoUserInfo(KakaoSignUpUserInfo userInfo) {
    _gender = userInfo.gender;
    _nameController.text = userInfo.name;
    _phoneNumController.text = userInfo.phone;
    _emailController.text = userInfo.userId;
    notifyListeners();
  }
}
