import 'dart:async';

import 'package:flutter/material.dart';

class CommonProvider with ChangeNotifier {
  static const int _initialTimerSeconds = 600;
  int _timerSeconds = _initialTimerSeconds;
  Timer? _timer;

  // 타이머 시작 메서드
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        _timerSeconds--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  // void getFormattedTime(int time){
  //   int
  // }

  // 타이머 형식화된 문자열 반환 메서드
  String get formattedTime {
    int minutes = _timerSeconds ~/ 60;
    int seconds = _timerSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // 타이머 초기화 메서드
  void resetTimer() {
    _timer?.cancel();
    _timerSeconds = _initialTimerSeconds;
    notifyListeners();
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
      RegExp(r'^[가-힣]{1,5}$').hasMatch(textEditingController.text) == false
          ? callback('이름은 최대 5글자, 한글만 가능합니다.')
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
  void validateNickName(TextEditingController textEditingController,
      bool hasFocus, Function(String) callback) {
    if (!hasFocus) {
      RegExp(r'^[가-힣a-zA-Z0-9#]{2,12}$').hasMatch(textEditingController.text) ==
              false
          ? callback('한글, 영문, 숫자는 자유롭게 입력 가능하며, 특수문자는 #만 가능해요.')
          : callback('');
      notifyListeners();
    }
  }

  //다른거 확인하는거..
  void checkBeforeValid(Function() callback) {
    callback();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
