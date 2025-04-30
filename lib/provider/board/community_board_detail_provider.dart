import 'package:app_front_talearnt/data/model/respone/community_comment.dart';
import 'package:app_front_talearnt/data/model/respone/community_reply.dart';
import 'package:app_front_talearnt/provider/clear_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_delta_from_html/parser/html_to_delta.dart';

import '../../data/model/respone/community_detail_board.dart';

class CommunityBoardDetailProvider extends ChangeNotifier with ClearText {
  final QuillController _contentController = QuillController.basic();
  CommunityDetailBoard _communityDetailBoard = CommunityDetailBoard.empty();
  final List<String> _previewImageList = [];

  int _previewImageIndex = 0;

  bool _isAppBarVisible = true;

  Map<int, bool> _replyOpenMap = {};

  List<CommunityCommentResponse> _commentList = [];

  final Map<int, List<CommunityReplyResponse>> _replyMap = {};

  final Map<int, bool> _replyHasNext = {};

  bool _hasNext = false;

  bool _isCommentInputActive = false;

  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();

  CommunityDetailBoard get communityDetailBoard => _communityDetailBoard;

  QuillController get contentController => _contentController;

  List<String> get previewImageList => _previewImageList;

  int get previewImageIndex => _previewImageIndex;

  bool get isAppBarVisible => _isAppBarVisible;

  List<CommunityCommentResponse> get commentList => _commentList;

  Map<int, List<CommunityReplyResponse>> get replyMap => _replyMap;

  Map<int, bool> get replyHasNext => _replyHasNext;

  bool get isCommentInputActive => _isCommentInputActive;

  bool get hasNext => _hasNext;

  TextEditingController get commentController => _commentController;

  FocusNode get commentFocusNode => _commentFocusNode;

  void clearProvider() {
    _commentList = [];
    _replyOpenMap = {};
    _isCommentInputActive = false;
    _hasNext = false;

    _commentController.clear();
    _commentFocusNode.unfocus();

    notifyListeners();
  }

  @override
  void clearText(TextEditingController controller) {
    controller.clear();
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

  void setComments(List<CommunityCommentResponse> comments,
      {required bool hasNextPage}) {
    _commentList = comments;
    _hasNext = hasNextPage;
    notifyListeners();
  }

  void prependComments(List<CommunityCommentResponse> olderComments,
      {required bool hasNextPage}) {
    _commentList.insertAll(0, olderComments);
    _hasNext = hasNextPage;
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

  void toggleCommentInputActive() {
    _isCommentInputActive = !_isCommentInputActive;
    _commentFocusNode.requestFocus();
    notifyListeners();
  }

  void mergeComments(List<CommunityCommentResponse> fetched) {
    final existingIds = commentList.map((c) => c.commentNo).toSet();

    final newOnes =
        fetched.where((c) => !existingIds.contains(c.commentNo)).toList();

    if (newOnes.isNotEmpty) {
      commentList.addAll(newOnes);
      toggleCommentInputActive();
      commentController.clear();
      commentFocusNode.unfocus();
      notifyListeners();
    }
  }
}
