import 'package:flutter/material.dart';

import '../clear_text.dart';

class FindIdProvider extends ChangeNotifier with ClearText {
  final TextEditingController _userNameController = TextEditingController();
  final FocusNode _userNameFocusNode = FocusNode();
  bool _userNameValid = true;
  String _userNameMessage = '';

  final TextEditingController _phoneNumberController = TextEditingController();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  bool _phoneNumberValid = true;
  bool _phoneNumberValidAndNotEmpty = false;
  String _phoneNumberValidMessage = '';

  final TextEditingController _certNumberController = TextEditingController();
  final FocusNode _certFocusNode = FocusNode();
  bool _certNumberValid = true;
  bool _isCertSend = false;
  bool _isCertReSend = false;
  final bool _certValidAndNotEmpty = false;
  String _certValidMessage = '';
  int _certNumberCount = 0;

  String _userId = '';
  String _createdAt = '';

  FocusNode get userNameFocusNode => _userNameFocusNode;
  FocusNode get phoneNumberFocusNode => _phoneNumberFocusNode;
  FocusNode get certFocusNode => _certFocusNode;

  bool get userNameValid => _userNameValid;
  bool get phoneNumberValid => _phoneNumberValid;
  bool get phoneNumberValidAndNotEmpty => _phoneNumberValidAndNotEmpty;
  bool get certNumberValid => _certNumberValid;

  String get userNameMessage => _userNameMessage;
  String get phoneNumberValidMessage => _phoneNumberValidMessage;
  String get certValidMessage => _certValidMessage;

  TextEditingController get userNameController => _userNameController;
  TextEditingController get phoneNumberController => _phoneNumberController;
  TextEditingController get certNumberController => _certNumberController;

  bool get isCertSend => _isCertSend;
  bool get isCertReSend => _isCertReSend;
  bool get certValidAndNotEmpty => _certValidAndNotEmpty;

  int get certNumberCount => _certNumberCount;

  String get userId => _userId;
  String get createdAt => _createdAt;

  @override
  void clearProvider() {
    _userNameController.clear();
    _phoneNumberController.clear();
    _certNumberController.clear();
    _userNameFocusNode.unfocus();
    _phoneNumberFocusNode.unfocus();
    _certFocusNode.unfocus();

    _userNameValid = true;
    _phoneNumberValid = true;
    _phoneNumberValidAndNotEmpty = false;
    _userNameMessage = '';
    _phoneNumberValidMessage = '';
    _isCertSend = false;
    _isCertReSend = false;

    _certNumberCount = 0;

    _userId = '';
    _createdAt = '';

    notifyListeners();
  }

  @override
  void clearText(TextEditingController controller) {
    controller.clear();
    notifyListeners();
  }

  void updateController(TextEditingController phoneNumberController) {
    phoneNumberController.addListener(() {
      if (phoneNumberValid && phoneNumberController.text.length == 11) {
        _phoneNumberValidAndNotEmpty = true;
      }
      if (phoneNumberController.text.length != 11) {
        _phoneNumberValidAndNotEmpty = false;
        _phoneNumberValidMessage = '';
      }
      notifyListeners();
    });
  }

  void updateUserNameValid(String message) {
    if (message == '') {
      _userNameValid = true;
      _userNameMessage = '';
    } else {
      _userNameValid = false;
      _userNameMessage = message;
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

  void sendCertNum() {
    _isCertSend = true;
    _isCertReSend = true;
    notifyListeners();
  }

  void reSendCertNum() {
    _certNumberCount = 0;
    _isCertReSend = false;
    notifyListeners();
  }

  void setFindedUserIdInfo(String userId, String createdAt) {
    _userId = userId;
    _createdAt = createdAt;
    notifyListeners();
  }

  void checkCertNum(bool success) {
    _certNumberValid = success;
  }

  void failedValidChkCertNum() {
    _certNumberCount++;
    _certNumberValid = false;
    _certValidMessage = "인증번호가 일치하지 않습니다 ($certNumberCount/5)";
    notifyListeners();
  }
}
