class ErrorMessages {
  static const Map<String, String> authErrorMessages = {
    "401-AUTH-01": "올바르지 않은 인증 토큰입니다.",
    "401-AUTH-02": "인증 토큰이 만료되었습니다.",
    "401-AUTH-03": "아이디 또는 비밀번호를 확인해주세요!",
    "403-AUTH-04": "접근이 거부되었습니다.",
    "400-AUTH-05": "인증 번호가 틀립니다. 확인 후 다시 입력해주세요",
    "400-AUTH-06": "인증되지 않은 인증 번호입니다. 인증 절차를 완료해 주세요.",
    "400-AUTH-07": "인증 번호 코드를 제대로 입력해주세요.",
    "404-AUTH-08": "10분 이내로 해당 휴대 번호로 발송된 인증 번호가 없습니다.",
    "429-AUTH-09": "5회 연속 인증에 실패하였습니다. 잠시 후 다시 시도해주세요.",
    "404-AUTH-10": "10분이 지나 회원의 비밀번호를 변경할 수 없습니다. 다시 시도해주세요.",
    "400-AUTH-11":
        "이미 다른 SNS 혹은 TALEARNT 계정으로 가입된 아이디입니다. 다른 방법으로 로그인을 시도해주세요.",
    "429-AUTH-12": "많은 요청이 왔습니다. 10분 후에 다시 시도해주세요.",
  };

  static const Map<String, String> messageErrorMessages = {
    "500-MESSAGE-01": "메세지 전송에 실패했습니다. 잠시 후 다시 시도해 주세요.",
  };

  static const Map<String, String> mailErrorMessages = {
    "500-MAIL-01": "메일 전송이 실패하였습니다. 잠시 후 다시 시도해 주세요.",
  };

  static const Map<String, String> termsErrorMessages = {
    "400-TERMS-01": "이용 약관의 제목을 입력해주세요.",
    "400-TERMS-02": "이용약관 버전이 유효하지 않습니다.",
    "400-TERMS-03": "이용 약관 내용을 15자 이상 입력해주세요.",
  };

  static const Map<String, String> userErrorMessages = {
    "404-USER-01": "해당 회원을 찾을 수 없습니다.",
    "400-USER-02": "해당 아이디는 이미 존재합니다.",
    "400-USER-03": "입력된 사용자 정보가 유효하지 않습니다.",
    "403-USER-04": "이 계정은 정지 상태입니다.",
    "400-USER-05": "해당 닉네임은 이미 존재합니다.",
    "400-USER-06": "올바른 이메일 형식으로 입력해 주세요!",
    "400-USER-07": "휴대폰 번호를 정확히 입력해 주세요!",
    "400-USER-08": "영문,숫자,특수 문자를 반드시 포함한 비밀번호를 입력해 주세요!",
    "400-USER-09": "비밀번호는 8자 이상으로 입력해 주세요.",
    "400-USER-10": "성별은 남자,여자만 가능합니다.",
    "400-USER-11": "필수 약관에 대한 동의가 필요합니다.",
    "400-USER-12": "약관 동의를 하지 않았습니다.",
    "404-USER-13": "약관 동의에 실패하였습니다. 반복적으로 발생할 경우 관리자에게 문의하세요.",
    "404-USER-14": "해당 휴대폰 번호로 가입한 회원이 없습니다.",
    "403-USER-15": "해당 아이디는 탈퇴한 회원입니다.",
    "400-USER-16": "두 개의 비밀번호가 일치하지 않습니다.",
    "409-USER-17": "이미 해당 휴대폰 번호로 가입한 회원이 존재합니다.",
    "400-USER-18": "이름은 최소 2자, 최대 5자까지 입력 가능합니다.",
  };

  static const Map<String, String> dbErrorMessages = {
    "500-DB-01": "데이터 베이스에 연결 실패했습니다.",
    "500-DB-02": "데이터 베이스에 잘못된 쿼리 입력되었습니다.",
    "504-DB-03": "데이터베이스 응답 시간이 초과되었습니다.",
    "500-DB-04": "데이터 무결성 위반 오류가 발생했습니다.",
    "500-DB-05": "결과 데이터 크기가 예상과 다릅니다. 1개만 반환해야하는데 2개 이상이 반환되었습니다.",
  };

  static const Map<String, String> requestErrorMessages = {
    "400-REQ-01": "잘못된 요청입니다.",
    "415-REQ-02": "지원되지 않는 미디어 타입입니다.",
    "500-REQ-03": "현재 객체의 상태에서 해당 작업을 수행할 수 없습니다.",
    "429-REQ-09": "짧은 시간에 너무 많은 요청이 왔습니다. 잠시 후 다시 시도해주세요.",
  };

