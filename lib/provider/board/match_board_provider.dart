import 'package:app_front_talearnt/data/model/respone/pagination.dart';
import 'package:flutter/material.dart';

import '../../constants/global_value_constants.dart';
import '../../data/model/respone/match_board.dart';
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
  final List<MatchBoard> _matchBoardList = [];
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

  List<MatchBoard> get matchBoardList => _matchBoardList;

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

  void addTalentExchangePosts(List<MatchBoard> addTalentExchangePosts) {
    _matchBoardList.addAll(addTalentExchangePosts);
    notifyListeners();
  }

  void updateTalentExchangePosts(List<MatchBoard> addTalentExchangePosts) {
    _matchBoardList.clear();
    _matchBoardList.addAll(addTalentExchangePosts);
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
    notifyListeners();
  }

  void updateTalentExchangePostsPage(Pagination paging) {
    _talentPage = paging;
    notifyListeners();
  }

  void resetFilter() {
    _selectedOrderType = 'recent';
    _selectedDurationType = '';
    _selectedOperationType = '';
    _giveTalentKeywordCodes.clear();
    _selectedGiveTalentKeywordCodes.clear(); //실제로 넘기는 값
    _interestTalentKeywordCodes.clear();
    _selectedInterestTalentKeywordCodes.clear(); //실제로 넘기는 값
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
    await _viewModel.getMatchBoardList(
        selectedGiveTalentKeywordCodes.map((e) => e.toString()).toList(),
        selectedInterestTalentKeywordCodes.map((e) => e.toString()).toList(),
        selectedOrderType,
        selectedDurationType,
        selectedOperationType,
        null,
        null,
        null,
        null,
        _matchBoardList.last.exchangePostNo.toString(),
        "add");
    _isFetching = false;
    notifyListeners();
  }

  void setSelectedInterestTalentKeyword(list) {
    selectedInterestTalentKeywordCodes.clear();
    selectedInterestTalentKeywordCodes.addAll(list);

    notifyListeners();
  }
}
