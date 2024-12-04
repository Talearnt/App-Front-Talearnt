import 'dart:async';

import 'package:flutter/material.dart';

class CommonProvider with ChangeNotifier {
  Timer? _timer;

  // 타이머 시작 메서드
  void startTimer(ValueNotifier<int> timerSeconds) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  String getFormattedTime(ValueNotifier<int>? timerSeconds) {
    int minutes = (timerSeconds?.value ?? 180) ~/ 60;
    int seconds = (timerSeconds?.value ?? 180) % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // 타이머 초기화 메서드
  void resetTimer(ValueNotifier<int> timerSeconds, int resetTime) {
    _timer?.cancel();
    timerSeconds.value = resetTime;
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
  void validateInfoNickName(TextEditingController textEditingController,
      bool hasFocus, Function(String) callback) {
    if (!hasFocus) {
      RegExp(r'^[가-힣a-zA-Z0-9#]{2,12}$').hasMatch(textEditingController.text) ==
              false
          ? callback('errorInfo')
          : callback('');
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

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
