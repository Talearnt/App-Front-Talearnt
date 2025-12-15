import 'dart:async';
import 'dart:io';

import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:go_router/go_router.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

import '../clear_text.dart';
import '../common/common_provider.dart';

class CommunityWriteProvider extends ChangeNotifier with ClearText {
  CommunityWriteProvider() {
    _contentController.addListener(_onChanged);
    _subscription =
        _contentController.document.changes.listen(_onDocumentChange);
  }

  void _onDocumentChange(DocChange change) {
    final ChangeSource source = change.source;
    final Delta delDelta = change.change;
    final delta = contentController.document.toDelta();

    int imageCount = 0;

    if (source == ChangeSource.local) {
      for (var delOp in delDelta.toList()) {
        if (delOp.isDelete) {
          for (var op in delta.toList()) {
            if (op.value is Map<String, dynamic> &&
                op.value.containsKey('image')) {
              imageCount++;
            }
          }
          _totalImageCount = imageCount;
        }
      }
    }

    notifyListeners();
  }

  StreamSubscription? _subscription;

  final TextEditingController _titleController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();
  final QuillController _contentController = QuillController.basic();
  final FocusNode _contentFocusNode = FocusNode();
  String _selectedCategory = "";
  String _categoryRequiredMessage = "";
  String _htmlContent = "";
  double _totalImageSize = 0;
  final ImagePicker _picker = ImagePicker();

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

  int _totalImageCount = 0;

  final List<Map<String, dynamic>> _uploadImageInfo = [];

  List<String> _imageUploadUrls = [];

  final List<String> _imageUploadedUrls = [];

  final List<String> _previewImageList = [];

  final TextEditingController _linkTextController = TextEditingController();

  final TextEditingController _urlController = TextEditingController();

  bool _isLinkTextNotEmpty = false;

  bool _isS3Upload = false;

  int _postNo = 0;

  TextEditingController get titleController => _titleController;

  QuillController get contentController => _contentController;

  FocusNode get titleFocusNode => _titleFocusNode;

  FocusNode get contentFocusNode => _contentFocusNode;

  String get selectedCategory => _selectedCategory;

  String get categoryRequiredMessage => _categoryRequiredMessage;

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

  bool get isChipsSelected => _isChipsSelected;

  bool get isTitleAndBoardEmpty => _isTitleAndBoardEmpty;

  String get boardToastMessage => _boardToastMessage;

  ImagePicker get picker => _picker;

  List<Map<String, dynamic>> get uploadImageInfo => _uploadImageInfo;

  List<String> get imageUploadUrls => _imageUploadUrls;

  List<String> get imageUploadedUrls => _imageUploadedUrls;

  List<String> get previewImageList => _previewImageList;

  bool get isS3Upload => _isS3Upload;

  String get htmlContent => _htmlContent;

  double get totalImageSize => _totalImageSize;

  TextEditingController get linkTextController => _linkTextController;

  TextEditingController get urlController => _urlController;

  bool get isLinkTextNotEmpty => _isLinkTextNotEmpty;

  int get totalImageCount => _totalImageCount;

  int get postNo => _postNo;

  void clearProvider() {
    _subscription?.cancel();
    _subscription = null;

    _titleController.clear();
    _contentController.clear();

    _titleFocusNode.unfocus();
    _contentFocusNode.unfocus();
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

    _selectedCategory = "";
    _categoryRequiredMessage = "";
    _htmlContent = "";
    _totalImageSize = 0;
    _totalImageCount = 0;

    _isS3Upload = false;

    _uploadImageInfo.clear();
    _imageUploadUrls.clear();
    _imageUploadedUrls.clear();
    _previewImageList.clear();

    _linkTextController.clear();
    _urlController.clear();
    _postNo = 0;

    reset();

    notifyListeners();
  }

  void reset() {
    _selectedCategory = "";

    notifyListeners();
  }

  void _onChanged() {
    notifyListeners(); // Focus 상태 변경 시 UI 갱신
  }