  static const Map<String, String> systemErrorMessages = {
    "503-SYSTEM-01": "서비스를 사용할 수 없습니다. 잠시 후 다시 시도해주세요.",
    "500-SYSTEM-02": "서버 내부 오류가 발생했습니다.",
    "500-UNKNOWN-01": "알 수 없는 오류가 발생했습니다.\n관리자에게 문의하세요.",
  };

  static const Map<String, String> keywordErrorMessages = {
    "400-KEYWORD-01": "대분류 키워드 코드가 중복되었습니다. 다른 번호를 입력하세요.",
    "400-KEYWORD-02": "대분류 키워드 이름이 중복되었습니다. 다른 이름을 입력하세요.",
    "400-KEYWORD-03": "키워드 코드가 잘못 입력되었습니다. 코드를 확인하세요! (최소 단위 1,000)",
    "400-KEYWORD-04": "키워드 이름이 잘못 입력되었습니다. 이름을 확인하세요! (최소 2자 이상)",
    "400-KEYWORD-05": "대분류 키워드 코드가 없습니다.",
    "400-KEYWORD-06": "재능 분류 키워드 코드가 중복됩니다.",
    "400-KEYWORD-07": "재능 분류 키워드 이름이 중복되었습니다. 다른 이름을 입력하세요.",
  };

  static const Map<String, String> postErrorMessages = {
    "400-POST-01": "제목 글자 수 제한을 확인해주세요.",
    "400-POST-02": "제목을 입력해주세요.",
    "400-POST-03": "내용을 입력해주세요.",
    "400-POST-04": "내용 20글자 이상 필수 입력입니다!",
    "400-POST-05": "필수 항목을 입력해 주세요.",
    "400-POST-06": "잘못된 값이 넘어왔습니다. 입력 값을 확인하세요.",
    "400-POST-07": "최대 5개의 재능만 선택하실 수 있습니다.",
    "404-POST-08": "해당 게시글을 찾을 수 없습니다.",
    "403-POST-09": "해당 게시글에 대한 권한이 없습니다.",
  };

  static const Map<String, String> pageErrorMessages = {
    "400-PAGE-01": "페이지 번호는 0보다 작을 수 없습니다.",
    "400-PAGE-02": "해당 페이지 번호는 유효하지 않는 번호입니다.",
  };

  static const Map<String, String> serverErrorMessages = {
    "400-SERVER-01": "잘못된 값을 입력하셨습니다. 입력 값을 확인하세요.",
  };

  static const Map<String, String> commonErrorMessages = {
    "405-COMMON-01": "지원하지 않는 HTTP 메서드입니다.",
    "404-COMMON-02": "요청한 리소스를 찾을 수 없습니다. 경로를 확인하세요.",
    "400-COMMON-03": "잘못된 값이 넘어왔습니다. 입력하신 내용을 확인해주세요.",
    "400-COMMON-04": "입력한 값이 NULL입니다. 입력하신 내용을 확인해주세요.",
  };

  static String getMessage(String errorCode, {String? unknown}) {
    if (authErrorMessages.containsKey(errorCode)) {
      return authErrorMessages[errorCode]!;
    } else if (messageErrorMessages.containsKey(errorCode)) {
      return messageErrorMessages[errorCode]!;
    } else if (mailErrorMessages.containsKey(errorCode)) {
      return mailErrorMessages[errorCode]!;
    } else if (termsErrorMessages.containsKey(errorCode)) {
      return termsErrorMessages[errorCode]!;
    } else if (userErrorMessages.containsKey(errorCode)) {
      return userErrorMessages[errorCode]!;
    } else if (dbErrorMessages.containsKey(errorCode)) {
      return dbErrorMessages[errorCode]!;
    } else if (requestErrorMessages.containsKey(errorCode)) {
      return requestErrorMessages[errorCode]!;
    } else if (systemErrorMessages.containsKey(errorCode)) {
      return systemErrorMessages[errorCode]!;
    } else if (keywordErrorMessages.containsKey(errorCode)) {
      return keywordErrorMessages[errorCode]!;
    } else if (postErrorMessages.containsKey(errorCode)) {
      return postErrorMessages[errorCode]!;
    } else if (pageErrorMessages.containsKey(errorCode)) {
      return pageErrorMessages[errorCode]!;
    } else if (serverErrorMessages.containsKey(errorCode)) {
      return serverErrorMessages[errorCode]!;
    } else if (commonErrorMessages.containsKey(errorCode)) {
      return commonErrorMessages[errorCode]!;
    } else {
      return unknown ?? "알 수 없는 오류가 발생했습니다.\n관리자에게 문의하세요.";
    }
  }
}
