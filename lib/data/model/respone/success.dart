class Success {
  final dynamic data;
  final String? errorCode;
  final String? errorMessage;
  final bool success;

  Success({
    this.data,
    required this.errorCode,
    required this.errorMessage,
    required this.success,
  });

  Success.empty() :  data = 0,
        errorCode = null,
        errorMessage = null,
        success = true;

  factory Success.fromJson(Map<String, dynamic> json) {
    return Success(
      data: json['data'],
      errorCode: json['errorCode'],
      errorMessage: json['errorMessage'],
      success: json['success'],
    );
  }
}
