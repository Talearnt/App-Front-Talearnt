import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  SharedPreferences? _prefs;

  Timer? _timer;
  ValueNotifier<int> _certNumResendCoolDown = ValueNotifier<int>(600);
  bool _isCoolDown = false;

  ValueNotifier<int> get certNumResendCoolDown => _certNumResendCoolDown;

  bool get isCoolDown => _isCoolDown;

  Future<void> saveData(String key, String value) async {
    await _storage.write(key: key, value: value);

    notifyListeners();
  }

  Future<String?> getData(String key) async {
    final String? value = await _storage.read(key: key);

    notifyListeners();

    return value;
  }

  Future<void> deleteData(String key) async {
    await _storage.delete(key: key);

    notifyListeners();
  }

  void startCoolDown() {
    if (!_isCoolDown) {
      startTimer();
      _isCoolDown = true;
      DateTime coolDownEndTime =
          DateTime.now().add(const Duration(minutes: 10));

      saveData("coolDownEndTime", coolDownEndTime.toString());
    }
    notifyListeners();
  }

  void reStartCoolDown() {
    if (!_isCoolDown) {
      startTimer();
      _isCoolDown = true;
    }
    notifyListeners();
  }

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_certNumResendCoolDown.value > 0) {
          _certNumResendCoolDown.value -= 1;
          notifyListeners();
        } else {
          _isCoolDown = false;
          timer.cancel();
          deleteData("coolDownEndTime");
        }
      },
    );
  }

  void resetTimer() {
    stopTimer();
    _certNumResendCoolDown = ValueNotifier<int>(600);
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void setCoolDownTime() async {
    final String? coolDownEndTimeString = await getData("CoolDownEndTime");

    if (coolDownEndTimeString != null) {
      final DateTime coolDownEndTime = DateTime.parse(coolDownEndTimeString);
      final DateTime now = DateTime.now();

      if (coolDownEndTime.isAfter(now)) {
        final int remainingSeconds = coolDownEndTime.difference(now).inSeconds;
        _certNumResendCoolDown.value = remainingSeconds;

        reStartCoolDown();
      } else {
        deleteData("coolDownEndTime");
      }
    }
  }
}
