import 'keyword_talent.dart';

class KeywordCategory {
  final int code;
  final String name;
  final List<KeywordTalent> talentKeywords;

  KeywordCategory(
      {required this.code, required this.name, required this.talentKeywords});

  factory KeywordCategory.fromJson(Map<String, dynamic> json) {
    return KeywordCategory(
      code: json['categoryCode'],
      name: json['categoryName'],
      talentKeywords: (json['talents'] as List<dynamic>)
          .map((e) => KeywordTalent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  KeywordCategory.copy(KeywordCategory keywordCategory)
      : code = keywordCategory.code,
        name = keywordCategory.name,
        talentKeywords = keywordCategory.talentKeywords;

  KeywordCategory.empty()
      : code = -1,
        name = "",
        talentKeywords = [];
}
