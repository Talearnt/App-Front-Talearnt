import 'package:app_front_talearnt/provider/talearnt_board/match_write_provider.dart';
import 'package:flutter/material.dart';

import '../common/common_navigator.dart';
import '../constants/global_value_constants.dart';
import '../data/repositories/taleant_board_repository.dart';
import '../provider/talearnt_board/keyword_provider.dart';
import '../utils/error_message.dart';

class TalearntBoardViewModel extends ChangeNotifier {
  final CommonNavigator commonNavigator;
  final TalearntBoardRepository talearntBoardRepository;
  final KeywordProvider keywordProvider;
  final MatchWriteProvider matchWriteProvider;

  TalearntBoardViewModel(
    this.commonNavigator,
    this.talearntBoardRepository,
    this.keywordProvider,
    this.matchWriteProvider,
  );

  Future<void> getKeywords() async {
    final result = await talearntBoardRepository.getKeywords();
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (keywords) {
      GlobalValueConstants.keywordCategoris = keywords;
      keywordProvider.initTabController(keywords);
      matchWriteProvider.initTabController(keywords);
      commonNavigator.goRoute('/set-keyword');
    });
  }

  Future<void> setMyKeywords(
      List<int> giveTalent, List<int> interestTalent) async {
    MyTalentKeywordsParam param = MyTalentKeywordsParam(
        giveTalents: giveTalent, interestTalents: interestTalent);
    final result = await talentBoardRepository.setMyKeywords(param);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (result) {
      commonNavigator.goRoute('/set-keyword-success');
    });
  }
}
