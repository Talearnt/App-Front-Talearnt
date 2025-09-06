class EventDetail {
  final int eventNo;
  final String title;
  final String content;
  final String bannerUrl;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;
  final bool isActive;

  EventDetail({
    required this.eventNo,
    required this.title,
    required this.content,
    required this.bannerUrl,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.isActive,
  });

  EventDetail.empty()
      : eventNo = 0,
        title = '',
        content = '',
        bannerUrl = '',
        startDate = DateTime.now(),
        endDate = DateTime.now(),
        createdAt = DateTime.now(),
        isActive = false;

  factory EventDetail.fromJson(Map<String, dynamic> json) {
    return EventDetail(
      eventNo: json['eventNo'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      bannerUrl: json['bannerUrl'] ?? '',
      startDate: DateTime.tryParse(json['startDate'] ?? '') ?? DateTime.now(),
      endDate: DateTime.tryParse(json['endDate'] ?? '') ?? DateTime.now(),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      isActive: json['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventNo': eventNo,
      'title': title,
      'content': content,
      'bannerUrl': bannerUrl,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'isActive': isActive,
    };
  }
}
