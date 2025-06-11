class CommunityCommentResponse {
  final int userNo;
  final int commentNo;
  final String nickname;
  final String? profileImg;
  final String content;
  final DateTime createdAt;
  final bool isDeleted;
  final int replyCount;

  CommunityCommentResponse({
    required this.userNo,
    required this.commentNo,
    required this.nickname,
    this.profileImg,
    required this.content,
    required this.createdAt,
    required this.isDeleted,
    required this.replyCount,
  });

  factory CommunityCommentResponse.fromJson(Map<String, dynamic> json) {
    return CommunityCommentResponse(
      userNo: json['userNo'] as int,
      commentNo: json['commentNo'] as int,
      nickname: json['nickname'] as String,
      profileImg: json['profileImg'] as String?,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isDeleted: json['isDeleted'] as bool,
      replyCount: json['replyCount'] as int,
    );
  }
}
