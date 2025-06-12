import 'dart:async';
import 'dart:io';
import 'dart:typed_data' as typed_data;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;

import '../../constants/global_value_constants.dart';
import '../../data/model/respone/user_profile.dart';
import '../clear_text.dart';
import '../common/custom_ticker_provider.dart';

class ProfileProvider extends ChangeNotifier with ClearText {
  ProfileProvider() : _tickerProvider = CustomTickerProvider() {
    _giveTalentTabController = TabController(
        length: GlobalValueConstants.keywordCategoris.length,
        vsync: _tickerProvider);
    _receiveTalentTabController = TabController(
        length: GlobalValueConstants.keywordCategoris.length,
        vsync: _tickerProvider);
    _eventNoticeTabController =
        TabController(length: 2, vsync: _tickerProvider);
  }

  UserProfile _userProfile = UserProfile.empty();
  final TextEditingController _editNickNameController = TextEditingController();
  final FocusNode _editNickNameFocusNode = FocusNode();
  final List<int> _giveTalents = [];
  final List<int> _editGiveTalents = [];
  final List<int> _receiveTalents = [];
  final List<int> _editReceiveTalents = [];

  late TabController _giveTalentTabController;
  late TabController _receiveTalentTabController;
  late TabController _eventNoticeTabController;
  final CustomTickerProvider _tickerProvider;

  Object? _imageFile;
  File? _tempImageFile;
  Size? _tempImageSize;
  final ImagePicker _picker = ImagePicker();

  bool _editNickNameValid = true;
  bool _checkEditNickNameDuplication = false; //중복체크 false - 중복아님
  String _editNickNameValidMessage = '';
  bool _isEditNickNameInfoValid = false;
  String _editNickNameInfoValidMessage = '';
  bool _isEditNickNameInfo = true;
  String _editNickNameInfoMessage = '';
  String _editNickNameInfoType = 'checkInfo';
  String _editNickNameHelperType = '';
  bool _editNickNameHelper = false;
  bool _changeEditNickName = false; //닉네임 변경했는지
  String _errorMessage = "";

  String _imageUploadS3Url = "";
  bool _isS3Upload = false;
  Map<String, dynamic> _uploadUserImageInfo = {};
  String _editImageUploadUrl = "";
  bool _changeImage = false;

  TabController get giveTalentTabController => _giveTalentTabController;

  TabController get receiveTalentTabController => _receiveTalentTabController;

  TabController get eventNoticeTabController => _eventNoticeTabController;

  bool _allAlarm = false;
  bool _commentAlarm = false;
  bool _keywordAlarm = false;

  UserProfile get userProfile => _userProfile;

  bool get allAlarm => _allAlarm;

  bool get commentAlarm => _commentAlarm;

  bool get keywordAlarm => _keywordAlarm;

  TextEditingController get editNickNameController => _editNickNameController;

  FocusNode get editNickNameFocusNode => _editNickNameFocusNode;

  List<int> get giveTalents => _giveTalents;

  List<int> get receiveTalents => _receiveTalents;

  List<int> get editGiveTalents => _editGiveTalents;

  List<int> get editReceiveTalents => _editReceiveTalents;

  bool get editNickNameValid => _editNickNameValid;

  String get editNickNameValidMessage => _editNickNameValidMessage;

  bool get isEditNickNameInfoValid => _isEditNickNameInfoValid;

  String get editNickNameInfoValidMessage => _editNickNameInfoValidMessage;

  bool get isEditNickNameInfo => _isEditNickNameInfo;

  String get editNickNameInfoMessage => _editNickNameInfoMessage;

  String get editNickNameInfoType => _editNickNameInfoType;

  String get editNickNameHelperType => _editNickNameHelperType;

  bool get editNickNameHelper => _editNickNameHelper;

  bool get changeEditNickName => _changeEditNickName;

  String get errorMessage => _errorMessage;

  Object? get imageFile => _imageFile;

  File? get tempImageFile => _tempImageFile;

  Size? get tempImageSize => _tempImageSize;

