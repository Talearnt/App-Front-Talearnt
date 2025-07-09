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
  static const String getUserProfile = "$baseUrl/v1/users/header/profile";
  static const String editUserProfile = "$baseUrl/v1/users/profile";

  static const String smsVerifyCodeUrl =
      "$baseUrl/v1/auth/sms/verification-codes"; //인증번호 문자 전송 통합 url (회원가입, 아이디 찾기)

  static const String smsValidUrl =
      "$baseUrl/v1/auth/sms/validation"; //인증 번호 문자 검증 통합 url

  static const String getTalentCategories = "$baseUrl/v1/keywords";
  static const String setMyTalentKeywordsUrl = "$baseUrl/v1/users/my-talents";
  static const String getMatchBoardListUrl = "$baseUrl/v1/posts/exchanges";

  static const String getOfferedKeywords =
      "$baseUrl/v1/posts/exchange/talents/offered";
  static const String insertMatchBoard = "$baseUrl/v1/posts/exchanges";
  static const String handleCommunityBoardUrl = "$baseUrl/v1/posts/communities";

  static const String getUploadImagesUrl = "$baseUrl/v1/uploads";

  static const String insertCommunityComment =
      "$baseUrl/v1/communities/comments";

  static const String insertCommunityReply = "$baseUrl/v1/communities/replies";

  static String handleCommunityBoardLike(int postNo) {
    return "$baseUrl/v1/posts/communities/$postNo/like";
  }

  static String handleMatchDetailBoard(int postNo) {
    return "$baseUrl/v1/posts/exchanges/$postNo";
  }

  static String handleMatchBoardLike(int postNo) {
    return "$baseUrl/v1/posts/exchanges/$postNo/favorite";
  }

  static String handleCommunityDetailBoard(int postNo) {
    return "$baseUrl/v1/posts/communities/$postNo";
  }

  static String getFineUserPwUrl(String userId) {
    return "$baseUrl/v1/auth/password/$userId/email";
  }

  static String getChangeUserPwUrl(String no, String uuid) {
    return "$baseUrl/v1/auth/$no/password/$uuid";
  }

  static String editMatchBoard(int postNo) {
    return "$baseUrl/v1/posts/exchanges/$postNo";
  }

  static String getCommunityCommnet(int postNo) {
    return "$baseUrl/v1/communities/$postNo/comments";
  }

  static String getCommunityReply(int commentNo) {
    return "$baseUrl/v1/communities/$commentNo/replies";
  }

  static String updateCommunityComment(int commentNo) {
    return "$baseUrl/v1/communities/comments/$commentNo";
  }

  static String deleteCommnunityReply(int replyNo) {
    return "$baseUrl/v1/communities/replies/$replyNo";
  }

  static String updateCommunityReply(int replyNo) {
    return "$baseUrl/v1/communities/replies/$replyNo";
  }

  static String deleteCommnunityComment(int commentNo) {
    return "$baseUrl/v1/communities/comments/$commentNo";
  }
}
