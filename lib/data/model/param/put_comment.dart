class PutComment {
  final String content;

  PutComment({
    required this.content,
  });

  // JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      "content": content,
    };
  }
}
