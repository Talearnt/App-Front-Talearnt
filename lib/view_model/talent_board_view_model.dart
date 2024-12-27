import 'package:flutter/material.dart';

import '../common/common_navigator.dart';
import '../constants/global_value_constants.dart';
import '../data/model/param/my_talent_keywords_param.dart';
import '../data/repositories/talent_board_repository.dart';
import '../provider/talearnt_board/keyword_provider.dart';
import '../utils/error_message.dart';

class TalentBoardViewModel extends ChangeNotifier {
  final CommonNavigator commonNavigator;
  final TalentBoardRepository talentBoardRepository;
  final KeywordProvider keywordProvider;

  TalentBoardViewModel(
    this.commonNavigator,
    this.talentBoardRepository,
    this.keywordProvider,
  );

  Future<void> getKeywords() async {
    final result = await talentBoardRepository.getKeywords();
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (keywords) {
      GlobalValueConstants.keywordCategoris = keywords;
      keywordProvider.initTabController(keywords);
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
