import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  SharedPreferences? _prefs;

  Timer? _certNumResendTimer;
  Timer? _likeTimer;
  Timer? _favoriteTimer;
  Timer? _boardStatusTimer;

  ValueNotifier<int> _certNumResendCoolDown = ValueNotifier<int>(600);
  ValueNotifier<int> _likeCoolDown = ValueNotifier<int>(60);
  ValueNotifier<int> _favoriteCoolDown = ValueNotifier<int>(60);
  ValueNotifier<int> _boardStatusCoolDown = ValueNotifier<int>(60);

  bool _isCertNumResendCoolDown = false;
  bool _isLikeCoolDown = false;
  bool _isFavoriteCoolDown = false;
  bool _isBoardStatusCoolDown = false;

  ValueNotifier<int> get certNumResendCoolDown => _certNumResendCoolDown;

  ValueNotifier<int> get likeCoolDown => _likeCoolDown;

  ValueNotifier<int> get favoriteCoolDown => _favoriteCoolDown;

  ValueNotifier<int> get boardStatusCoolDown => _boardStatusCoolDown;

  bool get isCertNumResendCoolDown => _isCertNumResendCoolDown;

  bool get isLikeCoolDown => _isLikeCoolDown;

  bool get isFavoriteCoolDown => _isFavoriteCoolDown;

  bool get isBoardStatusCoolDown => _isBoardStatusCoolDown;

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

  void startCertNumResendCoolDown() {
    if (!_isCertNumResendCoolDown) {
      startCertNumResendTimer();
      _isCertNumResendCoolDown = true;
      DateTime coolDownEndTime =
          DateTime.now().add(const Duration(minutes: 10));
      saveData("certNumResendCoolDownEndTime", coolDownEndTime.toString());
    }
    notifyListeners();
  }

  void reStartCertNumResendCoolDown() {
    if (!_isCertNumResendCoolDown) {
      startCertNumResendTimer();
      _isCertNumResendCoolDown = true;
    }
    notifyListeners();
  }

  void startCertNumResendTimer() {
    _certNumResendTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_certNumResendCoolDown.value > 0) {
          _certNumResendCoolDown.value -= 1;
          notifyListeners();
        } else {
          _isCertNumResendCoolDown = false;
          timer.cancel();
          deleteData("certNumResendCoolDownEndTime");
        }
      },
    );
  }

  void resetCertNumResendCoolDownTimer() {
    stopCertNumResendCoolDownTimer();
    _certNumResendCoolDown = ValueNotifier<int>(600);
  }

  void stopCertNumResendCoolDownTimer() {
    _certNumResendTimer?.cancel();
    _certNumResendTimer = null;
  }

  void setCertNumResendCoolDownTime() async {
    final String? coolDownEndTimeString =
        await getData("certNumResendCoolDownEndTime");
    if (coolDownEndTimeString != null) {
      final DateTime coolDownEndTime = DateTime.parse(coolDownEndTimeString);
      final DateTime now = DateTime.now();

      if (coolDownEndTime.isAfter(now)) {
        final int remainingSeconds = coolDownEndTime.difference(now).inSeconds;
        _certNumResendCoolDown.value = remainingSeconds;
        reStartCertNumResendCoolDown();
      } else {
        deleteData("certNumResendCoolDownEndTime");
      }
    }
  }

  void startLikeCoolDown() {
    if (!_isLikeCoolDown) {
      startLikeTimer();
      _isLikeCoolDown = true;
      DateTime coolDownEndTime = DateTime.now().add(const Duration(minutes: 1));
      saveData("likeCoolDownEndTime", coolDownEndTime.toString());
    }
    notifyListeners();
  }

  void reStartLikeCoolDown() {
    if (!_isLikeCoolDown) {
      startLikeTimer();
      _isLikeCoolDown = true;
    }
    notifyListeners();
  }

  void startLikeTimer() {
    _likeTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_likeCoolDown.value > 0) {
          _likeCoolDown.value -= 1;
          notifyListeners();
        } else {
          _isLikeCoolDown = false;
          timer.cancel();
          deleteData("likeCoolDownEndTime");
        }
      },
    );
  }

  void resetLikeCoolDownTimer() {
    stopLikeCoolDownTimer();
    _likeCoolDown = ValueNotifier<int>(60);
  }

  void stopLikeCoolDownTimer() {
    _likeTimer?.cancel();
    _likeTimer = null;
  }

  void setLikeCoolDownTime() async {
    final String? coolDownEndTimeString = await getData("likeCoolDownEndTime");
    if (coolDownEndTimeString != null) {
      final DateTime coolDownEndTime = DateTime.parse(coolDownEndTimeString);
      final DateTime now = DateTime.now();

      if (coolDownEndTime.isAfter(now)) {
        final int remainingSeconds = coolDownEndTime.difference(now).inSeconds;
        _likeCoolDown.value = remainingSeconds;
        reStartLikeCoolDown();
      } else {
        deleteData("likeCoolDownEndTime");
      }
    }
  }

  void startFavoriteCoolDown() {
    if (!_isFavoriteCoolDown) {
      startFavoriteTimer();
      _isFavoriteCoolDown = true;
      DateTime coolDownEndTime = DateTime.now().add(const Duration(minutes: 1));
      saveData("favoriteCoolDownEndTime", coolDownEndTime.toString());
    }
    notifyListeners();
  }

  void reStartFavoriteCoolDown() {
    if (!_isFavoriteCoolDown) {
      startFavoriteTimer();
      _isFavoriteCoolDown = true;
    }
    notifyListeners();
  }

  void startFavoriteTimer() {
    _favoriteTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_favoriteCoolDown.value > 0) {
          _favoriteCoolDown.value -= 1;
          notifyListeners();
        } else {
          _isFavoriteCoolDown = false;
          timer.cancel();
          deleteData("favoriteCoolDownEndTime");
        }
      },
    );
  }

  void resetFavoriteCoolDownTimer() {
    stopFavoriteCoolDownTimer();
    _favoriteCoolDown = ValueNotifier<int>(60);
  }

  void stopFavoriteCoolDownTimer() {
    _favoriteTimer?.cancel();
    _favoriteTimer = null;
  }

  void setFavoriteCoolDownTime() async {
    final String? coolDownEndTimeString =
        await getData("favoriteCoolDownEndTime");
    if (coolDownEndTimeString != null) {
      final DateTime coolDownEndTime = DateTime.parse(coolDownEndTimeString);
      final DateTime now = DateTime.now();

      if (coolDownEndTime.isAfter(now)) {
        final int remainingSeconds = coolDownEndTime.difference(now).inSeconds;
        _favoriteCoolDown.value = remainingSeconds;
        reStartFavoriteCoolDown();
      } else {
        deleteData("favoriteCoolDownEndTime");
      }
    }
  }

  void startBoardStatusCoolDown() {
    if (!_isBoardStatusCoolDown) {
      startBoardStatusTimer();
      _isBoardStatusCoolDown = true;
      DateTime coolDownEndTime = DateTime.now().add(const Duration(minutes: 1));
      saveData("boardStatusCoolDownEndTime", coolDownEndTime.toString());
    }
    notifyListeners();
  }

  void reStartBoardStatusCoolDown() {
    if (!_isBoardStatusCoolDown) {
      startBoardStatusTimer();
      _isBoardStatusCoolDown = true;
    }
    notifyListeners();
  }

  void startBoardStatusTimer() {
    _boardStatusTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_boardStatusCoolDown.value > 0) {
          _boardStatusCoolDown.value -= 1;
          notifyListeners();
        } else {
          _isBoardStatusCoolDown = false;
          timer.cancel();
          deleteData("boardStatusCoolDownEndTime");
        }
      },
    );
  }

  void resetBoardStatusCoolDownTimer() {
    stopBoardStatusCoolDownTimer();
    _boardStatusCoolDown = ValueNotifier<int>(60);
  }

  void stopBoardStatusCoolDownTimer() {
    _boardStatusTimer?.cancel();
    _boardStatusTimer = null;
  }

  void setBoardStatusCoolDownTime() async {
    final String? coolDownEndTimeString =
        await getData("boardStatusCoolDownEndTime");
    if (coolDownEndTimeString != null) {
      final DateTime coolDownEndTime = DateTime.parse(coolDownEndTimeString);
      final DateTime now = DateTime.now();

      if (coolDownEndTime.isAfter(now)) {
        final int remainingSeconds = coolDownEndTime.difference(now).inSeconds;
        _boardStatusCoolDown.value = remainingSeconds;
        reStartBoardStatusCoolDown();
      } else {
        deleteData("boardStatusCoolDownEndTime");
      }
    }
  }
}
