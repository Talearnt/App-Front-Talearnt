import '../data/model/respone/token.dart';

class TokenManager {
  Token? _token;

  Token? get token => _token; // Getter 메서드 추가

  TokenManager(this._token);

  void saveToken(Token token) {
    _token = token;
  }

  void resetToken() {
    _token = Token.empty();
  }
}
