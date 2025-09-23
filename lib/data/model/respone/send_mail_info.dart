class SendMailInfo {
  final String userId, sentDate;
  final bool success;

  SendMailInfo(
      {required this.userId, required this.sentDate, required this.success});

  factory SendMailInfo.fromJson(Map<String, dynamic> json) {
    return SendMailInfo(
      userId: json['data']['userId'],
      sentDate: json['data']['sentDate'],
      success: json['success'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'userId': userId,
        'sentDate': sentDate,
      },
      'success': success,
    };
  }
}
