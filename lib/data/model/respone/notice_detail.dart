class NoticeDetail {
  final int noticeNo;
  final String title;
  final String content;
  final String noticeType;
  final DateTime createdAt;

  NoticeDetail({
    required this.noticeNo,
    required this.title,
    required this.content,
    required this.noticeType,
    required this.createdAt,
  });

  NoticeDetail.empty()
      : noticeNo = 0,
        title = '',
        content = '',
        noticeType = '',
        createdAt = DateTime.now();

  factory NoticeDetail.fromJson(Map<String, dynamic> json) {
    return NoticeDetail(
      noticeNo: json['noticeNo'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      noticeType: json['noticeType'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'noticeNo': noticeNo,
      'title': title,
      'content': content,
      'noticeType': noticeType,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
