class CommunityCommentRespone {
  final int commentNo;
  final String nickname;
  //final String profileImg;
  final String content;
  final DateTime createdAt;
  final int replyCount;

  CommunityCommentRespone({
    required this.commentNo,
    required this.nickname,
    //required this.profileImg,
    required this.content,
    required this.createdAt,
    required this.replyCount,
  });

  factory CommunityCommentRespone.fromJson(Map<String, dynamic> json) {
    return CommunityCommentRespone(
      commentNo: json['commentNo'] as int,
      nickname: json['nickname'] as String,
      //profileImg: json['profileImg'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      replyCount: json['replyCount'] as int,
    );
  }
}
