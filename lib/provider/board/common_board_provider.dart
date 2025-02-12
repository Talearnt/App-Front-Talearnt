import 'package:flutter/material.dart';

class CommonBoardProvider extends ChangeNotifier {
  String _boardType = 'match'; //match - 매칭, community - 커뮤니티
  bool _initState = true;

  String get boardType => _boardType;

  bool get initState => _initState;

  void setBoardType(String type) {
    _boardType = type;
    notifyListeners();
  }

  void updateInitState(bool newType) {
    _initState = newType;
    notifyListeners();
  }
}
