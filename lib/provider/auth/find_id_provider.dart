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
  String _phoneNumberValidMessage = '';

  final TextEditingController _certNumberController = TextEditingController();
  final FocusNode _certFocusNode = FocusNode();
  bool _certNumberValid = true;
  bool _isCertSend = false;
  String _certValidMessage = '';
  int _certNumberCount = 0;
  ValueNotifier<int> _certNumSecond = ValueNotifier<int>(600);

  bool _isValidNameAndPhoneNumber = false;

  String _userId = '';
  String _createdAt = '';

  FocusNode get userNameFocusNode => _userNameFocusNode;
  FocusNode get phoneNumberFocusNode => _phoneNumberFocusNode;
  FocusNode get certFocusNode => _certFocusNode;

  bool get userNameValid => _userNameValid;
  bool get phoneNumberValid => _phoneNumberValid;
  bool get certNumberValid => _certNumberValid;

  String get userNameMessage => _userNameMessage;
  String get phoneNumberValidMessage => _phoneNumberValidMessage;
  String get certValidMessage => _certValidMessage;

  bool get isValidNameAndPhoneNumber => _isValidNameAndPhoneNumber;

  TextEditingController get userNameController => _userNameController;
  TextEditingController get phoneNumberController => _phoneNumberController;
  TextEditingController get certNumberController => _certNumberController;

  bool get isCertSend => _isCertSend;

  int get certNumberCount => _certNumberCount;
  ValueNotifier<int> get certNumSecond => _certNumSecond;

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
    _certNumberValid = true;

    _isValidNameAndPhoneNumber = false;

    _userNameMessage = '';
    _phoneNumberValidMessage = '';
    _certValidMessage = '';

    _isCertSend = false;

    _certNumberCount = 0;
    _certNumSecond = ValueNotifier<int>(600);

    _userId = '';
    _createdAt = '';

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

  void chkValidEmailAndPhoneNumber() {
    if (RegExp(r'^010\d{8}$').hasMatch(phoneNumberController.text) &&
        _phoneNumberController.text.length == 11 &&
        _userNameValid &&
        _phoneNumberValid) {
      _isValidNameAndPhoneNumber = true;
    } else {
      _isValidNameAndPhoneNumber = false;
    }
    notifyListeners();
  }

  void sendCertNum() {
    _isCertSend = true;
    print(_isCertSend);
    notifyListeners();
  }

  void reSendCertNum() {
    _certNumberCount = 0;
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
