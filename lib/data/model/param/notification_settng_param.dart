class NotificationSettngParam {
  final bool allowKeywordNotifications;
  final bool allowCommentNotifications;

  NotificationSettngParam(
      {required this.allowKeywordNotifications,
      required this.allowCommentNotifications});

  // JSON 형태로 변환하기 위한 메서드
  Map<String, dynamic> toJson() {
    return {
      'allowKeywordNotifications': allowKeywordNotifications,
      'allowCommentNotifications': allowCommentNotifications,
    };
  }
}
