class UserIdInfo {
  final String userId;
  final String sentDate;
  final bool success;
  final String? errorCode;
  final String? errorMessage;

  UserIdInfo({
    required this.userId,
    required this.sentDate,
    required this.success,
    this.errorCode,
    this.errorMessage,
  });

  // JSON -> 객체 변환
  factory UserIdInfo.fromJson(Map<String, dynamic> json) {
    return UserIdInfo(
      success: json['success'] as bool,
      userId: json['data']['userId'] as String,
      sentDate: json['data']['sentDate'] as String,
      errorCode: json['errorCode'] as String?,
      errorMessage: json['errorMessage'] as String?,
    );
  }

  // 객체 -> JSON 변환
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': {
        'userId': userId,
        'sentDate': sentDate,
      },
      'errorCode': errorCode,
      'errorMessage': errorMessage,
    };
  }
}
