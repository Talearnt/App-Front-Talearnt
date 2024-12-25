import 'package:app_front_talearnt/data/model/respone/keyword_category.dart';
import 'package:app_front_talearnt/provider/talearnt_board/custom_ticker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../clear_text.dart';

class MatchWriteProvider extends ChangeNotifier with ClearText {
  MatchWriteProvider() : _tickerProvider = CustomTickerProvider() {
    _giveTalentTabController = TabController(length: 0, vsync: _tickerProvider);
    _interestTalentTabController =
        TabController(length: 0, vsync: _tickerProvider);
    _giveTalentFocusNode.addListener(_onChanged);
    _interestTalentFocusNode.addListener(_onChanged);
    _contentController.addListener(_onChanged);
  }

  final TextEditingController _titlerController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();

  final QuillController _contentController = QuillController.basic();
  final FocusNode _contentFocusNode = FocusNode();

  late TabController _giveTalentTabController;
  late TabController _interestTalentTabController;
  final CustomTickerProvider _tickerProvider;
  final List<int> _giveTalentKeywordCodes = []; //처음 선택되는 keyword
  final List<int> _selectedGiveTalentKeywordCodes =
      []; // 키워드 확인 화면에서 사용되는 keyword
  final List<int> _searchedGiveTalentKeywordCodes = []; // 검색용 keyword
  final List<int> _interestTalentKeywordCodes = [];
  final List<int> _selectedInterestTalentKeywordCodes = [];
  final List<int> _searchedInterestTalentKeywordCodes = [];
  final FocusNode _giveTalentFocusNode = FocusNode();
  final FocusNode _interestTalentFocusNode = FocusNode();

  TextEditingController get titlerController => _titlerController;
  QuillController get contentController => _contentController;

  FocusNode get titleFocusNode => _titleFocusNode;
  FocusNode get contentFocusNode => _contentFocusNode;

  bool _onToolBar = false;

  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderline = false;

  bool get onToolBar => _onToolBar;

  bool get isBold => _isBold;
  bool get isItalic => _isItalic;
  bool get isUnderline => _isUnderline;

  TabController get giveTalentTabController => _giveTalentTabController;
  TabController get interestTalentTabController => _interestTalentTabController;
  List<int> get giveTalentKeywordCodes => _giveTalentKeywordCodes;
  List<int> get selectedGiveTalentKeywordCodes =>
      _selectedGiveTalentKeywordCodes;
  List<int> get searchedGiveTalentKeywordCodes =>
      _searchedGiveTalentKeywordCodes;
  List<int> get interestTalentKeywordCodes => _interestTalentKeywordCodes;
  List<int> get selectedInterestTalentKeywordCodes =>
      _selectedInterestTalentKeywordCodes;
  List<int> get searchedInterestTalentKeywordCodes =>
      _searchedInterestTalentKeywordCodes;

  void initTabController(List<KeywordCategory> keywordCategories) {
    _giveTalentTabController.dispose();
    _interestTalentTabController.dispose();
    _giveTalentTabController =
        TabController(length: keywordCategories.length, vsync: _tickerProvider);
    _interestTalentTabController =
        TabController(length: keywordCategories.length, vsync: _tickerProvider);
    notifyListeners();
  }

  void _onChanged() {
    notifyListeners(); // Focus 상태 변경 시 UI 갱신
  }

  void clearProvider() {
    _titlerController.clear();
    _contentController.clear();

    _titleFocusNode.unfocus();
    _contentFocusNode.unfocus();

    notifyListeners();
  }

  @override
  void clearText(TextEditingController controller) {
    controller.clear();
    notifyListeners();
  }

  void toggleButton(type) {
    if (type == "bold") {
      _isBold = !_isBold;
    }
    if (type == "italic") {
      _isItalic = !_isItalic;
    }
    if (type == "underline") {
      _isUnderline = !_isUnderline;
    }
    notifyListeners();
  }

  void setToolbar(boolType) {
    _onToolBar = boolType;
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

  void updateSelectedInterestTalentKeywordCodes(List<int> keywordTalent) {
    _selectedInterestTalentKeywordCodes.clear();
    if (keywordTalent.isNotEmpty) {
      _selectedInterestTalentKeywordCodes.addAll(keywordTalent);
    }
    notifyListeners();
  }
}
