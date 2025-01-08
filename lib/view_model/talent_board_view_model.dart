import 'dart:io';

import 'package:app_front_talearnt/data/model/param/my_talent_keywords_param.dart';
import 'package:app_front_talearnt/data/model/param/s3_controller_param.dart';
import 'package:flutter/material.dart';

import '../common/common_navigator.dart';
import '../constants/global_value_constants.dart';
import '../data/repositories/talent_board_repository.dart';
import '../provider/talent_board/keyword_provider.dart';
import '../provider/talent_board/match_write_provider.dart';
import '../utils/error_message.dart';

class TalentBoardViewModel extends ChangeNotifier {
  final CommonNavigator commonNavigator;
  final TalentBoardRepository talentBoardRepository;
  final KeywordProvider keywordProvider;
  final MatchWriteProvider matchWriteProvider;

  TalentBoardViewModel(
    this.commonNavigator,
    this.talentBoardRepository,
    this.keywordProvider,
    this.matchWriteProvider,
  );

  Future<void> getKeywords() async {
    final result = await talentBoardRepository.getKeywords();
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

  Future<void> getImageUploadUrl(List<S3FileParam> uploadImageInfos) async {
    S3ControllerParam param = S3ControllerParam(files: uploadImageInfos);

    final result = await talentBoardRepository.getImageUploadUrl(param);

    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (result) {
      matchWriteProvider.setImageUploadUrl(result.data);
      matchWriteProvider.viewUploadImges();
    });
  }
}
