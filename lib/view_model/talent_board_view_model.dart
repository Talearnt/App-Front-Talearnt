import 'package:app_front_talearnt/data/model/param/my_talent_keywords_param.dart';
import 'package:app_front_talearnt/provider/talent_board/talent_board_provider.dart';
import 'package:flutter/material.dart';

import '../common/common_navigator.dart';
import '../data/model/param/talent_exchange_posts_filter_param';
import '../data/repositories/talent_board_repository.dart';
import '../provider/talent_board/keyword_provider.dart';
import '../provider/talent_board/match_write_provider.dart';
import '../utils/error_message.dart';

class TalentBoardViewModel extends ChangeNotifier {
  final CommonNavigator commonNavigator;
  final TalentBoardRepository talentBoardRepository;
  final KeywordProvider keywordProvider;
  final MatchWriteProvider matchWriteProvider;
  final TalentBoardProvider talentBoardProvider;

  TalentBoardViewModel(
    this.commonNavigator,
    this.talentBoardRepository,
    this.keywordProvider,
    this.matchWriteProvider,
    this.talentBoardProvider,
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
    final result = await talentBoardRepository.setMyKeywords(param);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (result) {
      commonNavigator.goRoute('/set-keyword-success');
    });
  }

  Future<void> getInitTalentExchangePosts() async {
    TalentExchangePostsFilterParam param =
        TalentExchangePostsFilterParam.empty();
    final result = await talentBoardRepository.getTalentExchangePosts(param);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (result) {
      final posts = result['posts'];
      final pagination = result['pagination'];
      talentBoardProvider.initTalentExchangePosts(posts);
      talentBoardProvider.updateTalentExchangePostsPage(pagination);
      commonNavigator.goRoute('/match-board-list');
    });
  }

  Future<void> getTalentExchangePosts(
      List<String>? giveTalents,
      List<String>? receiveTalents,
      String? order,
      String? duration,
      String? type,
      String? badge,
      String? status,
      String? page,
      String? size,
      String? search) async {
    TalentExchangePostsFilterParam param = TalentExchangePostsFilterParam(
        giveTalents: giveTalents,
        receiveTalents: receiveTalents,
        order: order,
        duration: duration,
        type: type,
        badge: badge,
        status: status,
        page: page,
        size: size,
        search: search);
    final result = await talentBoardRepository.getTalentExchangePosts(param);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (result) {
      final posts = result['posts'];
      final pagination = result['pagination'];
      talentBoardProvider.updateTalentExchangePosts(posts);
      talentBoardProvider.updateTalentExchangePostsPage(pagination);
    });
  }
}
