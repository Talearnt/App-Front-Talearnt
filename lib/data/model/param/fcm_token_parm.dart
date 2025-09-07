class FcmTokenParm {
  final String fcmToken;
  final String? deviceIdentifier;
  final String? deviceInfo;

  FcmTokenParm({
    required this.fcmToken,
    this.deviceIdentifier,
    this.deviceInfo,
  });

  Map<String, dynamic> toJson() {
    return {
      'fcmToken': fcmToken ?? '',
      'deviceIdentifier': deviceIdentifier ?? '',
      'deviceInfo': deviceInfo ?? '',
    };
  }
}
