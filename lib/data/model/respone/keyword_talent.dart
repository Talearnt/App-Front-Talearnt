class KeywordTalent {
  final int code;
  final String name;

  KeywordTalent({
    required this.code,
    required this.name,
  });

  factory KeywordTalent.fromJson(Map<String, dynamic> json) {
    return KeywordTalent(
      code: json['talentCode'],
      name: json['talentName'],
    );
  }

  KeywordTalent.copy(KeywordTalent keywordTalent)
      : code = keywordTalent.code,
        name = keywordTalent.name;

  KeywordTalent.empty()
      : code = -1,
        name = "";

  KeywordTalent copyWith({int? code, String? name}) {
    return KeywordTalent(
      code: code ?? this.code,  // null인 경우 기존 값 유지
      name: name ?? this.name,  // null인 경우 기존 값 유지
    );
  }
}
