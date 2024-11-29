class UserIdInfo {
  final String userId, createdAt;
  final bool success;

  UserIdInfo(
      {required this.userId, required this.createdAt, required this.success});

  factory UserIdInfo.fromJson(Map<String, dynamic> json) {
    return UserIdInfo(
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
