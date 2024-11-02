class TestResponse {
  final String status;
  final String message;
  final Map<String, dynamic>? data;

  TestResponse({
    required this.status,
    required this.message,
    this.data,
  });

  // 서버에서 받은 JSON 데이터를 객체로 변환하는 메서드
  factory TestResponse.fromJson(Map<String, dynamic> json) {
    return TestResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}
