class Token {
  final String accessToken;

  Token({required this.accessToken});

  Token.empty() : accessToken = '';

  // JSON 응답으로부터 Success 객체를 생성하는 팩토리 메서드
  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json['data']['accessToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {'accessToken': accessToken},
    };
  }
}
