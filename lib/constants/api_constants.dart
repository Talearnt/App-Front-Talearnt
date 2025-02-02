abstract class ApiConstants {
  static const String baseUrl = "http://3.35.198.221";
  static const String joinUrl = "$baseUrl/v1/auth/join";
  static const String joinKakaoUrl = "$baseUrl/v1/auth/join/kakao";
  static const String refreshTokenUrl = "$baseUrl/v1/auth/login/refresh";
  static const String loginUrl = "$baseUrl/v1/auth/login";
  static const String loginKakaoUrl = "$baseUrl/v1/api/auth/login/kakao";
  static const String createRandomNickNameUrl =
      "$baseUrl/v1/auth/users/nickname/random";
  static const String checkNickNameAvailableUrl =
      "$baseUrl/v1/auth/users/nickname/availability";
  static const String checkUserIdDuplicationUrl = "$baseUrl/v1/auth/users/id";

  static const String smsVerifyCodeUrl =
      "$baseUrl/v1/auth/sms/verification-codes"; //인증번호 문자 전송 통합 url (회원가입, 아이디 찾기)

  static const String smsValidUrl =
      "$baseUrl/v1/auth/sms/validation"; //인증 번호 문자 검증 통합 url

  static const String getTalentCategories = "$baseUrl/v1/keywords";
  static const String setMyTalentKeywordsUrl = "$baseUrl/v1/users/my-talents";
  static const String getTalentBoardListUrl = "$baseUrl/v1/posts/exchanges";

  static const String getOfferedKeywords =
      "$baseUrl/v1/posts/exchange/talents/offered";
  static const String insertMatchBoard = "$baseUrl/v1/posts/exchanges";

  static const String getUploadImagesUrl = "$baseUrl/v1/uploads";

  static String getFineUserPwUrl(String userId) {
    return "$baseUrl/v1/auth/password/$userId/email";
  }

  static String getChangeUserPwUrl(String no, String uuid) {
    return "$baseUrl/v1/auth/$no/password/$uuid";
  }
}
