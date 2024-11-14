abstract class ApiConstants {
  static const String baseUrl = "http://3.35.198.221";
  static const String joinUrl = "$baseUrl/v1/api/join";
  static const String joinVerifyCodeUrl = "$baseUrl/v1/api/join/verifyCode";
  static const String joinSmsUrl = "$baseUrl/v1/api/join/sms";
  static const String joinKakaoUrl = "$baseUrl/v1/api/join/kakao";
  static const String refreshTokenUrl = "$baseUrl/v1/api/auth/refresh";
  static const String loginUrl = "$baseUrl/v1/api/auth/login";
  static const String loginKakaoUrl = "$baseUrl/v1/api/auth/login/kakao";
  static const String findUserIdCheckValidUrl =
      "$baseUrl/v1/api/users/verification-code/validation";
  static const String fineUserIdUrl = "$baseUrl/v1/api/users/user-id";
  static const String activeAgreeCodeUrl =
      "$baseUrl/v1/api/admin/agree-codes/active";
  static const String setAgreeCodeUrl = "$baseUrl/v1/api/admin/agree-codes";

  static String getJoinDuplicationIdUrl(String userId) {
    return "$baseUrl/v1/api/join/users/$userId";
  }

  static String getFineUserPwUrl(String userId) {
    return "$baseUrl/v1/api/users/$userId/email";
  }

  static String getFineUserIdSendValidUrl(String phone) {
    return "$baseUrl/v1/api/users/$phone/verification-code";
  }

  static String getChangeUserPwUrl(String no, String uuid) {
    return "$baseUrl/v1/api/users/$no/password/$uuid";
  }
}
