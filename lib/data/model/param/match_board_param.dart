class MatchBoardParam {
  final String title;
  final String content;
  final List<int> giveTalents;
  final List<int> receiveTalents;
  final String exchangeType;
  final bool requiredBadge;
  final String duration;
  final List<String> imageUrls;

  MatchBoardParam({
    required this.title,
    required this.content,
    required this.giveTalents,
    required this.receiveTalents,
    required this.exchangeType,
    required this.requiredBadge,
    required this.duration,
    required this.imageUrls,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'giveTalents': giveTalents,
      'receiveTalents': receiveTalents,
      'exchangeType': exchangeType,
      'requiredBadge': requiredBadge,
      'duration': duration,
      'imageUrls': imageUrls,
    };
  }
}
