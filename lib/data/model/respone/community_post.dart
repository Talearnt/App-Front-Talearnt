import 'package:intl/intl.dart';

class CommunityPost {
  final String category;
  final String profileImg;
  final String nickname;
  final String authority;
  final int exchangePostNo;
  final String title;
  final String content;
  final String createdAt;
  final int favoriteCount;
  final bool isFavorite;

  CommunityPost({
    required this.profileImg,
    required this.category,
    required this.nickname,
    required this.authority,
    required this.exchangePostNo,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.favoriteCount,
    required this.isFavorite,
  });

  factory CommunityPost.fromJson(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.parse(json['createdAt']);
    String formattedDate = DateFormat('yyyy.MM.dd').format(dateTime);
    return CommunityPost(
      category: json['category'],
      profileImg: json['profileImg'],
      nickname: json['nickname'],
      authority: json['authority'],
      exchangePostNo: json['exchangePostNo'],
      title: json['title'],
      content: json['content'],
      createdAt: formattedDate,
      favoriteCount: json['favoriteCount'],
      isFavorite: json['isFavorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'profileImg': profileImg,
      'nickname': nickname,
      'authority': authority,
      'exchangePostNo': exchangePostNo,
      'title': title,
      'content': content,
      'createdAt': createdAt,
      'favoriteCount': favoriteCount,
      'isFavorite': isFavorite,
    };
  }
}
