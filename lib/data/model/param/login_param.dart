class LoginParam {
  final String userId;
  final String pw;
  final bool autoLogin;

  LoginParam({required this.userId, required this.pw, required this.autoLogin});

  // 서버에 JSON 형태로 전송하기 위한 변환 메서드
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'pw': pw,
      'autoLogin': autoLogin,
    };
  }
}
