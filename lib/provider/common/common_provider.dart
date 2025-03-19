import 'dart:async';

import 'package:flutter/material.dart';

import 'custom_ticker_provider.dart';

class CommonProvider with ChangeNotifier {
  CommonProvider() : _tickerProvider = CustomTickerProvider() {
    _animationController = AnimationController(
      vsync: _tickerProvider, duration: const Duration(seconds: 1), // 1초 동안 회전
    )..repeat();

    _startImageToggle();
  }

  bool _isLoadingPage = false;
  final CustomTickerProvider _tickerProvider;
  late AnimationController _animationController;
  OverlayEntry? _currentEntry;
  bool _isEntryUpdate = false;
  bool _isBackGesture = false;

  bool get isLoadingPage => _isLoadingPage;

  AnimationController get animationController => _animationController;

  OverlayEntry? get currentEntry => _currentEntry;

  bool get isEntryUpdate => _isEntryUpdate;

  bool get isBackGesture => _isBackGesture;

  final ValueNotifier<bool> isOnImage = ValueNotifier<bool>(false);
  Timer? _timer;

  void _startImageToggle() {
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      isOnImage.value = !isOnImage.value;
    });
  }

  void changeIsLoading(bool loadingType) {
    _isLoadingPage = loadingType;
    notifyListeners();
  }

  String getFormattedTime(ValueNotifier<int>? timerSeconds) {
    int minutes = (timerSeconds?.value ?? 180) ~/ 60;
    int seconds = (timerSeconds?.value ?? 180) % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // 이메일
  void validateEmailText(TextEditingController textEditingController,
      bool hasFocus, Function(String) callback) {
    if (!hasFocus) {
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                  .hasMatch(textEditingController.text) ==
              false
          ? callback('올바른 이메일을 입력하세요.')
          : callback('');
      notifyListeners();
    }
  }

  // 회원가입할때 이메일
  void validateSignUpEmailText(
      TextEditingController textEditingController,
      bool hasFocus,
      Function(String) callback,
      Function(String?) onServerCheck) async {
    bool isValid = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(textEditingController.text);
    if (!hasFocus) {
      if (isValid) {
        callback('');
        await onServerCheck(textEditingController.text);
      } else {
        callback('올바른 이메일을 입력하세요.');
      }
      notifyListeners();
    }
  }

  //패스워드
  void validatePasswordText(TextEditingController textEditingController,
      bool hasFocus, Function(String) callback) {
    if (!hasFocus) {
      RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$')
                  .hasMatch(textEditingController.text) ==
              false
          ? callback('영문, 숫자, 특수문자의 조합 8자리 이상 입력해 주세요')
          : callback('');
      notifyListeners();
    }
  }

  //폰번호
  void validatePhoneNum(TextEditingController textEditingController,
      bool hasFocus, Function(String) callback) {
    if (!hasFocus) {
      RegExp(r'^010\d{8}$').hasMatch(textEditingController.text) == false
          ? callback('01012345678 형식으로 입력해주세요.')
          : callback('');
      notifyListeners();
    }
  }

  //이름
  void validateName(TextEditingController textEditingController, bool hasFocus,
      Function(String) callback) {
    if (!hasFocus) {
      RegExp(r'^[가-힣]{2,5}$').hasMatch(textEditingController.text) == false
          ? callback('이름은 최소 2글자에서 최대 5글자까지, 한글만 입력 가능합니다.')
          : callback('');
      notifyListeners();
    }
  }

  //비번체크
  void validatePhoneCheckNum(TextEditingController textEditingController,
      bool hasFocus, Function(String) callback) {
    callback(textEditingController.text);
    notifyListeners();
  }

  //닉네임체크
  void validateInfoNickName(
      TextEditingController textEditingController,
      bool hasFocus,
      Function(String) callback,
      Function(String?) onServerCheck) async {
    bool isValid =
        RegExp(r'^[가-힣a-zA-Z0-9#]{2,12}$').hasMatch(textEditingController.text);
    if (!hasFocus) {
      if (isValid) {
        callback('');
        await onServerCheck(textEditingController.text);
      } else {
        callback('errorInfo');
      }
      notifyListeners();
    }
  }

  void setInfoNickName(bool hasFocus, Function(String, String) callback) {
    if (hasFocus) {
      callback('2~12자 이내로 입력해 주세요', '한글, 영문, 숫자는 자유롭게 입력 가능하며, 특수문자는 #만 가능해요');
      notifyListeners();
    }
  }

  //다른거 확인하는거..
  void checkBeforeValid(Function() callback) {
    callback();
    notifyListeners();
  }

  void updateEntry(OverlayEntry overlayEntry) {
    _currentEntry = overlayEntry;
    _isEntryUpdate = true;
    notifyListeners();
  }

  void removeToast() {
    _currentEntry?.remove();
    _currentEntry = null;
    _isEntryUpdate = false;

    notifyListeners();
  }

  void updateBackGesture(bool gesture) {
    _isBackGesture = gesture;

    notifyListeners();
  }
}
