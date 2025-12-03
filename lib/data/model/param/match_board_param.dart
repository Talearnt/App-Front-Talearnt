class MatchBoardParam {
  final String title;
  final String content;
  final List<int> giveTalents;
  final List<int> receiveTalents;
  final bool requiredBadge;
  final String duration;
  final List<String> imageUrls;
  final String hyperLink;

  MatchBoardParam({
    required this.title,
    required this.content,
    required this.giveTalents,
    required this.receiveTalents,
    required this.requiredBadge,
    required this.duration,
    required this.imageUrls,
    required this.hyperLink,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'giveTalents': giveTalents,
      'receiveTalents': receiveTalents,
      'requiredBadge': requiredBadge,
      'duration': duration,
      'imageUrls': imageUrls,
      'hyperLink': hyperLink,
    };
  }
}
