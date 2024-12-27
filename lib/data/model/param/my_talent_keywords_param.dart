class MyTalentKeywordsParam {
  final List<int> giveTalents;
  final List<int> interestTalents;

  MyTalentKeywordsParam(
      {required this.giveTalents, required this.interestTalents});

  // JSON 형태로 변환하기 위한 메서드
  Map<String, dynamic> toJson() {
    return {
      'giveTalents': giveTalents,
      'interestTalents': interestTalents,
    };
  }
}
