import 'package:flutter/material.dart';

import '../../constants/global_value_constants.dart';
import '../../data/model/respone/pagination.dart';
import '../../data/model/respone/talent_exchange_post.dart';
import '../common/custom_ticker_provider.dart';

class TalentBoardProvider extends ChangeNotifier {
  TalentBoardProvider() : _tickerProvider = CustomTickerProvider() {
    _giveTalentTabController = TabController(
        length: GlobalValueConstants.keywordCategoris.length,
        vsync: _tickerProvider);
    _interestTalentTabController = TabController(
        length: GlobalValueConstants.keywordCategoris.length,
        vsync: _tickerProvider);
  }

  late TabController _giveTalentTabController;
  late TabController _interestTalentTabController;
  final CustomTickerProvider _tickerProvider;
  String _selectedOrderType = 'recent';
  String _selectedDurationType = '';
  String _selectedOperationType = '';
  final List<int> _giveTalentKeywordCodes = [];
  final List<int> _selectedGiveTalentKeywordCodes = [];
  final List<int> _interestTalentKeywordCodes = [];
  final List<int> _selectedInterestTalentKeywordCodes = [];

  TabController get giveTalentTabController => _giveTalentTabController;

  TabController get interestTalentTabController => _interestTalentTabController;

  String get selectedOrderType => _selectedOrderType;

  String get selectedDurationType => _selectedDurationType;

  String get selectedOperationType => _selectedOperationType;

  List<int> get giveTalentKeywordCodes => _giveTalentKeywordCodes;

  List<int> get selectedGiveTalentKeywordCodes =>
      _selectedGiveTalentKeywordCodes;

  List<int> get interestTalentKeywordCodes => _interestTalentKeywordCodes;

  List<int> get selectedInterestTalentKeywordCodes =>
      _selectedInterestTalentKeywordCodes;

  final List<TalentExchangePost> talentExchangePosts = [
    TalentExchangePost(
      profileImg: "유저 이미지",
      nickname: "테스트",
      authority: "ROLE_USER",
      exchangePostNo: 7,
      status: "모집중",
      exchangeType: "오프라인",
      duration: "3개월",
      requiredBadge: true,
      title: "일곱 번째 게시글 타이틀 입니다.",
      content: "일곱 번째 글은 엔터키가 없고 HTML 태그만 있는 겁니다.",
      giveTalents: ["방송댄스", "힙합.스트릿댄스"],
      receiveTalents: ["일식 조리"],
      createdAt: DateTime.parse("2024-12-29T20:38:09.267246"),
      count: 1,
      favoriteCount: 0,
      pagination: Pagination(
        hasNext: false,
        hasPrevious: false,
        totalPages: 1,
        currentPage: 1,
      ),
    ),
    TalentExchangePost(
      profileImg: "유저 이미지",
      nickname: "테스트",
      authority: "ROLE_USER",
      exchangePostNo: 6,
      status: "모집중",
      exchangeType: "오프라인",
      duration: "3개월",
      requiredBadge: true,
      title: "여섯 번째 게시글 타이틀 입니다.",
      content:
          "여섯 번째 게시글 아,맞아 HTML 태그도 있다고 가정하고 이걸 제거하는 방법도 체택해야하고 글자수 20글자까지만 보여준다음에 ... 을 추가해주는 마법을 부려야하는데 HTML 코...",
      giveTalents: ["부동산 투자", "영유아 발달", "홍보 글쓰기"],
      receiveTalents: ["메이크업", "콘텐츠 마케팅"],
      createdAt: DateTime.parse("2024-12-29T20:38:09.267246"),
      count: 1,
      favoriteCount: 0,
      pagination: Pagination(
        hasNext: false,
        hasPrevious: false,
        totalPages: 1,
        currentPage: 1,
      ),
    ),
    TalentExchangePost(
      profileImg: "유저 이미지",
      nickname: "테스트",
      authority: "ROLE_USER",
      exchangePostNo: 5,
      status: "모집중",
      exchangeType: "오프라인",
      duration: "3개월",
      requiredBadge: true,
      title: "다섯 번째 게시글 타이틀 입니다.",
      content:
          "다섯 번째 게시글은 아주 중요한게 떠올랐는데 와 이걸 까먹었네 뇌정지가 씨게 와서 이제는 아무것도 할 수 없는 뇌가 되어버려~ 좌뇌...(자네...)우뇌....?(우네...?)",
      giveTalents: ["드로잉"],
      receiveTalents: ["드론 촬영", "사진 촬영", "영상 편집"],
      createdAt: DateTime.parse("2024-12-29T20:38:09.267246"),
      count: 1,
      favoriteCount: 0,
      pagination: Pagination(
        hasNext: false,
        hasPrevious: false,
        totalPages: 1,
        currentPage: 1,
      ),
    ),
  ];

  void updateOrderType(String newType) {
    _selectedOrderType = newType;
    notifyListeners();
  }

  void updateDurationType(String newType) {
    _selectedDurationType = newType;
    notifyListeners();
  }

  void updateOperationType(String newType) {
    _selectedOperationType = newType;
    notifyListeners();
  }

  void updateGiveKeywordList(List<int> keywordTalent) {
    _giveTalentKeywordCodes.clear();
    _giveTalentKeywordCodes.addAll(keywordTalent);
    notifyListeners();
  }

  void removeGiveKeywordList(int keywordTalent) {
    _giveTalentKeywordCodes.remove(keywordTalent);
    notifyListeners();
  }

  void updateInterestKeywordList(List<int> keywordTalent) {
    _interestTalentKeywordCodes.clear();
    _interestTalentKeywordCodes.addAll(keywordTalent);
    notifyListeners();
  }

  void removeInterestKeywordList(int keywordTalent) {
    _interestTalentKeywordCodes.remove(keywordTalent);
    notifyListeners();
  }

  void resetInterestKeywordList() {
    _interestTalentKeywordCodes.clear();
    notifyListeners();
  }

  void resetGiveKeywordList() {
    _giveTalentKeywordCodes.clear();
    notifyListeners();
  }

  void registerInterestKeywordList() {
    _selectedInterestTalentKeywordCodes.clear();
    _selectedInterestTalentKeywordCodes.addAll(_interestTalentKeywordCodes);
    notifyListeners();
  }

  void registerGiveKeywordList() {
    _selectedGiveTalentKeywordCodes.clear();
    _selectedGiveTalentKeywordCodes.addAll(_giveTalentKeywordCodes);
    notifyListeners();
  }

  void matchInterestKeywordList() {
    _interestTalentKeywordCodes.clear();
    _interestTalentKeywordCodes.addAll(_selectedInterestTalentKeywordCodes);
    notifyListeners();
  }

  void matchGiveKeywordList() {
    _giveTalentKeywordCodes.clear();
    _giveTalentKeywordCodes.addAll(_selectedGiveTalentKeywordCodes);
    notifyListeners();
  }
}
