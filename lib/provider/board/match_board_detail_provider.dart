import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_delta_from_html/parser/html_to_delta.dart';

import '../../data/model/respone/matching_detail_post.dart';

class MatchBoardDetailProvider extends ChangeNotifier {
  final QuillController _contentController = QuillController.basic();
  MatchingDetailPost _matchingDetailPost = MatchingDetailPost(
      userNo: 2,
      nickname: "테스트",
      profileImg: "유저 이미지",
      authority: "ROLE_USER",
      exchangePostNo: 1,
      giveTalents: ["HTML", "React"],
      receiveTalents: ["스페인어 회화", "영어 회화", "일본어 회화"],
      exchangeType: "온라인",
      status: "모집중",
      createdAt: "2024.12.27",
      duration: "2개월",
      requiredBadge: false,
      isFavorite: false,
      title: "수정해버린 글입니다.",
      content: "수정해버렸습니다... 자수할게요... 수정 화나요! 그만 수정해!",
      imageUrls: [],
      count: 107,
      favoriteCount: 0,
      openedChatRoomCount: 2,
      chatRoomNo: 1);

  final List<String> _previewImageList = [];

  int _previewImageIndex = 0;

  bool _isAppBarVisible = true;

  MatchingDetailPost get matchingDetailPost => _matchingDetailPost;

  QuillController get contentController => _contentController;

  List<String> get previewImageList => _previewImageList;

  int get previewImageIndex => _previewImageIndex;

  bool get isAppBarVisible => _isAppBarVisible;

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
    String content = _matchingDetailPost.content;

    var htmlToDelta = HtmlToDelta().convert(content);

    contentController.document = Document.fromDelta(htmlToDelta);
    contentController.readOnly = true;
    makePreviewImageList();
    notifyListeners();
  }
}
