class Failure {
  final String? data;
  final String errorCode;
  final String errorMessage;
  final bool success;

  Failure({
    this.data,
    required this.errorCode,
    required this.errorMessage,
    required this.success,
  });

  // JSON 형태로부터 Failure 객체를 생성하는 팩토리 메서드
  factory Failure.fromJson(Map<String, dynamic> json) {
    return Failure(
      data: json['data'],
      errorCode: json['errorCode'],
      errorMessage: json['errorMessage'],
      success: json['success'],
    );
  }
}
