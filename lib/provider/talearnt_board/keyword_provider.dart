import 'package:flutter/material.dart';

import '../../data/model/respone/keyword_category.dart';
import 'custom_ticker_provider.dart';

class KeywordProvider extends ChangeNotifier {
  int _setTalentPage = 0;
  final PageController _pageController = PageController();

  late TabController _keywordTabController;
  final CustomTickerProvider _tickerProvider;
  List<int> _giveTalentKeywordCodes = [];
  List<int> _selectedGiveTalentKeywordCodes = [];
  List<int> _interestTalentKeywordCodes = [];
  List<int> _selectedInterestTalentKeywordCodes = [];

  int get setTalentPage => _setTalentPage;

  PageController get pageController => _pageController;

  TabController get keywordTabController => _keywordTabController;

  List<int> get giveTalentKeywordCodes => _giveTalentKeywordCodes;

  List<int> get selectedGiveTalentKeywordCodes =>
      _selectedGiveTalentKeywordCodes;

  bool get isGiveTalentButtonEnabled => true;

  List<int> get interestTalentKeywordCodes => _interestTalentKeywordCodes;

  List<int> get selectedInterestTalentKeywordCodes =>
      _selectedInterestTalentKeywordCodes;

  KeywordProvider() : _tickerProvider = CustomTickerProvider() {
    _keywordTabController = TabController(length: 0, vsync: _tickerProvider);
  }

  void updatePage(int pageNum) {
    _setTalentPage = pageNum;
    notifyListeners(); // 상태 변경 통지
  }

  double getSignUpProgress() {
    return (_setTalentPage + 1) / 3;
  }

  void initTabController(List<KeywordCategory> keywordCategories) {
    _keywordTabController.dispose();
    _keywordTabController =
        TabController(length: keywordCategories.length, vsync: _tickerProvider);
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

  void setSelectedGiveTalentKeywordCodes() {
    _selectedGiveTalentKeywordCodes = _giveTalentKeywordCodes.toList();
    notifyListeners();
  }

  void updateSelectedGiveTalentKeywordCodes(List<int> keywordTalent) {
    _selectedGiveTalentKeywordCodes.clear();
    _selectedGiveTalentKeywordCodes.addAll(keywordTalent);
    notifyListeners();
  }

  void beforeSelectedGiveTalentKeywordCodes() {
    _giveTalentKeywordCodes = _selectedGiveTalentKeywordCodes.toList();
    notifyListeners();
  }

  void setSelectedInterestTalentKeywordCodes() {
    _selectedInterestTalentKeywordCodes = _interestTalentKeywordCodes.toList();
    notifyListeners();
  }

  void updateSelectedInterestTalentKeywordCodes(List<int> keywordTalent) {
    _selectedInterestTalentKeywordCodes.clear();
    _selectedInterestTalentKeywordCodes.addAll(keywordTalent);
    notifyListeners();
  }

  void beforeSelectedInterestTalentKeywordCodes() {
    _interestTalentKeywordCodes = _selectedInterestTalentKeywordCodes.toList();
    notifyListeners();
  }

  void reset() {
    _setTalentPage = 0;
    _pageController.initialPage;
    _tickerProvider.dispose();
    _giveTalentKeywordCodes = [];
    _interestTalentKeywordCodes = [];
  }

  @override
  void dispose() {
    _keywordTabController.dispose();
    _tickerProvider.dispose();
    super.dispose();
  }
}
