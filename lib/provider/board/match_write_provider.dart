import 'dart:io';

import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/dialog.dart';
import 'package:app_front_talearnt/provider/common/custom_ticker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

import '../../constants/global_value_constants.dart';
import '../clear_text.dart';

class MatchWriteProvider extends ChangeNotifier with ClearText {
  MatchWriteProvider() : _tickerProvider = CustomTickerProvider() {
    _giveTalentTabController = TabController(
        length: GlobalValueConstants.keywordCategoris.length,
        vsync: _tickerProvider);
    _interestTalentTabController = TabController(
        length: GlobalValueConstants.keywordCategoris.length,
        vsync: _tickerProvider);
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
  final List<int> _giveTalentKeywordCodes = [];
  final List<int> _selectedGiveTalentKeywordCodes = [];
  final List<int> _searchedGiveTalentKeywordCodes = [];
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

  String _htmlContent = "";

  double _totalImageSize = 0;

  final ImagePicker _picker = ImagePicker();

  TextEditingController get titlerController => _titlerController;

  QuillController get contentController => _contentController;

  FocusNode get titleFocusNode => _titleFocusNode;

  FocusNode get contentFocusNode => _contentFocusNode;

  String _onToolBar = "default";

  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderline = false;
  bool _isUl = false;
  bool _isOl = false;

  int _fontSize = 16;
  final List<int> _fontSizeList = [12, 14, 16, 18, 20, 22, 24, 30];

  static Color gray_100 = const Color(0xFF1E2224);
  static Color red_60 = const Color(0xFFFF2727);
  static Color orange_60 = const Color(0xFFFF9A27);
  static Color yellow_60 = const Color(0xFFFFDB27);
  static Color green_60 = const Color(0xFF00E57E);
  static Color blue_60 = const Color(0xFF1B76FF);
  static Color purple_60 = const Color(0xFFA927FF);

  Color _fontColor = gray_100;
  final List<Color> _fontColorList = [
    gray_100,
    red_60,
    orange_60,
    yellow_60,
    green_60,
    blue_60,
    purple_60
  ];

  static Color white = const Color(0xFFFFFFFF);
  static Color gray_30 = const Color(0xFFDEE1E3);
  static Color red_20 = const Color(0xFFFFE5E5);
  static Color orange_30 = const Color(0xFFFFE2C2);
  static Color yellow_30 = const Color(0xFFFFF5C2);
  static Color green_30 = const Color(0xFFB2FFDD);
  static Color blue_30 = const Color(0xFFB2D1FF);
  static Color purple_30 = const Color(0xFFE7C2FF);

  Color _backGroundColor = white;
  final List<Color> _backGroundColorList = [
    white,
    gray_30,
    red_20,
    orange_30,
    yellow_30,
    green_30,
    blue_30,
    purple_30
  ];

  static final Map<Color, String> _colorNames = {
    white: "white",
    gray_30: "gray_30",
    gray_100: "gray_100",
    red_20: "red_20",
    red_60: "red_60",
    orange_30: "orange_30",
    orange_60: "orange_60",
    yellow_30: "yellow_30",
    yellow_60: "yellow_60",
    green_30: "green_30",
    green_60: "green_60",
    blue_30: "blue_30",
    blue_60: "blue_60",
    purple_30: "purple_30",
    purple_60: "purple_60",
  };

  String _alignType = "left";

  bool _isChipsSelected = false;
  bool _isTitleAndBoardEmpty = false;

  String _boardToastMessage = "";

  final List<Map<String, dynamic>> _uploadImageInfos = [];

  List<String> _imageUploadUrls = [];

  final List<File> _previewImageList = []; // 이미지 미리보기

  int _previeImageIndex = 0; // 이미지 미리보기

  bool _isAppBarVisible = true; // 이미지 미리보기

  bool _isS3Upload = false;

  String get onToolBar => _onToolBar;

  bool get isBold => _isBold;

  bool get isItalic => _isItalic;

  bool get isUnderline => _isUnderline;

  bool get isUl => _isUl;

  bool get isOl => _isOl;

  int get fontSize => _fontSize;

  List<int> get fontSizeList => _fontSizeList;

  Color get fontColor => _fontColor;

  List<Color> get fontColorList => _fontColorList;

  Color get backGroundColor => _backGroundColor;

  List<Color> get backGroundColorList => _backGroundColorList;

  Map<Color, String> get colorNames => _colorNames;

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

  ImagePicker get picker => _picker;

  List<Map<String, dynamic>> get uploadImageInfos => _uploadImageInfos;

  List<String> get imageUploadUrls => _imageUploadUrls;

  bool get isS3Upload => _isS3Upload;

  String get htmlContent => _htmlContent;

  double get totalImageSize => _totalImageSize;

  List<File> get previewImageList => _previewImageList; // 이미지 미리보기

  int get previeImageIndex => _previeImageIndex; // 이미지 미리보기

  bool get isAppBarVisible => _isAppBarVisible; // 이미지 미리보기

  void clearProvider() {
    _titlerController.clear();
    _contentController.clear();

    _titleFocusNode.unfocus();
    _contentFocusNode.unfocus();

    _searchedGiveTalentKeywordCodes.clear();
    _searchedInterestTalentKeywordCodes.clear();

    _giveTalentKeywordCodes.clear();

    _giveTalentRequiredMessage = "";
    _interestTalentRequiredMessage = "";
    _durationRequiredMessage = "";
    _exchangeTypeRequiredMesage = "";

    _onToolBar = "default";

    _isBold = false;
    _isItalic = false;
    _isUnderline = false;
    _isUl = false;
    _isOl = false;
    _fontSize = 16;
    _fontColor = gray_100;
    _backGroundColor = white;
    _alignType = "left";
    _isChipsSelected = false;
    _isTitleAndBoardEmpty = false;
    _boardToastMessage = "";

    _htmlContent = "";
    _totalImageSize = 0;

    _previewImageList.clear();
    _isS3Upload = false;

    reset();
    notifyListeners();
  }

  void reset() {
    _giveTalentTabController.index = 0;
    _interestTalentTabController.index = 0;
    _giveTalentFocusNode.unfocus();
    _interestTalentFocusNode.unfocus();
    _interestTalentKeywordCodes.clear();
    _selectedGiveTalentKeywordCodes.clear();
    _selectedInterestTalentKeywordCodes.clear();
    _selectedDuration = "";
    _selectedExchangeType = "";
    _tickerProvider.dispose();

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

  void setFontSize(size) {
    _fontSize = size;

    notifyListeners();
  }

  void setFontColor(color) {
    _fontColor = color;

    notifyListeners();
  }

  void setBackGroundColor(color) {
    _backGroundColor = color;

    notifyListeners();
  }

  void setToolbar(type) {
    _onToolBar = type;
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

  void setGiveTalentKeyword(List<dynamic> keywords) {
    for (final keyword in keywords) {
      if (!_giveTalentKeywordCodes.contains(keyword.code)) {
        _giveTalentKeywordCodes.add(keyword.code);
      }
    }
  }

  void checkChipsSelected() {
    _isChipsSelected = true;

    if (_selectedGiveTalentKeywordCodes.isEmpty) {
      _giveTalentRequiredMessage = "*필수";
      _isChipsSelected = false;
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

  Future<void> pickImagesAndInsert(BuildContext context) async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      for (final pickedFile in pickedFiles) {
        final File image = File(pickedFile.path);

        final processedImage = await _processImage(image);

        // 압축 후 파일 크기 계산
        final int finalSizeInBytes = await processedImage.length();
        final double finalSizeInMB = finalSizeInBytes / (1024 * 1024);

        // 총 용량 초과 체크
        if (_totalImageSize + finalSizeInMB > 5) {
          SingleBtnDialog.show(context,
              content: '이미지는 최대 5MB까지 업로드 가능합니다.',
              button: const PrimaryM(
                content: '확인',
              ));
          break;
        }

        // 압축 후 이미지 크기 추가
        _totalImageSize += finalSizeInMB;

        contentController.insertImageBlock(imageSource: processedImage.path);
      }
    }

    notifyListeners();
  }

  Future<File> _processImage(File imageFile) async {
    final originalImage = img.decodeImage(await imageFile.readAsBytes());

    if (originalImage == null) {
      throw Exception('이미지를 디코딩할 수 없습니다.');
    }

    const maxHeight = 1024;
    const maxFileSizeInMB = 3;
    const quality = 75;

    img.Image processedImage = originalImage;

    if (originalImage.height > maxHeight) {
      final scaleFactor = maxHeight / originalImage.height;
      final newWidth = (originalImage.width * scaleFactor).toInt();
      processedImage =
          img.copyResize(originalImage, width: newWidth, height: maxHeight);
    }

    final String newPath = path.join(
      imageFile.parent.path,
      'processed_${imageFile.uri.pathSegments.last}',
    );
    final processedFile = File(newPath);

    await processedFile
        .writeAsBytes(img.encodeJpg(processedImage, quality: quality));

    final int finalSizeInBytes = await processedFile.length();
    final double finalSizeInMB = finalSizeInBytes / (1024 * 1024);

    if (finalSizeInMB > maxFileSizeInMB) {
      const lowerQuality = 75;
      await processedFile
          .writeAsBytes(img.encodeJpg(processedImage, quality: lowerQuality));
    }

    return processedFile;
  }

  void setImageUploadUrl(List<String> data) {
    _imageUploadUrls = data;
    _isS3Upload = true;
    notifyListeners();
  }

  Future<void> getUploadImagesInfo() async {
    final delta = contentController.document.toDelta();
    uploadImageInfos.clear();
    for (var op in delta.toList()) {
      if (op.value is Map<String, dynamic> && op.value.containsKey('image')) {
        final imagePath = op.value['image'];

        final imageFile = File(imagePath);

        final int sizeInBytes = await imageFile.length();

        uploadImageInfos.add({
          "file": imageFile,
          "fileName": path.basename(imagePath),
          "fileType": "image/${path.extension(imagePath).replaceAll(".", "")}",
          "fileSize": sizeInBytes,
        });
      }
    }

    notifyListeners();
  }

  void exchangeImageUrl(String imageUploadUrl, String imagePath) {
    final delta = contentController.document.toDelta();

    String newImageUrl = imageUploadUrl.split('?')[0];

    for (var op in delta.toList()) {
      if (op.value is Map<String, dynamic> && op.value.containsKey('image')) {
        op.value['image'] = newImageUrl;
      }
    }

    _isS3Upload = false;
    _uploadImageInfos.clear();
    _imageUploadUrls.clear();
  }

  void clearInfos() {
    _uploadImageInfos.clear();
  }

  void insertMatchBoard() {
    final delta = contentController.document.toDelta();
    final deltaOps = delta.toList().map((op) => op.toJson()).toList();
    final converter = QuillDeltaToHtmlConverter(deltaOps);
    _htmlContent = converter.convert();
  }

  void makePreviewImageList() async {
    // 이미지 미리보기
    final delta = contentController.document.toDelta();

    for (var op in delta.toList()) {
      if (op.value is Map<String, dynamic> && op.value.containsKey('image')) {
        final imagePath = op.value['image'];

        final imageFile = File(imagePath);

        _previewImageList.add(imageFile);
      }
    }
  }

  void previewImageListclear() {
    // 이미지 미리보기
    _previewImageList.clear();
  }

  void setPreviewImageIndex(int num) {
    // 이미지 미리보기
    _previeImageIndex = num;

    notifyListeners();
  }

  void toggleAppbarVisible() {
    // 이미지 미리보기
    _isAppBarVisible = !_isAppBarVisible;

    notifyListeners();
  }
}
