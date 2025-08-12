class Notice {
  final int noticeNo;
  final String title;
  final String noticeType;
  final DateTime createdAt;

  Notice({
    required this.noticeNo,
    required this.title,
    required this.noticeType,
    required this.createdAt,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      noticeNo: json['noticeNo'] as int,
      title: json['title'] as String,
      noticeType: json['noticeType'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'noticeNo': noticeNo,
      'title': title,
      'noticeType': noticeType,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
