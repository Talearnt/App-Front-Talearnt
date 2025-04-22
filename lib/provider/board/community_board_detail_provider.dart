import 'package:app_front_talearnt/data/model/respone/community_comment.dart';
import 'package:app_front_talearnt/data/model/respone/community_reply.dart';
import 'package:app_front_talearnt/view/board/community_board/community_comment.dart';
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

  Map<int, bool> _replyOpenMap = {};

  List<CommunityCommentRespone> _commentList = [];

  final Map<int, List<CommunityReplyResponse>> _replyMap = {};

  final Map<int, bool> _replyHasNext = {};

  bool hasNext = false;

  CommunityDetailBoard get communityDetailBoard => _communityDetailBoard;

  QuillController get contentController => _contentController;

  List<String> get previewImageList => _previewImageList;

  int get previewImageIndex => _previewImageIndex;

  bool get isAppBarVisible => _isAppBarVisible;

  List<CommunityCommentRespone> get commentList => _commentList;

  Map<int, List<CommunityReplyResponse>> get replyMap => _replyMap;
  Map<int, bool> get replyHasNext => _replyHasNext;

  void clearProvider() {
    _commentList = [];
    _replyOpenMap = {};

    notifyListeners();
  }

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

  void setComments(List<CommunityCommentRespone> comments,
      {required bool hasNextPage}) {
    _commentList = comments;
    hasNext = hasNextPage;
    notifyListeners();
  }

  void prependComments(List<CommunityCommentRespone> olderComments,
      {required bool hasNextPage}) {
    _commentList.insertAll(0, olderComments);
    hasNext = hasNextPage;
    notifyListeners();
  }

  void setReplies(int commentNo, List<CommunityReplyResponse> replies,
      {required bool hasNextPage}) {
    _replyMap[commentNo] = replies;
    _replyHasNext[commentNo] = hasNextPage;
    notifyListeners();
  }

  void prependReplies(int commentNo, List<CommunityReplyResponse> olderReplies,
      {required bool hasNextPage}) {
    final existing = _replyMap[commentNo] ?? [];
    _replyMap[commentNo] = [...existing, ...olderReplies];
    _replyHasNext[commentNo] = hasNextPage;
    notifyListeners();
  }

  List<CommunityReplyResponse> getReplies(int commentNo) =>
      _replyMap[commentNo] ?? [];
  bool hasNextReplies(int commentNo) => _replyHasNext[commentNo] ?? false;
}
