import 'package:app_front_talearnt/data/model/param/my_talent_keywords_param.dart';
import 'package:app_front_talearnt/data/repositories/keyword_repository.dart';
import 'package:app_front_talearnt/provider/board/match_board_provider.dart';
import 'package:app_front_talearnt/provider/board/match_edit_provider.dart';
import 'package:app_front_talearnt/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';

import '../common/common_navigator.dart';
import '../provider/board/match_write_provider.dart';
import '../provider/keyword/keyword_provider.dart';
import '../utils/error_message.dart';

class KeywordViewModel extends ChangeNotifier {
  final CommonNavigator commonNavigator;
  final KeywordRepository keywordRepository;
  final KeywordProvider keywordProvider;
  final MatchWriteProvider matchWriteProvider;
  final MatchBoardProvider talentBoardProvider;
  final MatchEditProvider matchEditProvider;
  final ProfileViewModel profileViewModel;

  KeywordViewModel(
    this.commonNavigator,
    this.keywordRepository,
    this.keywordProvider,
    this.matchWriteProvider,
    this.talentBoardProvider,
    this.matchEditProvider,
    this.profileViewModel,
  );

  // Future<void> getKeywords() async {
  //   final result = await talentBoardRepository.getKeywords();
  //   result.fold(
  //       (failure) => commonNavigator.showSingleDialog(
  //           content: ErrorMessages.getMessage(failure.errorCode)), (keywords) {
  //     GlobalValueConstants.keywordCategoris = keywords;
  //     keywordProvider.initTabController(keywords);
  //     matchWriteProvider.initTabController(keywords);
  //     commonNavigator.goRoute('/set-keyword');
  //   });
  // }

  Future<void> setMyKeywords(
      List<int> giveTalent, List<int> interestTalent) async {
    MyTalentKeywordsParam param = MyTalentKeywordsParam(
        giveTalents: giveTalent, interestTalents: interestTalent);
    final result = await keywordRepository.setMyKeywords(param);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)),
        (result) async {
      await profileViewModel.getUserProfile("keyword");
      commonNavigator.goRoute('/set-keyword-success');
    });
  }

  Future<void> getOfferedKeywords() async {
    final result = await keywordRepository.getOfferedKeywords();
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (response) {
      matchEditProvider.setGiveTalentKeyword(response);
    });
  }
}
