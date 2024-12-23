import 'package:flutter/material.dart';

import '../../data/model/respone/keyword_category.dart';
import 'custom_ticker_provider.dart';

class KeywordProvider extends ChangeNotifier {
  KeywordProvider() : _tickerProvider = CustomTickerProvider() {
    _giveTalentTabController = TabController(length: 0, vsync: _tickerProvider);
    _interestTalentTabController =
        TabController(length: 0, vsync: _tickerProvider);
    _giveTalentFocusNode.addListener(_onChanged);
    _interestTalentFocusNode.addListener(_onChanged);
    _giveTalentSearchController.addListener(_onChanged);
    _interestTalentSearchController.addListener(_onChanged);
  }

  int _setTalentPage = 0;
  final PageController _pageController = PageController();

  late TabController _giveTalentTabController;
  late TabController _interestTalentTabController;
  final CustomTickerProvider _tickerProvider;
  List<int> _giveTalentKeywordCodes = []; //처음 선택되는 keyword
  List<int> _selectedGiveTalentKeywordCodes = []; // 키워드 확인 화면에서 사용되는 keyword
  List<int> _searchedGiveTalentKeywordCodes = []; // 검색용 keyword
  List<int> _interestTalentKeywordCodes = [];
  List<int> _selectedInterestTalentKeywordCodes = [];
  List<int> _searchedInterestTalentKeywordCodes = [];
  final FocusNode _giveTalentFocusNode = FocusNode();
  final FocusNode _interestTalentFocusNode = FocusNode();

  final TextEditingController _giveTalentSearchController =
      TextEditingController();
  final TextEditingController _interestTalentSearchController =
      TextEditingController();

  int get setTalentPage => _setTalentPage;

  PageController get pageController => _pageController;

  TabController get giveTalentTabController => _giveTalentTabController;

  TabController get interestTalentTabController => _interestTalentTabController;

  List<int> get giveTalentKeywordCodes => _giveTalentKeywordCodes;

  List<int> get selectedGiveTalentKeywordCodes =>
      _selectedGiveTalentKeywordCodes;

  List<int> get searchedGiveTalentKeywordCodes =>
      _searchedGiveTalentKeywordCodes;

  bool get isGiveTalentButtonEnabled => giveTalentKeywordCodes.isNotEmpty;

  List<int> get interestTalentKeywordCodes => _interestTalentKeywordCodes;

  List<int> get selectedInterestTalentKeywordCodes =>
      _selectedInterestTalentKeywordCodes;

  List<int> get searchedInterestTalentKeywordCodes =>
      _searchedInterestTalentKeywordCodes;

  bool get isInterestTalentButtonEnabled =>
      interestTalentKeywordCodes.isNotEmpty;

  FocusNode get giveTalentFocusNode => _giveTalentFocusNode;

  FocusNode get interestTalentFocusNode => _interestTalentFocusNode;

  TextEditingController get giveTalentSearchController =>
      _giveTalentSearchController;

  TextEditingController get interestTalentSearchController =>
      _interestTalentSearchController;

  bool get isGiveTalentSearch => _giveTalentSearchController.text.isNotEmpty;

  bool get isInterestTalentSearch =>
      _interestTalentSearchController.text.isNotEmpty;

  bool get isConfirmButtonEnabled =>
      _selectedGiveTalentKeywordCodes.isNotEmpty &&
      _selectedInterestTalentKeywordCodes.isNotEmpty;

  void _onChanged() {
    notifyListeners(); // Focus 상태 변경 시 UI 갱신
  }

  void updateSearchGiveTalent(List<int> searchedGiveTalent) {
    _searchedGiveTalentKeywordCodes.clear();
    if (searchedGiveTalent.isNotEmpty) {
      _searchedGiveTalentKeywordCodes.addAll(searchedGiveTalent);
    }
  }

  void updateSearchInterestTalent(List<int> searchedGiveTalent) {
    _searchedInterestTalentKeywordCodes.clear();
    if (searchedGiveTalent.isNotEmpty) {
      _searchedInterestTalentKeywordCodes.addAll(searchedGiveTalent);
    }
  }

  void updatePage(int pageNum) {
    _setTalentPage = pageNum;
    notifyListeners(); // 상태 변경 통지
  }

  double getSignUpProgress() {
    return (_setTalentPage + 1) / 3;
  }

  void initTabController(List<KeywordCategory> keywordCategories) {
    _giveTalentTabController.dispose();
    _interestTalentTabController.dispose();
    _giveTalentTabController =
        TabController(length: keywordCategories.length, vsync: _tickerProvider);
    _interestTalentTabController =
        TabController(length: keywordCategories.length, vsync: _tickerProvider);
    notifyListeners();
  }

  void resetGiveTabIndex() {
    _giveTalentTabController.index = 0;
    notifyListeners();
  }

  void resetInterestTabIndex() {
    _interestTalentTabController.index = 0;
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

  void updateSelectedGiveTalentKeywordCodes(List<int> keywordTalent) {
    _selectedGiveTalentKeywordCodes.clear();
    if (keywordTalent.isNotEmpty) {
      _selectedGiveTalentKeywordCodes.addAll(keywordTalent);
    }
    notifyListeners();
  }

  void beforeSelectedGiveTalentKeywordCodes() {
    _giveTalentKeywordCodes = _selectedGiveTalentKeywordCodes.toList();
    notifyListeners();
  }

  void updateSelectedInterestTalentKeywordCodes(List<int> keywordTalent) {
    _selectedInterestTalentKeywordCodes.clear();
    if (keywordTalent.isNotEmpty) {
      _selectedInterestTalentKeywordCodes.addAll(keywordTalent);
    }
    notifyListeners();
  }

  void beforeSelectedInterestTalentKeywordCodes() {
    _interestTalentKeywordCodes = _selectedInterestTalentKeywordCodes.toList();
    notifyListeners();
  }

  void updateSelectedSearchGiveTalentKeywordCodes(
      int index, List<int> keywordTalent) {
    _giveTalentKeywordCodes.clear();
    _giveTalentKeywordCodes.addAll(keywordTalent);
    _giveTalentSearchController.clear();
    _giveTalentTabController.index = index;
    notifyListeners();
  }

  void updateSelectedSearchInterestTalentKeywordCodes(
      int index, List<int> keywordTalent) {
    _interestTalentKeywordCodes.clear();
    _interestTalentKeywordCodes.addAll(keywordTalent);
    _interestTalentSearchController.clear();
    _interestTalentTabController.index = index;
    notifyListeners();
  }

  void reset() {
    _setTalentPage = 0;
    _pageController.initialPage;
    _tickerProvider.dispose();
    _giveTalentTabController.index = 0;
    _interestTalentTabController.index = 0;
    _giveTalentKeywordCodes = [];
    _interestTalentKeywordCodes = [];
    _selectedGiveTalentKeywordCodes = [];
    _searchedGiveTalentKeywordCodes = [];
    _selectedInterestTalentKeywordCodes = [];
    _searchedInterestTalentKeywordCodes = [];
    _giveTalentFocusNode.unfocus();
    _interestTalentFocusNode.unfocus();
    _giveTalentSearchController.clear();
    _interestTalentSearchController.clear();
  }

  @override
  void dispose() {
    _giveTalentTabController.dispose();
    _interestTalentTabController.dispose();
    _tickerProvider.dispose();
    super.dispose();
  }
}