  String get imageUploadS3Url => _imageUploadS3Url;

  String get editImageUploadUrl => _editImageUploadUrl;

  bool get isS3Upload => _isS3Upload;

  Map<String, dynamic> get uploadUserImageInfo => _uploadUserImageInfo;

  bool get changeImage => _changeImage;

  Future<void> setUserProfile(UserProfile userProfile) async {
    _userProfile = userProfile;
    notifyListeners();
  }

  void changeAllAlarm(bool alarm) {
    _allAlarm = alarm;
    _commentAlarm = alarm;
    _keywordAlarm = alarm;
    notifyListeners();
  }

  void changeCommentAlarm(bool alarm) {
    _commentAlarm = alarm;
    if (_commentAlarm && _keywordAlarm) {
      _allAlarm = true;
    } else {
      _allAlarm = false;
    }
    notifyListeners();
  }

  void changeKeywordAlarm(bool alarm) {
    _keywordAlarm = alarm;
    if (_commentAlarm && _keywordAlarm) {
      _allAlarm = true;
    } else {
      _allAlarm = false;
    }
    notifyListeners();
  }

  void setUserEditProfile() {
    _imageFile = _userProfile.profileImg;
    _editNickNameController.text = _userProfile.nickname;
    _giveTalents.clear();
    _giveTalents.addAll(_userProfile.giveTalents);
    _receiveTalents.clear();
    _receiveTalents.addAll(_userProfile.receiveTalents);
    notifyListeners();
  }

  void updateController(TextEditingController editNickNameController) {
    editNickNameController.addListener(() {
      notifyListeners();
    });
  }

  void updateEditNickNameChange(bool change) {
    _changeEditNickName = change;
    notifyListeners();
  }

  void updateEditNickNameInfoValid(String type) {
    if (type == '') {
      // if (type == '' && !_isFirstVisit) {
      _isEditNickNameInfo = false;
      _isEditNickNameInfoValid = false;
      _editNickNameInfoValidMessage = '';
      _changeEditNickName = true;
    } else {
      _isEditNickNameInfo = true;
      _isEditNickNameInfoValid = true;
      _editNickNameInfoType = type;
      _editNickNameValid = false;
    }
    notifyListeners();
  }

  void updateEditNickNameInfo(String info, String infoGuide) {
    _editNickNameHelper = true;
    _isEditNickNameInfoValid = true;
    _editNickNameInfoMessage = info;
    _editNickNameInfoValidMessage = infoGuide;
    notifyListeners();
  }

  void checkEditNickNameDuplication(bool isNickNameDuplication) {
    _checkEditNickNameDuplication = isNickNameDuplication;
    _editNickNameHelper = false;
    if (_checkEditNickNameDuplication) {
      _isEditNickNameInfo = false;
      _editNickNameHelperType = 'error';
      _editNickNameValid = false;
      _editNickNameValidMessage = "이미 등록된 닉네임 입니다.";
    } else {
      _isEditNickNameInfo = false;
      _editNickNameHelperType = 'check';
      _editNickNameValid = true;
      _editNickNameValidMessage = "사용가능한 닉네임 입니다.";
    }
    notifyListeners();
  }

  void removeGiveTalentsList(int giveTalent) {
    _giveTalents.remove(giveTalent);
    notifyListeners();
  }

  void removeReceiveTalentsList(int receiveTalent) {
    _receiveTalents.remove(receiveTalent);
    notifyListeners();
  }

  void removeEditGiveTalentsList(int giveTalent) {
    _editGiveTalents.remove(giveTalent);
    notifyListeners();
  }

  void removeEditReceiveTalentsList(int receiveTalent) {
    _editReceiveTalents.remove(receiveTalent);
    notifyListeners();
  }

  void updateGiveTalentsList(List<int> keywordTalent) {
    _giveTalents.clear();
    _giveTalents.addAll(keywordTalent);
    notifyListeners();
  }

  void updateReceiveTalentsList(List<int> keywordTalent) {
    _receiveTalents.clear();
    _receiveTalents.addAll(keywordTalent);
    notifyListeners();
  }

