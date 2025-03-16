import 'package:app_front_talearnt/data/model/respone/community_board.dart';
import 'package:app_front_talearnt/data/model/respone/matching_post.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider();

  final List<MatchingPost> _newTalentExchangePosts = [];
  final List<CommunityBoard> _bestCommunityPosts = [];
  final List<MatchingPost> _userMatchingTalentExchangePosts = [];

  List<MatchingPost> get newTalentExchangePosts => _newTalentExchangePosts;
  List<CommunityBoard> get bestCommunityPosts => _bestCommunityPosts;
  List<MatchingPost> get userMatchingTalentExchangePosts =>
      _userMatchingTalentExchangePosts;

  void setNewTalentExchangePosts(List<MatchingPost> addTalentExchangePosts) {
    _newTalentExchangePosts.clear();
    _newTalentExchangePosts.addAll(addTalentExchangePosts);

    notifyListeners();
  }

  void setBestCommunityBoardList(List<CommunityBoard> addCommunityBoards) {
    _bestCommunityPosts.clear();
    _bestCommunityPosts.addAll(addCommunityBoards);

    notifyListeners();
  }
}
