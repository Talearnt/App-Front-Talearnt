import 'package:intl/intl.dart';

class CommunityDetailBoard {
  final int userNo;
  final int communityPostNo;
  final String nickname;
  final String? profileImg;
  final String? authority;
  final String title;
  final String content;
  final List<String> imageUrls;
  final String postType;
  final int count;
  final bool isLike;
  final int likeCount;
  final int commentCount;
  final String createdAt;

  CommunityDetailBoard({
    required this.userNo,
    required this.communityPostNo,
    required this.nickname,
    required this.profileImg,
    required this.authority,
    required this.title,
    required this.content,
    required this.imageUrls,
    required this.postType,
    required this.count,
    required this.isLike,
    required this.likeCount,
    required this.commentCount,
    required this.createdAt,
  });

  CommunityDetailBoard.empty()
      : userNo = 0,
        communityPostNo = 0,
        nickname = '',
        profileImg = null,
        authority = null,
        title = '',
        content = '',
        imageUrls = [],
        postType = '',
        count = 0,
        isLike = false,
        likeCount = 0,
        commentCount = 0,
        createdAt = '';

  factory CommunityDetailBoard.fromJson(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.parse(json['createdAt']);
    String formattedDate = DateFormat('yyyy.MM.dd').format(dateTime);
    return CommunityDetailBoard(
      userNo: json['userNo'],
      communityPostNo: json['communityPostNo'],
      nickname: json['nickname'],
      profileImg: json['profileImg'],
      authority: json['authority'],
      title: json['title'],
      content: json['content'],
      imageUrls: List<String>.from(json['imageUrls']),
      postType: json['postType'],
      count: json['count'],
      isLike: json['isLike'],
      likeCount: json['likeCount'],
      commentCount: json['commentCount'],
      createdAt: formattedDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userNo': userNo,
      'communityPostNo': communityPostNo,
      'nickname': nickname,
      'profileImg': profileImg,
      'authority': authority,
      'title': title,
      'content': content,
      'imageUrls': imageUrls,
      'postType': postType,
      'count': count,
      'isLike': isLike,
      'likeCount': likeCount,
      'commentCount': commentCount,
      'createdAt': createdAt,
    };
  }
}
