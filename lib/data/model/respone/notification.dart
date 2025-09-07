class NotificationData {
  final int notificationNo;
  final String senderNickname;
  final int targetNo;
  final String content;
  final String notificationType;
  final List<int> talentCodes;
  final bool isRead;
  final int unreadCount;
  final DateTime createdAt;

  NotificationData({
    required this.notificationNo,
    required this.senderNickname,
    required this.targetNo,
    required this.content,
    required this.notificationType,
    required this.talentCodes,
    required this.isRead,
    required this.unreadCount,
    required this.createdAt,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      notificationNo: json['notificationNo'] ?? 0,
      senderNickname: json['senderNickname'] ?? '',
      targetNo: json['targetNo'] ?? 0,
      content: json['content'] ?? '',
      notificationType: json['notificationType'] ?? '',
      talentCodes: List<int>.from(json['talentCodes'] ?? []),
      isRead: json['isRead'] ?? false,
      unreadCount: json['unreadCount'] ?? 0,
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationNo': notificationNo,
      'senderNickname': senderNickname,
      'targetNo': targetNo,
      'content': content,
      'notificationType': notificationType,
      'talentCodes': talentCodes,
      'isRead': isRead,
      'unreadCount': unreadCount,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
