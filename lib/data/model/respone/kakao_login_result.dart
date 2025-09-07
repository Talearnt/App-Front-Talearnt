class KakaoLoginResult {
  final bool isRegistered;
  final String? accessToken;
  final String? userId;
  final String? name;
  final int? gender;
  final String? phone;

  KakaoLoginResult({
    required this.isRegistered,
    this.accessToken,
    required this.userId,
    required this.name,
    required this.gender,
    required this.phone,
  });

  factory KakaoLoginResult.fromJson(Map<String, dynamic> json) {
    final genderStr = json['gender'];
    int? genderInt;
    if (genderStr == '남자') {
      genderInt = 0;
    } else if (genderStr == '여자') {
      genderInt = 1;
    }
    return KakaoLoginResult(
      isRegistered: json['isRegistered'],
      accessToken: json['accessToken'] as String?,
      userId: json['userId'],
      name: json['name'],
      gender: genderInt,
      phone: json['phone'],
    );
  }
}
