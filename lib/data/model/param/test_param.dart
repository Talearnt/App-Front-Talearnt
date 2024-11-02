class TestParam {
  final int testId;
  final String testType;

  TestParam({
    required this.testId,
    required this.testType,
  });

  // 서버에 JSON 형태로 전송하기 위한 변환 메서드
  Map<String, dynamic> toJson() {
    return {
      'testId': testId,
      'testType': testType,
    };
  }
}
