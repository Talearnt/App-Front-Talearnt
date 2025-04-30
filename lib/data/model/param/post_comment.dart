class PostComment {
  final int communityPostNo;
  final String content;
  final String path;

  PostComment({
    required this.communityPostNo,
    required this.content,
    this.path = "mobile",
  });

  // JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      "communityPostNo": communityPostNo,
      "content": content,
      "path": path,
    };
  }
}
