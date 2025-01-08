class KakaoSignUpUserInfo {
  final String userId;
  final String name;
  final int gender;
  final String phone;

  KakaoSignUpUserInfo({
    required this.userId,
    required this.name,
    required this.gender,
    required this.phone,
  });

  factory KakaoSignUpUserInfo.fromJson(Map<String, dynamic> json) {
    return KakaoSignUpUserInfo(
      userId: json['email'],
      name: json['name'],
      gender: json['gender'],
      phone: json['phoneNumber'],
    );
  }
}
