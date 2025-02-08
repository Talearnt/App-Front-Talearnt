import 'package:flutter/material.dart';

class CommonBoardProvider extends ChangeNotifier {
  String _boardType = 'match'; //match - 매칭, community - 커뮤니티

  String get boardType => _boardType;

  void setBoardType(String type) {
    _boardType = type;
    notifyListeners();
  }
}
