class Notice {
  final int noticeNo;
  final String title;
  final String noticeType;
  final DateTime createdAt;
  final String content;

  Notice({
    required this.noticeNo,
    required this.title,
    required this.noticeType,
    required this.createdAt,
    required this.content,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      noticeNo: json['noticeNo'] as int,
      title: json['title'] as String,
      noticeType: json['noticeType'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      content: json['content'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'noticeNo': noticeNo,
      'title': title,
      'noticeType': noticeType,
      'createdAt': createdAt.toIso8601String(),
      'content': content,
    };
  }
}
