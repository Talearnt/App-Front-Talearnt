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

  final List<String> _duration = ['기간 미정', '1개월', '2개월', '3개월', '3개월 이상'];
  final List<String> _exchangeType = ['온라인', '오프라인', '온/오프라인'];

  String _selectedDuration = "";
  String _selectedExchangeType = "";

  String _giveTalentRequiredMessage = "";
  String _interestTalentRequiredMessage = "";
  String _durationRequiredMessage = "";
  String _exchangeTypeRequiredMesage = "";

  TextEditingController get titlerController => _titlerController;
  QuillController get contentController => _contentController;

  FocusNode get titleFocusNode => _titleFocusNode;
  FocusNode get contentFocusNode => _contentFocusNode;

  bool _onToolBar = false;

  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderline = false;
  bool _isUl = false;
  bool _isOl = false;

  String _alignType = "left";

  bool _isChipsSelected = false;
  bool _isTitleAndBoardEmpty = false;

  String _boardToastMessage = "";

  bool get onToolBar => _onToolBar;

  bool get isBold => _isBold;
  bool get isItalic => _isItalic;
  bool get isUnderline => _isUnderline;
  bool get isUl => _isUl;
  bool get isOl => _isOl;

  String get alignType => _alignType;

  String get giveTalentRequiredMessage => _giveTalentRequiredMessage;
  String get interestTalentRequiredMessage => _interestTalentRequiredMessage;
  String get durationRequiredMessage => _durationRequiredMessage;
  String get exchangeTypeRequiredMesage => _exchangeTypeRequiredMesage;

  bool get isChipsSelected => _isChipsSelected;
  bool get isTitleAndBoardEmpty => _isTitleAndBoardEmpty;

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
  List<String> get duration => _duration;
  List<String> get exchangeType => _exchangeType;
  String get selectedDuration => _selectedDuration;
  String get selectedExchangeType => _selectedExchangeType;

  String get boardToastMessage => _boardToastMessage;

  void clearProvider() {
    _titlerController.clear();
    _contentController.clear();

    _titleFocusNode.unfocus();
    _contentFocusNode.unfocus();

    _searchedGiveTalentKeywordCodes.clear();
    _searchedInterestTalentKeywordCodes.clear();

    _giveTalentRequiredMessage = "";
    _interestTalentRequiredMessage = "";
    _durationRequiredMessage = "";
    _exchangeTypeRequiredMesage = "";

    _isBold = false;
    _isItalic = false;
    _isUnderline = false;
    _isUl = false;
    _isOl = false;
    _alignType = "left";
    _isChipsSelected = false;
    _isTitleAndBoardEmpty = false;
    _boardToastMessage = "";

    reset();
    notifyListeners();
  }

  void reset() {
    _giveTalentTabController.index = 0;
    _interestTalentTabController.index = 0;
    _giveTalentFocusNode.unfocus();
    _interestTalentFocusNode.unfocus();
    _giveTalentKeywordCodes.clear();
    _interestTalentKeywordCodes.clear();
    _selectedGiveTalentKeywordCodes.clear();
    _selectedInterestTalentKeywordCodes.clear();
    _selectedDuration = "";
    _selectedExchangeType = "";
    _tickerProvider.dispose();

    notifyListeners();
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

  void _onChanged() {
    notifyListeners(); // Focus 상태 변경 시 UI 갱신
  }

  @override
  void clearText(TextEditingController controller) {
    controller.clear();
    notifyListeners();
  }

  void toggleButton(type, [String? direct]) {
    if (type == "bold") {
      _isBold = !_isBold;
    }
    if (type == "italic") {
      _isItalic = !_isItalic;
    }
    if (type == "underline") {
      _isUnderline = !_isUnderline;
    }
    if (type == "ul") {
      _isUl = !_isUl;
    }
    if (type == "ol") {
      _isOl = !_isOl;
    }
    if (type == "align") {
      _alignType = direct!;
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

  void updateSelectedDuration(String keywordTalent) {
    _selectedDuration = "";
    if (keywordTalent.isNotEmpty) {
      _selectedDuration = keywordTalent;
    }
    notifyListeners();
  }

  void removeSelectedDuration() {
    _selectedDuration = "";
    notifyListeners();
  }

  void updateSelectedExhangeType(String keywordTalent) {
    _selectedExchangeType = "";
    if (keywordTalent.isNotEmpty) {
      _selectedExchangeType = keywordTalent;
    }
    notifyListeners();
  }

  void removeSelectedExchangeType() {
    _selectedExchangeType = "";
    notifyListeners();
  }

  void checkChipsSelected() {
    _isChipsSelected = true;

    if (_selectedGiveTalentKeywordCodes.isEmpty) {
      _giveTalentRequiredMessage = "*필수";
      //_isChipsSelected = false;
    }

    if (_selectedInterestTalentKeywordCodes.isEmpty) {
      _interestTalentRequiredMessage = "*필수";
      _isChipsSelected = false;
    }

    if (_selectedDuration == "") {
      _durationRequiredMessage = "*필수";
      _isChipsSelected = false;
    }

    if (_selectedExchangeType == "") {
      _exchangeTypeRequiredMesage = "*필수";
      _isChipsSelected = false;
    }

    notifyListeners();
  }

  void checkTitleAndBoard() {
    if (_titlerController.text.isEmpty) {
      _boardToastMessage = "제목을 입력해 주세요";
      _isTitleAndBoardEmpty = false;
      return;
    }

    if (_contentController.document.length - 1 == 0) {
      _boardToastMessage = "내용을 입력해 주세요";
      _isTitleAndBoardEmpty = false;
      return;
    }

    _isTitleAndBoardEmpty = true;
  }
}
