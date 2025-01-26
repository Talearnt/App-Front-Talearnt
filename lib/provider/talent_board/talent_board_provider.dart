import 'package:app_front_talearnt/data/model/respone/pagination.dart';
import 'package:flutter/material.dart';

import '../../constants/global_value_constants.dart';
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
  final List<TalentExchangePost> _talentExchangePosts = [];
  Pagination _talentPage = Pagination.empty();

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

  List<TalentExchangePost> get talentExchangePosts => _talentExchangePosts;

  Pagination get talentPage => _talentPage;

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

  void updateTalentExchangePosts(
      List<TalentExchangePost> addTalentExchangePosts) {
    _talentExchangePosts.addAll(addTalentExchangePosts);
    notifyListeners();
  }

  void updateTalentExchangePostsPage(Pagination paging) {
    _talentPage = paging;
    notifyListeners();
  }
}
