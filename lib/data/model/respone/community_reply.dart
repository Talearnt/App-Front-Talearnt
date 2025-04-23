class CommunityReplyResponse {
  final int replyNo;
  final int commentNo;
  final String nickname;
  final String? profileImg;
  final String content;
  final DateTime createdAt;

  CommunityReplyResponse({
    required this.replyNo,
    required this.commentNo,
    required this.nickname,
    this.profileImg,
    required this.content,
    required this.createdAt,
  });

  factory CommunityReplyResponse.fromJson(Map<String, dynamic> json) {
    return CommunityReplyResponse(
      replyNo: json['replyNo'] as int,
      commentNo: json['commentNo'] as int,
      nickname: json['nickname'] as String,
      profileImg: json['profileImg'] as String?,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
