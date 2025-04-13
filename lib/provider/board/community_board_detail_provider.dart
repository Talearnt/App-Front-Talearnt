import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_delta_from_html/parser/html_to_delta.dart';

import '../../data/model/respone/community_detail_board.dart';

class CommunityBoardDetailProvider extends ChangeNotifier {
  final QuillController _contentController = QuillController.basic();
  CommunityDetailBoard _communityDetailBoard = CommunityDetailBoard.empty();
  final List<String> _previewImageList = [];

  int _previewImageIndex = 0;

  bool _isAppBarVisible = true;

  final Map<int, bool> _replyOpenMap = {};

  CommunityDetailBoard get communityDetailBoard => _communityDetailBoard;

  QuillController get contentController => _contentController;

  List<String> get previewImageList => _previewImageList;

  int get previewImageIndex => _previewImageIndex;

  bool get isAppBarVisible => _isAppBarVisible;

  bool isRepliesOpen(int commentNo) {
    return _replyOpenMap[commentNo] ?? false;
  }

  void toggleRepliesOpen(int commentNo) {
    _replyOpenMap[commentNo] = !(isRepliesOpen(commentNo));
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

  void updateCommunityDetailBoard(CommunityDetailBoard detailPost) {
    _communityDetailBoard = detailPost;
    String content = _communityDetailBoard.content;

    var htmlToDelta = HtmlToDelta().convert(content);
    contentController.document = Document.fromDelta(htmlToDelta);
    contentController.readOnly = true;

    makePreviewImageList();
    notifyListeners();
  }
}
