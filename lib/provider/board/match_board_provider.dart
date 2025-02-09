import 'package:app_front_talearnt/data/model/respone/pagination.dart';
import 'package:flutter/material.dart';

import '../../constants/global_value_constants.dart';
import '../../data/model/respone/matching_post.dart';
import '../../view_model/board_view_model.dart';
import '../common/custom_ticker_provider.dart';

class MatchBoardProvider extends ChangeNotifier {
  MatchBoardProvider() : _tickerProvider = CustomTickerProvider() {
    _giveTalentTabController = TabController(
        length: GlobalValueConstants.keywordCategoris.length,
        vsync: _tickerProvider);
    _interestTalentTabController = TabController(
        length: GlobalValueConstants.keywordCategoris.length,
        vsync: _tickerProvider);
    _scrollController.addListener(_onScroll);
  }

  bool _isFetching = false;
  late TabController _giveTalentTabController;
  late TabController _interestTalentTabController;
  final CustomTickerProvider _tickerProvider;
  String _selectedOrderType = 'recent';
  String _selectedDurationType = '';
  String _selectedOperationType = '';
  final List<int> _giveTalentKeywordCodes = [];
  final List<int> _selectedGiveTalentKeywordCodes = []; //실제로 넘기는 값
  final List<int> _interestTalentKeywordCodes = [];
  final List<int> _selectedInterestTalentKeywordCodes = []; //실제로 넘기는 값
  final List<MatchingPost> _talentExchangePosts = [];
  Pagination _talentPage = Pagination.empty();
  final ScrollController _scrollController = ScrollController();
  late BoardViewModel _viewModel;

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

  List<MatchingPost> get talentExchangePosts => _talentExchangePosts;

  Pagination get talentPage => _talentPage;

  ScrollController get scrollController => _scrollController;

  void setViewModel(BoardViewModel viewModel) {
    _viewModel = viewModel;
  }

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

  void addTalentExchangePosts(List<MatchingPost> addTalentExchangePosts) {
    _talentExchangePosts.addAll(addTalentExchangePosts);
    notifyListeners();
  }

  void updateTalentExchangePosts(
      List<MatchingPost> addTalentExchangePosts) {
    _talentExchangePosts.clear();
    _talentExchangePosts.addAll(addTalentExchangePosts);
    notifyListeners();
  }

  void updateTalentExchangePostsPage(Pagination paging) {
    _talentPage = paging;
    notifyListeners();
  }

  void _onScroll() {
    if (!_isFetching &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
      _fetchMoreData();
    }
  }

  Future<void> _fetchMoreData() async {
    _isFetching = true;
    await _viewModel.addTalentExchangePosts(
        selectedGiveTalentKeywordCodes.map((e) => e.toString()).toList(),
        selectedInterestTalentKeywordCodes.map((e) => e.toString()).toList(),
        selectedOrderType,
        selectedDurationType,
        selectedOperationType,
        null,
        null,
        (_talentPage.currentPage + 1).toString(),
        null,
        null);
    _isFetching = false;
  }
}
