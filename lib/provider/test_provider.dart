import 'package:flutter/material.dart';

class TestProvider extends ChangeNotifier {
  String _data = '';

  String get data => _data;

  void fetchData(String newData) {
    _data = newData;
    notifyListeners(); // 상태 변경 통지
  }
}
