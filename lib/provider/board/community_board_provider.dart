import 'package:app_front_talearnt/data/model/respone/pagination.dart';
import 'package:flutter/material.dart';

import '../../constants/global_value_constants.dart';
import '../../data/model/respone/community_post.dart';
import '../common/custom_ticker_provider.dart';

class CommunityBoardProvider extends ChangeNotifier {
  CommunityBoardProvider() : _tickerProvider = CustomTickerProvider() {
    _communityTabController = TabController(
        length: GlobalValueConstants.communityCategoryTypes.length,
        vsync: _tickerProvider);
    //_scrollController.addListener(_onScroll);
  }

  //bool _isFetching = false;
  String _selectedOrderType = 'recent';
  Pagination _talentPage = Pagination.empty();
  final ScrollController _scrollController = ScrollController();
  late TabController _communityTabController;
  final CustomTickerProvider _tickerProvider;
  final List<CommunityPost> _communityPosts = [
    CommunityPost(
        category: "질문 게시판",
        profileImg: "유저 이미지",
        nickname: "테스트",
        authority: "ROLE_USER",
        exchangePostNo: 7,
        title: "일곱 번째 게시글 타이틀 입니다.",
        content: "일곱 번째 글은 엔터키가 없고 HTML 태그만 있는 겁니다.",
        createdAt: "2024-12-29T20:38:09.267246",
        favoriteCount: 0,
        isFavorite: false),
    CommunityPost(
        category: "질문 게시판",
        profileImg: "유저 이미지",
        nickname: "테스트",
        authority: "ROLE_USER",
        exchangePostNo: 7,
        title: "일곱 번째 게시글 타이틀 입니다.",
        content: "일곱 번째 글은 엔터키가 없고 HTML 태그만 있는 겁니다.",
        createdAt: "2024-12-29T20:38:09.267246",
        favoriteCount: 0,
        isFavorite: false),
    CommunityPost(
        category: "질문 게시판",
        profileImg: "유저 이미지",
        nickname: "테스트",
        authority: "ROLE_USER",
        exchangePostNo: 7,
        title: "일곱 번째 게시글 타이틀 입니다.",
        content: "일곱 번째 글은 엔터키가 없고 HTML 태그만 있는 겁니다.",
        createdAt: "2024-12-29T20:38:09.267246",
        favoriteCount: 0,
        isFavorite: false),
    CommunityPost(
        category: "질문 게시판",
        profileImg: "유저 이미지",
        nickname: "테스트",
        authority: "ROLE_USER",
        exchangePostNo: 7,
        title: "일곱 번째 게시글 타이틀 입니다.",
        content: "일곱 번째 글은 엔터키가 없고 HTML 태그만 있는 겁니다.",
        createdAt: "2024-12-29T20:38:09.267246",
        favoriteCount: 0,
        isFavorite: false),
    CommunityPost(
        category: "질문 게시판",
        profileImg: "유저 이미지",
        nickname: "테스트",
        authority: "ROLE_USER",
        exchangePostNo: 7,
        title: "일곱 번째 게시글 타이틀 입니다.",
        content: "일곱 번째 글은 엔터키가 없고 HTML 태그만 있는 겁니다.",
        createdAt: "2024-12-29T20:38:09.267246",
        favoriteCount: 0,
        isFavorite: false),
    CommunityPost(
        category: "질문 게시판",
        profileImg: "유저 이미지",
        nickname: "테스트",
        authority: "ROLE_USER",
        exchangePostNo: 7,
        title: "일곱 번째 게시글 타이틀 입니다.",
        content: "일곱 번째 글은 엔터키가 없고 HTML 태그만 있는 겁니다.",
        createdAt: "2024-12-29T20:38:09.267246",
        favoriteCount: 0,
        isFavorite: false),
  ];

  // late BoardViewModel _viewModel;

  String get selectedOrderType => _selectedOrderType;

  List<CommunityPost> get communityPosts => _communityPosts;

  Pagination get talentPage => _talentPage;

  ScrollController get scrollController => _scrollController;

  TabController get communityTabController => _communityTabController;

  // void setViewModel(BoardViewModel viewModel) {
  //   _viewModel = viewModel;
  // }

  void updateOrderType(String newType) {
    _selectedOrderType = newType;
    notifyListeners();
  }

  void addCommunityPosts(List<CommunityPost> addCommunityPosts) {
    _communityPosts.addAll(addCommunityPosts);
    notifyListeners();
  }

  void updateCommunityPosts(List<CommunityPost> addCommunityPosts) {
    _communityPosts.clear();
    _communityPosts.addAll(addCommunityPosts);
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
    notifyListeners();
  }

  void updateCommunityPostsPage(Pagination paging) {
    _talentPage = paging;
    notifyListeners();
  }

  void resetFilter() {
    _selectedOrderType = 'recent';
    notifyListeners();
  }

//api 생성 후 처리
// void _onScroll() {
//   if (!_isFetching &&
//       _scrollController.position.pixels >=
//           _scrollController.position.maxScrollExtent - 200) {
//     _fetchMoreData();
//   }
// }

// Future<void> _fetchMoreData() async {
//   _isFetching = true;
//   await _viewModel.addCommunityPosts(
//       selectedOrderType,
//       null,
//       null,
//       (_talentPage.currentPage + 1).toString(),
//       null,
//       null);
//   _isFetching = false;
// }
}
