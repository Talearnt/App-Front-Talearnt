class UserProfile {
  final int userNo;
  final String profileImg;
  final String nickname;
  final List<int> giveTalents;
  final List<int> receiveTalents;

  UserProfile({
    required this.userNo,
    required this.profileImg,
    required this.nickname,
    required this.giveTalents,
    required this.receiveTalents,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userNo: json['userNo'] ?? 0,
      profileImg: json['profileImg'] ?? '',
      nickname: json['nickname'] ?? '',
      giveTalents: List<int>.from(json['giveTalents'] ?? []),
      receiveTalents: List<int>.from(json['receiveTalents'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userNo': userNo,
      'profileImg': profileImg,
      'nickname': nickname,
      'giveTalents': giveTalents,
      'receiveTalents': receiveTalents,
    };
  }
}
