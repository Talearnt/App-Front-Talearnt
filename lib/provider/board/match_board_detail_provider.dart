import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_delta_from_html/parser/html_to_delta.dart';

import '../../data/model/respone/matching_detail_post.dart';

class MatchBoardDetailProvider extends ChangeNotifier {
  final QuillController _contentController = QuillController.basic();
  MatchingDetailPost? _matchingDetailPost;

  final List<String> _previewImageList = [];

  int _previewImageIndex = 0;

  bool _isAppBarVisible = true;

  MatchingDetailPost? get matchingDetailPost => _matchingDetailPost;

  QuillController get contentController => _contentController;

  List<String> get previewImageList => _previewImageList;

  int get previewImageIndex => _previewImageIndex;

  bool get isAppBarVisible => _isAppBarVisible;

  void clearProvider() {
    _contentController.clear();
    _matchingDetailPost = null;

    _previewImageList.clear();
    _previewImageIndex = 0;
    _isAppBarVisible = true;

    notifyListeners();
  }

  void makePreviewImageList() async {
    _previewImageList.clear();
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

  void setPreviewImageIndex(int num) {
    _previewImageIndex = num;
    notifyListeners();
  }

  void toggleAppbarVisible() {
    _isAppBarVisible = !_isAppBarVisible;
    notifyListeners();
  }

  void updateTalentDetailPost(MatchingDetailPost detailPost) {
    _matchingDetailPost = detailPost;
    String content = _matchingDetailPost!.content;

    var htmlToDelta = HtmlToDelta().convert(content);

    contentController.document = Document.fromDelta(htmlToDelta);
    contentController.readOnly = true;
    makePreviewImageList();
    notifyListeners();
  }
}
