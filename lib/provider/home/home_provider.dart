import 'package:app_front_talearnt/data/model/respone/community_board.dart';
import 'package:app_front_talearnt/data/model/respone/match_board.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider();

  final List<MatchBoard> _newTalentExchangePosts = [];
  final List<CommunityBoard> _bestCommunityPosts = [];
  final List<MatchBoard> _userMatchingTalentExchangePosts = [];

  List<MatchBoard> get newTalentExchangePosts => _newTalentExchangePosts;

  List<CommunityBoard> get bestCommunityPosts => _bestCommunityPosts;

  List<MatchBoard> get userMatchingTalentExchangePosts =>
      _userMatchingTalentExchangePosts;

  void clearProvider() {
    _newTalentExchangePosts.clear();
    _bestCommunityPosts.clear();
    _userMatchingTalentExchangePosts.clear();
  }

  void setNewTalentExchangePosts(List<MatchBoard> addTalentExchangePosts) {
    _newTalentExchangePosts.clear();
    _newTalentExchangePosts.addAll(addTalentExchangePosts);

    notifyListeners();
  }

  void setBestCommunityBoardList(List<CommunityBoard> addCommunityBoards) {
    _bestCommunityPosts.clear();
    _bestCommunityPosts.addAll(addCommunityBoards);

    notifyListeners();
  }

  void setUserMatchingTalentExchangePosts(
      List<MatchBoard> addTalentExchangePosts) {
    _userMatchingTalentExchangePosts.clear();
    _userMatchingTalentExchangePosts.addAll(addTalentExchangePosts);

    notifyListeners();
  }
}
