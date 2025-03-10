class CommunityBoardParam {
  final String title;
  final String content;
  final String postType;
  final List<String> imageUrls;

  CommunityBoardParam({
    required this.title,
    required this.content,
    required this.postType,
    required this.imageUrls,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'postType': postType,
      'imageUrls': imageUrls,
    };
  }
}
