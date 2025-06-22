class
UserProfileParam {
  final String? profileImg;
  final String nickname;
  final List<int> giveTalents;
  final List<int> receiveTalents;

  UserProfileParam({
    required this.profileImg,
    required this.nickname,
    required this.giveTalents,
    required this.receiveTalents,
  });

  Map<String, dynamic> toJson() {
    return {
      'profileImg': profileImg,
      'nickname': nickname,
      'giveTalents': giveTalents,
      'receiveTalents': receiveTalents,
    };
  }
}
