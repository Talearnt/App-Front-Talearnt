import 'package:intl/intl.dart';

class MatchingDetailPost {
  final int userNo;
  final String nickname;
  final String? profileImg;
  final String? authority;
  final int exchangePostNo;
  final List<String> giveTalents;
  final List<String> receiveTalents;
  final String exchangeType;
  final String status;
  final String createdAt;
  final String duration;
  final bool requiredBadge;
  bool isFavorite;
  final String title;
  final String content;
  final List<String> imageUrls;
  final int count;
  int favoriteCount;
  final int openedChatRoomCount;
  final int chatRoomNo;

  MatchingDetailPost({
    required this.userNo,
    required this.nickname,
    required this.profileImg,
    required this.authority,
    required this.exchangePostNo,
    required this.giveTalents,
    required this.receiveTalents,
    required this.exchangeType,
    required this.status,
    required this.createdAt,
    required this.duration,
    required this.requiredBadge,
    required this.isFavorite,
    required this.title,
    required this.content,
    required this.imageUrls,
    required this.count,
    required this.favoriteCount,
    required this.openedChatRoomCount,
    required this.chatRoomNo,
  });

  MatchingDetailPost.empty()
      : userNo = 0,
        nickname = '',
        profileImg = null,
        authority = null,
        exchangePostNo = 0,
        giveTalents = [],
        receiveTalents = [],
        exchangeType = '',
        status = '',
        createdAt = '',
        duration = '',
        requiredBadge = false,
        isFavorite = false,
        title = '',
        content = '',
        imageUrls = [],
        count = 0,
        favoriteCount = 0,
        openedChatRoomCount = 0,
        chatRoomNo = 0;

  factory MatchingDetailPost.fromJson(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.parse(json['createdAt']);
    String formattedDate = DateFormat('yyyy.MM.dd').format(dateTime);
    return MatchingDetailPost(
      userNo: json['userNo'],
      nickname: json['nickname'],
      profileImg: json['profileImg'],
      authority: json['authority'],
      exchangePostNo: json['exchangePostNo'],
      giveTalents: List<String>.from(json['giveTalents']),
      receiveTalents: List<String>.from(json['receiveTalents']),
      exchangeType: json['exchangeType'],
      status: json['status'],
      createdAt: formattedDate,
      duration: json['duration'],
      requiredBadge: json['requiredBadge'],
      isFavorite: json['isFavorite'],
      title: json['title'],
      content: json['content'],
      imageUrls: List<String>.from(json['imageUrls']),
      count: json['count'],
      favoriteCount: json['favoriteCount'],
      openedChatRoomCount: json['openedChatRoomCount'],
      chatRoomNo: json['chatRoomNo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userNo': userNo,
      'nickname': nickname,
      'profileImg': profileImg,
      'authority': authority,
      'exchangePostNo': exchangePostNo,
      'giveTalents': giveTalents,
      'receiveTalents': receiveTalents,
      'exchangeType': exchangeType,
      'status': status,
      'createdAt': createdAt,
      'duration': duration,
      'requiredBadge': requiredBadge,
      'isFavorite': isFavorite,
      'title': title,
      'content': content,
      'imageUrls': imageUrls,
      'count': count,
      'favoriteCount': favoriteCount,
      'openedChatRoomCount': openedChatRoomCount,
      'chatRoomNo': chatRoomNo,
    };
  }
}