  void updateController(TextEditingController textEditingController) {
    textEditingController.addListener(() {
      notifyListeners();
    });
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

  void checkChipsSelected() {
    _isChipsSelected = true;

    if (_selectedCategory.isEmpty) {
      _categoryRequiredMessage = "*필수";
      _isChipsSelected = false;
    }

    notifyListeners();
  }

  void removeSelectedCategory() {
    _selectedCategory = "";

    notifyListeners();
  }

  void updateSelectedCategory(String newCategory) {
    _selectedCategory = newCategory;

    notifyListeners();
  }

  void checkTitleAndBoard() {
    if (_titleController.text.length < 2) {
      _boardToastMessage = "제목을 2글자 이상 입력해 주세요";
      _isTitleAndBoardEmpty = false;
      return;
    }

    if (_contentController.document.length - 1 < 20) {
      _boardToastMessage = "내용을 20자 이상 입력해 주세요";
      _isTitleAndBoardEmpty = false;
      return;
    }

    _isTitleAndBoardEmpty = true;
  }

  Future<void> pickImagesAndInsert(
      BuildContext context, CommonProvider commonProvider) async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      commonProvider.changeIsLoading(true);

      for (final pickedFile in pickedFiles) {
        final File image = File(pickedFile.path);

        final processedImage = await _processImage(image);

        // 압축 후 파일 크기 계산
        final int finalSizeInBytes = await processedImage.length();
        final double finalSizeInMB = finalSizeInBytes / (1024 * 1024);

        if (finalSizeInMB > 3.0) {
          SingleBtnDialog.show(context,
              content: '각 이미지 용량은 3MB 이하만 업로드 가능합니다.',
              button: PrimaryM(
                content: '확인',
                onPressed: () {
                  context.pop();
                },
              ));
          break;
        }

        if (_totalImageCount == 5) {
          SingleBtnDialog.show(context,
              content: '이미지는 최대 5장까지 업로드 가능합니다.',
              button: PrimaryM(
                content: '확인',
                onPressed: () {
                  context.pop();
                },
              ));
          break;
        }

        _totalImageCount++;

        final int idx = contentController.selection.baseOffset;
        contentController.replaceText(
          idx,
          0,
          '\n',
          contentController.selection,
        );
        contentController.replaceText(
          idx + 1,
          0,
          BlockEmbed.image(processedImage.path),
          TextSelection.collapsed(offset: idx + 2),
        );
        contentController.replaceText(
          idx + 2,
          0,
          '\n',
          TextSelection.collapsed(offset: idx + 3),
        );
      }
    }

    notifyListeners();
    commonProvider.changeIsLoading(false);
  }

  Future<File> _processImage(File imageFile) async {
    final originalImage = img.decodeImage(await imageFile.readAsBytes());
    if (originalImage == null) {
      throw Exception('이미지를 디코딩할 수 없습니다.');
    }

    const int maxHeight = 1024;
    const int maxFileSizeInMB = 3;
    int quality = 90; // 초기 품질 설정

    img.Image processedImage = originalImage;

    if (originalImage.height > maxHeight) {
      final double scaleFactor = maxHeight / originalImage.height;
      final int newWidth = (originalImage.width * scaleFactor).toInt();
      processedImage =
          img.copyResize(originalImage, width: newWidth, height: maxHeight);
    }

    final String newPath = path.join(
      imageFile.parent.path,
      'processed_${imageFile.uri.pathSegments.last}',
    );
    File processedFile = File(newPath);

    while (true) {
      await processedFile
          .writeAsBytes(img.encodeJpg(processedImage, quality: quality));

      final int finalSizeInBytes = await processedFile.length();
      final double finalSizeInMB = finalSizeInBytes / (1024 * 1024);

      if (finalSizeInMB <= maxFileSizeInMB) {
        break;
      }

      if (quality > 10) {
        quality -= 10;
      } else {
        break;
      }
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
    uploadImageInfo.clear();

    for (var op in delta.toList()) {
      if (op.value is Map<String, dynamic> && op.value.containsKey('image')) {
        final imagePath = op.value['image'];

        final imageFile = File(imagePath);
        final int sizeInBytes = await imageFile.length();

        final mimeType =
            lookupMimeType(imagePath) ?? "application/octet-stream";

        uploadImageInfo.add({
          "file": imageFile,
          "fileName": path.basename(imagePath),
          "fileType": mimeType,
          "fileSize": sizeInBytes,
        });
      }
    }

    notifyListeners();
  }

  Future<void> exchangeImageUrl(String imageUploadUrl, String imagePath) async {
    final delta = contentController.document.toDelta();

    String newImageUrl = imageUploadUrl.split('?')[0];

    for (var op in delta.toList()) {
      if (op.value is Map<String, dynamic> &&
          op.value.containsKey('image') &&
          op.value["image"] == imagePath) {
        op.value['image'] = newImageUrl;
      }
    }

    _imageUploadedUrls.add(newImageUrl);
  }

  void clearInfo() {
    _uploadImageInfo.clear();
  }

  void insertCommunityBoard() {
    final delta = contentController.document.toDelta();
    final deltaOps = delta.toList().map((op) => op.toJson()).toList();
    final converter = QuillDeltaToHtmlConverter(deltaOps);
    _htmlContent = converter.convert();
  }

  void makePreviewImageList() async {
    final delta = contentController.document.toDelta();

    for (var op in delta.toList()) {
      if (op.value is Map<String, dynamic> && op.value.containsKey('image')) {
        final imagePath = op.value['image'];

        _previewImageList.add(imagePath);
      }
    }
  }

  void previewImageListClear() {
    _previewImageList.clear();

    notifyListeners();
  }

  void setLink(String linkText, String? url) {
    _linkTextController.text = linkText;
    _urlController.text = url ?? "";

    notifyListeners();
  }

  void checkLinkText() {
    if (_linkTextController.text.isNotEmpty && _urlController.text.isNotEmpty) {
      _isLinkTextNotEmpty = true;
    } else {
      _isLinkTextNotEmpty = false;
    }

    notifyListeners();
  }

  void finishImageUpload() {
    _isS3Upload = false;
    _uploadImageInfo.clear();
  }

  void updatePostNo(int postNo) {
    _postNo = postNo;
    notifyListeners();
  }
}