  void updateEditGiveTalentsList(List<int> giveTalents) {
    _editGiveTalents.clear();
    if (giveTalents.isNotEmpty) {
      _editGiveTalents.addAll(giveTalents);
    }
    notifyListeners();
  }

  void updateEditReceiveTalentsList(List<int> receiveTalents) {
    _editReceiveTalents.clear();
    if (receiveTalents.isNotEmpty) {
      _editReceiveTalents.addAll(receiveTalents);
    }
    notifyListeners();
  }

  Future<void> pickImage(ImageSource source, BuildContext context) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 80);

    if (pickedFile != null) {
      _tempImageFile = File(pickedFile.path);

      final bytes = await pickedFile.readAsBytes();
      final imageSize = await _getImageSize(bytes);
      _tempImageSize = imageSize;
      notifyListeners();
    }
    if (context.mounted) context.pop();
  }

  Future<Size> _getImageSize(typed_data.Uint8List imageBytes) {
    final completer = Completer<Size>();

    ui.decodeImageFromList(imageBytes, (ui.Image image) {
      final size = Size(image.width.toDouble(), image.height.toDouble());
      completer.complete(size);
    });

    return completer.future;
  }

  void resetImage() {
    _imageFile = null;
    notifyListeners();
  }

  void applyTempImage() {
    if (_tempImageFile != null) {
      _imageFile = _tempImageFile;
      _tempImageFile = null;
      _changeImage = true;
      notifyListeners();
    }
  }

  void clearInfo() {
    _uploadUserImageInfo.clear();
    notifyListeners();
  }

  //s3올리기 전 서버에 넣어 s3 url 받아오기 위한 세팅용
  Future<void> getUploadImagesInfo() async {
    _uploadUserImageInfo.clear();

    if (_imageFile != null && _imageFile is File) {
      final file = _imageFile as File;
      final int sizeInBytes = await file.length();

      final mimeType = lookupMimeType(file.path) ?? "application/octet-stream";

      _uploadUserImageInfo = {
        "file": _imageFile,
        "fileName": path.basename(file.path),
        "fileType": mimeType,
        "fileSize": sizeInBytes,
      };
    }

    notifyListeners();
  }

  //s3에 올라가기전 s3에 올릴 url 받아오는 함수
  Future<void> setImageUploadUrl(String newUrl) async {
    _imageUploadS3Url = newUrl;
    _isS3Upload = true;
    notifyListeners();
  }

  //유저 수정할때 사용될 url 변수에 set하는 함수
  Future<void> finishImageUpload(String imageUploadUrl) async {
    String newImageUrl = imageUploadUrl.split('?')[0];
    _editImageUploadUrl = newImageUrl;
    _isS3Upload = false;
    notifyListeners();
  }

  Future<void> finishEditUserInfo() async {
    _editImageUploadUrl = "";
    _imageUploadS3Url = "";
    _changeImage = false;
    _uploadUserImageInfo.clear();
    notifyListeners();
  }

  void resetModifyProfile() {
    _editNickNameController.clear();
    _editNickNameFocusNode.unfocus();
    _editGiveTalents.clear();
    _editReceiveTalents.clear();
    _imageFile = null;
    _tempImageFile = null;
    _tempImageSize = null;
    _editNickNameValid = true;
    _checkEditNickNameDuplication = false;
    _editNickNameValidMessage = '';
    _isEditNickNameInfoValid = false;
    _editNickNameInfoValidMessage = '';
    _isEditNickNameInfo = true;
    _editNickNameInfoMessage = '';
    _editNickNameInfoType = 'checkInfo';
    _editNickNameHelperType = '';
    _editNickNameHelper = false;
    _changeEditNickName = false;
    _errorMessage = "";
    _editImageUploadUrl = "";
    _imageUploadS3Url = "";
    _isS3Upload = false;
    _uploadUserImageInfo.clear();
    notifyListeners();
  }

  @override
  void clearText(TextEditingController controller) {
    controller.clear();
    notifyListeners();
  }
}
