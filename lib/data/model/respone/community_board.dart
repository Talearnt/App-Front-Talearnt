import 'package:intl/intl.dart';

class CommunityBoard {
  final String postType;
  final String? profileImg;
  final String nickname;
  final String authority;
  final int communityPostNo;
  final String title;
  final String content;
  final int count;
  final int commentCount;
  int likeCount;
  bool isLike;
  final String createdAt;

  CommunityBoard({
    required this.profileImg,
    required this.postType,
    required this.nickname,
    required this.authority,
    required this.communityPostNo,
    required this.title,
    required this.content,
    required this.count,
    required this.commentCount,
    required this.likeCount,
    required this.isLike,
    required this.createdAt,
  });

  factory CommunityBoard.fromJson(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.parse(json['createdAt']);
    String formattedDate = DateFormat('yyyy.MM.dd').format(dateTime);
    return CommunityBoard(
      postType: json['postType'],
      profileImg: json['profileImg'],
      nickname: json['nickname'],
      authority: json['authority'],
      communityPostNo: json['communityPostNo'],
      title: json['title'],
      content: json['content'],
      count: json['count'],
      commentCount: json['commentCount'],
      likeCount: json['likeCount'],
      isLike: json['isLike'],
      createdAt: formattedDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postType': postType,
      'profileImg': profileImg,
      'nickname': nickname,
      'authority': authority,
      'communityPostNo ': communityPostNo,
      'title': title,
      'content': content,
      'count': count,
      'commentCount': commentCount,
      'likeCount': likeCount,
      'isLike': isLike,
      'createdAt': createdAt,
    };
  }
}
