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

  Future<void> changeBestCommunityBoardLike(int postNo) async {
    final index = _bestCommunityPosts
        .indexWhere((post) => post.communityPostNo == postNo);
    if (index != -1) {
      _bestCommunityPosts[index].isLike = !_bestCommunityPosts[index].isLike;
      _bestCommunityPosts[index].isLike
          ? _bestCommunityPosts[index].likeCount =
              _bestCommunityPosts[index].likeCount + 1
          : _bestCommunityPosts[index].likeCount =
              _bestCommunityPosts[index].likeCount - 1;
    }
    notifyListeners();
  }

  Future<void> changeCommunityBoardLikeFromDetail(
      int postNo, bool isLike) async {
    final index = _bestCommunityPosts
        .indexWhere((post) => post.communityPostNo == postNo);
    if (index != -1) {
      _bestCommunityPosts[index].isLike = isLike;
      _bestCommunityPosts[index].isLike
          ? _bestCommunityPosts[index].likeCount =
              _bestCommunityPosts[index].likeCount + 1
          : _bestCommunityPosts[index].likeCount =
              _bestCommunityPosts[index].likeCount - 1;
    }
    notifyListeners();
  }

  Future<void> changeBothTalentBoardLikeFromDetail(
      int postNo, bool isLike) async {
    final indexOfUserMatching = _userMatchingTalentExchangePosts
        .indexWhere((post) => post.exchangePostNo == postNo);
    final indexOfNew = _newTalentExchangePosts
        .indexWhere((post) => post.exchangePostNo == postNo);
    if (indexOfNew != -1) {
      _newTalentExchangePosts[indexOfNew].isFavorite = isLike;
      _newTalentExchangePosts[indexOfNew].isFavorite
          ? _newTalentExchangePosts[indexOfNew].favoriteCount =
              _newTalentExchangePosts[indexOfNew].favoriteCount + 1
          : _newTalentExchangePosts[indexOfNew].favoriteCount =
              _newTalentExchangePosts[indexOfNew].favoriteCount - 1;
    }
    if (indexOfUserMatching != -1) {
      _userMatchingTalentExchangePosts[indexOfUserMatching].isFavorite = isLike;
      _userMatchingTalentExchangePosts[indexOfUserMatching].isFavorite
          ? _userMatchingTalentExchangePosts[indexOfUserMatching]
                  .favoriteCount =
              _userMatchingTalentExchangePosts[indexOfUserMatching]
                      .favoriteCount +
                  1
          : _userMatchingTalentExchangePosts[indexOfUserMatching]
                  .favoriteCount =
              _userMatchingTalentExchangePosts[indexOfUserMatching]
                      .favoriteCount -
                  1;
    }
    notifyListeners();
  }

  Future<void> changeBothTalentBoardLike(int postNo) async {
    final indexOfNew = _newTalentExchangePosts
        .indexWhere((post) => post.exchangePostNo == postNo);
    final indexOfUserMatching = _userMatchingTalentExchangePosts
        .indexWhere((post) => post.exchangePostNo == postNo);
    if (indexOfUserMatching != -1) {
      _userMatchingTalentExchangePosts[indexOfUserMatching].isFavorite =
          !_userMatchingTalentExchangePosts[indexOfUserMatching].isFavorite;
      _userMatchingTalentExchangePosts[indexOfUserMatching].isFavorite
          ? _userMatchingTalentExchangePosts[indexOfUserMatching]
                  .favoriteCount =
              _userMatchingTalentExchangePosts[indexOfUserMatching]
                      .favoriteCount +
                  1
          : _userMatchingTalentExchangePosts[indexOfUserMatching]
                  .favoriteCount =
              _userMatchingTalentExchangePosts[indexOfUserMatching]
                      .favoriteCount -
                  1;
    }
    if (indexOfNew != -1) {
      _newTalentExchangePosts[indexOfNew].isFavorite =
          !_newTalentExchangePosts[indexOfNew].isFavorite;
      _newTalentExchangePosts[indexOfNew].isFavorite
          ? _newTalentExchangePosts[indexOfNew].favoriteCount =
              _newTalentExchangePosts[indexOfNew].favoriteCount + 1
          : _newTalentExchangePosts[indexOfNew].favoriteCount =
              _newTalentExchangePosts[indexOfNew].favoriteCount - 1;
    }
    notifyListeners();
  }
}
