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

  String _commentType = 'insertC';
  int _targetComment = 0;
  int _targetReply = 0;

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

  String get commentType => _commentType;

  int get targetComment => _targetComment;
  int get targetReply => _targetReply;

  void clearProvider() {
    _commentList = [];
    _replyOpenMap = {};
    _isCommentInputActive = false;
    _hasNext = false;

    _commentController.clear();
    _commentFocusNode.unfocus();

    _commentType = 'insertC';
    _targetComment = 0;
    _targetReply = 0;

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
    _replyMap[commentNo] = [...olderReplies, ...existing];
    _replyHasNext[commentNo] = hasNextPage;
    notifyListeners();
  }

  List<CommunityReplyResponse> getReplies(int commentNo) =>
      _replyMap[commentNo] ?? [];
  bool hasNextReplies(int commentNo) => _replyHasNext[commentNo] ?? false;

  void toggleCommentInputActive(bool state) {
    _isCommentInputActive = state;
    _commentFocusNode.requestFocus();
    notifyListeners();
  }

  void mergeComments(List<CommunityCommentResponse> fetched) {
    final existingIds = commentList.map((c) => c.commentNo).toSet();

    final newOnes =
        fetched.where((c) => !existingIds.contains(c.commentNo)).toList();

    if (newOnes.isNotEmpty) {
      _commentList.addAll(newOnes);
      toggleCommentInputActive(false);
      _commentController.clear();
      _commentFocusNode.unfocus();
      notifyListeners();
    }
  }

  void setInsertComment() {
    toggleCommentInputActive(true);

    _commentType = 'insertC';
    _targetComment = 0;

    notifyListeners();
  }

  void setEditComment(int commnetNo) {
    toggleCommentInputActive(true);

    final idx = _commentList.indexWhere((c) => c.commentNo == commnetNo);
    _commentController.text = _commentList[idx].content;

    _commentType = 'updateC';
    _targetComment = commnetNo;

    _commentFocusNode.requestFocus();

    notifyListeners();
  }

  void updateCommentContent(int commentNo, String newContent) {
    for (var i = 0; i < _commentList.length; i++) {
      if (_commentList[i].commentNo == commentNo) {
        _commentList[i] = CommunityCommentResponse(
          userNo: _commentList[i].userNo,
          commentNo: _commentList[i].commentNo,
          nickname: _commentList[i].nickname,
          profileImg: _commentList[i].profileImg,
          content: newContent,
          createdAt: _commentList[i].createdAt,
          isDeleted: _commentList[i].isDeleted,
          replyCount: _commentList[i].replyCount,
        );
        break;
      }
    }

    toggleCommentInputActive(false);

    _commentController.clear();
    _commentFocusNode.unfocus();

    _commentType = 'insertC';
    _targetComment = 0;

    notifyListeners();
  }

  void setInsertReplies(int commentNo) {
    toggleCommentInputActive(true);

    _commentType = 'insertR';
    _targetComment = commentNo;

    notifyListeners();
  }

  void removeComment(int commentNo) {
    final idx = _commentList.indexWhere((c) => c.commentNo == commentNo);
    if (idx == -1) return;

    final old = _commentList[idx];

    _commentList[idx] = CommunityCommentResponse(
      userNo: old.userNo,
      commentNo: old.commentNo,
      nickname: old.nickname,
      profileImg: old.profileImg,
      content: old.content,
      createdAt: old.createdAt,
      replyCount: old.replyCount,
      isDeleted: true,
    );

    notifyListeners();
  }

  void mergeReplies(
      int commentNo, List<CommunityReplyResponse> fetchedReplies) {
    final existing = _replyMap[commentNo] ?? [];

    final existingIds = existing.map((r) => r.replyNo).toSet();

    final newReplies =
        fetchedReplies.where((r) => !existingIds.contains(r.replyNo)).toList();

    if (newReplies.isNotEmpty) {
      _replyMap[commentNo] = [...existing, ...newReplies];
      toggleCommentInputActive(false);
      setReplyCount(commentNo, 1);
      _commentController.clear();
      _commentFocusNode.unfocus();
      _commentType = 'insertR';

      notifyListeners();
    }
  }

  void setReplyCount(int commentNo, int num) {
    final idx = _commentList.indexWhere((c) => c.commentNo == commentNo);
    if (idx == -1) return;

    final old = _commentList[idx];

    _commentList[idx] = CommunityCommentResponse(
      userNo: old.userNo,
      commentNo: old.commentNo,
      nickname: old.nickname,
      profileImg: old.profileImg,
      content: old.content,
      createdAt: old.createdAt,
      isDeleted: old.isDeleted,
      replyCount: old.replyCount + num,
    );

    notifyListeners();
  }

  void setEditReply(int commentNo, int replyNo) {
    toggleCommentInputActive(true);

    final replies = _replyMap[commentNo] ?? [];

    final idx = replies.indexWhere((r) => r.replyNo == replyNo);

    final reply = replies[idx];

    commentController.text = reply.content;

    _commentType = 'updateR';
    _targetComment = commentNo;
    _targetReply = replyNo;

    _commentFocusNode.requestFocus();

    notifyListeners();
  }

  void removeReply(int commentNo, int replyNo) {
    final existing = _replyMap[commentNo];
    if (existing == null) return;

    _replyMap[commentNo] = existing.where((r) => r.replyNo != replyNo).toList();

    setReplyCount(commentNo, -1);

    notifyListeners();
  }

  void updateReplyContent(int commentNo, int replyNo, String newContent) {
    // 1) 해당 댓글의 답글 리스트 가져오기
    final replies = _replyMap[commentNo];
    if (replies == null) return;

    // 2) 인덱스 찾기
    final idx = replies.indexWhere((r) => r.replyNo == replyNo);
    if (idx == -1) return;

    // 3) 새 인스턴스로 교체 (content만 교체)
    replies[idx] = CommunityReplyResponse(
      replyNo: replies[idx].replyNo,
      commentNo: replies[idx].commentNo,
      userNo: replies[idx].userNo,
      nickname: replies[idx].nickname,
      profileImg: replies[idx].profileImg,
      content: newContent, // 여기만 새 내용
      createdAt: replies[idx].createdAt,
    );

    // 4) 편집 모드 해제 및 컨트롤러·포커스 정리
    toggleCommentInputActive(false); // 입력창 닫기
    _commentController.clear();
    _commentFocusNode.unfocus();

    // 5) 상태 초기화
    _commentType = 'insertC';
    _targetComment = 0;
    _targetReply = 0;

    notifyListeners();
  }
}
