import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageProvider extends ChangeNotifier {
  SharedPreferences? _prefs;

  final Map<String, String?> _cachedValues = {};

  String? getValue(String key) => _cachedValues[key];

  Timer? _timer;
  ValueNotifier<int> _certNumResendCoolDown = ValueNotifier<int>(600);
  bool _isCoolDown = false;

  ValueNotifier<int> get certNumResendCoolDown => _certNumResendCoolDown;
  bool get isCoolDown => _isCoolDown;

  StorageProvider() {
    _initializeStorage();
  }

  Future<void> _initializeStorage() async {
    _prefs = await SharedPreferences.getInstance();

    for (String key in _prefs!.getKeys()) {
      _cachedValues[key] = _prefs?.getString(key);
    }
    notifyListeners();
  }

  Future<void> saveData(String key, dynamic value) async {
    if (_prefs == null) return;
    await _prefs!.setString(key, value);
    _cachedValues[key] = value;
    notifyListeners();
  }

  Future<void> deleteData(String key) async {
    if (_prefs == null) return;
    await _prefs!.remove(key);
    _cachedValues.remove(key);
    notifyListeners();
  }

  Future<String?> getData(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.getString(key);
  }

  void startCoolDown() {
    if (!_isCoolDown) {
      startTimer();
      _isCoolDown = true;
      DateTime coolDownEndTime =
          DateTime.now().add(const Duration(minutes: 10));

      saveData("coolDownEndTime", coolDownEndTime);
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
