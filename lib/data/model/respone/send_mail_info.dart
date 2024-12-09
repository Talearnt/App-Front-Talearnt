class SendMailInfo {
  final String userId, createdAt;
  final bool success;

  SendMailInfo(
      {required this.userId, required this.createdAt, required this.success});

  factory SendMailInfo.fromJson(Map<String, dynamic> json) {
    return SendMailInfo(
      userId: json['data']['userId'],
      createdAt: json['data']['createdAt'],
      success: json['success'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'userId': userId,
        'createdAt': createdAt,
      },
      'success': success,
    };
  }
}
