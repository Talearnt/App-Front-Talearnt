class SmsValidationParam {
  final String type;
  final String phoneNumber;
  final String certNum;

  SmsValidationParam(
      {required this.type, required this.phoneNumber, required this.certNum});

  // 서버에 JSON 형태로 전송하기 위한 변환 메서드
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'phone': phoneNumber,
      'code': certNum,
    };
  }
}
