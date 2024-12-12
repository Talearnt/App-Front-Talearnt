class AgreeReqDTO {
  final int agreeCodeId;
  final bool agree;

  AgreeReqDTO({
    required this.agreeCodeId,
    required this.agree,
  });

  // JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      "agreeCodeId": agreeCodeId,
      "agree": agree,
    };
  }
}
