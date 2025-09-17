import 'package:intl/intl.dart';

class MatchBoard {
  final String? profileImg;
  final String nickname;
  final String authority;
  final int exchangePostNo;
  String status;
  final String exchangeType;
  final String duration;
  final bool requiredBadge;
  final String title;
  final String content;
  final List<String> giveTalents;
  final List<String> receiveTalents;
  final String createdAt;
  final int openedChatRoomCount;
  int count;

  int favoriteCount;
  bool isFavorite;

  MatchBoard({
    required this.profileImg,
    required this.nickname,
    required this.authority,
    required this.exchangePostNo,
    required this.status,
    required this.exchangeType,
    required this.duration,
    required this.requiredBadge,
    required this.title,
    required this.content,
    required this.giveTalents,
    required this.receiveTalents,
    required this.createdAt,
    required this.openedChatRoomCount,
    required this.count,
    required this.favoriteCount,
    required this.isFavorite,
  });

  factory MatchBoard.fromJson(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.parse(json['createdAt']);
    String formattedDate = DateFormat('yyyy.MM.dd').format(dateTime);
    return MatchBoard(
      profileImg: json['profileImg'],
      nickname: json['nickname'],
      authority: json['authority'],
      exchangePostNo: json['exchangePostNo'],
      status: json['status'],
      exchangeType: json['exchangeType'],
      duration: json['duration'],
      requiredBadge: json['requiredBadge'],
      title: json['title'],
      content: json['content'],
      giveTalents: List<String>.from(json['giveTalents']),
      receiveTalents: List<String>.from(json['receiveTalents']),
      createdAt: formattedDate,
      openedChatRoomCount: json['openedChatRoomCount'],
      count: json['count'],
      favoriteCount: json['favoriteCount'],
      isFavorite: json['isFavorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profileImg': profileImg,
      'nickname': nickname,
      'authority': authority,
      'exchangePostNo': exchangePostNo,
      'status': status,
      'exchangeType': exchangeType,
      'duration': duration,
      'requiredBadge': requiredBadge,
      'title': title,
      'content': content,
      'giveTalents': giveTalents,
      'receiveTalents': receiveTalents,
      'createdAt': createdAt,
      'openedChatRoomCount': openedChatRoomCount,
      'count': count,
      'favoriteCount': favoriteCount,
      'isFavorite': isFavorite,
    };
  }
}
