class FindIdParam {
  final String phoneNumber;
  final String certNum;

  FindIdParam({required this.phoneNumber, required this.certNum});

  // 서버에 JSON 형태로 전송하기 위한 변환 메서드
  Map<String, dynamic> toJson() {
    return {
      'type': '아이디찾기',
      'phone': phoneNumber,
      'code': certNum,
    };
  }
}
