import 'package:flutter/material.dart';

import '../common/common_navigator.dart';
import '../data/repositories/talearnt_board_repository.dart';

class TalearntBoardViewModel extends ChangeNotifier {
  final CommonNavigator commonNavigator;
  final TalearntBoardRepository talearntBoardRepository;

  TalearntBoardViewModel(
    this.commonNavigator,
    this.talearntBoardRepository,
  );
}
