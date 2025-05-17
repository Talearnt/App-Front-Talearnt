class PostReply {
  final int commentNo;
  final String content;

  PostReply({
    required this.commentNo,
    required this.content,
  });

  // JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      "commentNo": commentNo,
      "content": content,
    };
  }
}
