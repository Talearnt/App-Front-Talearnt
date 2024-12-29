import 'dart:async';

import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
  ValueNotifier<int> _certNumSecond = ValueNotifier<int>(180);
  Timer? _timer;

  bool _isValidNameAndPhoneNumber = false;

  String _userId = '';
  String _createdAt = '';

  bool _loadFindIdSuccessPage = false;

  bool _textInputEnabled = true;

  FocusNode get userNameFocusNode => _userNameFocusNode;

  FocusNode get phoneNumberFocusNode => _phoneNumberFocusNode;

  FocusNode get certFocusNode => _certFocusNode;

  bool get userNameValid => _userNameValid;

  bool get phoneNumberValid => _phoneNumberValid;

  bool get certNumberValid => _certNumberValid;

  String get userNameMessage => _userNameMessage;

  String get phoneNumberValidMessage => _phoneNumberValidMessage;

  String get certValidMessage => _certValidMessage;

  bool get isValidNameAndPhoneNumber =>
      _isValidNameAndPhoneNumber &&
      _userNameController.text.isNotEmpty &&
      _phoneNumberController.text.isNotEmpty;

  TextEditingController get userNameController => _userNameController;

  TextEditingController get phoneNumberController => _phoneNumberController;

  TextEditingController get certNumberController => _certNumberController;

  bool get isCertSend => _isCertSend;

  int get certNumberCount => _certNumberCount;

  ValueNotifier<int> get certNumSecond => _certNumSecond;

  String get userId => _userId;

  String get createdAt => _createdAt;

  bool get loadFindIdSuccessPage => _loadFindIdSuccessPage;

  bool get textInputEnabled => _textInputEnabled;

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
    _certNumSecond = ValueNotifier<int>(180);

    _userId = '';
    _createdAt = '';

    _certNumberCount = 0;

    _userId = '';
    _createdAt = '';

    _loadFindIdSuccessPage = false;

    _textInputEnabled = true;

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
        RegExp(r'^[가-힣]{1,5}$').hasMatch(userNameController.text)) {
      _userNameValid = true;
      _userNameMessage = '';
      _phoneNumberValid = true;
      _phoneNumberValidMessage = '';
      _isValidNameAndPhoneNumber = true;
    } else {
      _isValidNameAndPhoneNumber = false;
    }
    notifyListeners();
  }

  void sendCertNum() {
    _textInputEnabled = false;
    _isCertSend = true;
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

  void startCountdown(BuildContext context) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_certNumSecond.value > 0) {
        _certNumSecond.value -= 1;
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

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void resetTimer() {
    stopTimer();
    _certNumSecond = ValueNotifier<int>(180);
  }

  void afterLoad() {
    _loadFindIdSuccessPage = true;
  }

  void overValidTime() {
    _textInputEnabled = true;
    _isCertSend = false;
    resetTimer();
    notifyListeners();
  }

  void authFailed() {
    _textInputEnabled = true;
    _isCertSend = false;
    resetTimer();
    notifyListeners();
  }
}
