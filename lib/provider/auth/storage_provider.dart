import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageProvider extends ChangeNotifier {
  SharedPreferences? _prefs;

  final Map<String, String?> _cachedValues = {};

  String? getValue(String key) => _cachedValues[key];

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

  Future<void> saveData(String key, String value) async {
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
}
