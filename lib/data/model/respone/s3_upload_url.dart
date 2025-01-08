class S3UploadUrl {
  final List<String> data;
  final String? errorCode;
  final String? errorMessage;
  final bool success;

  S3UploadUrl({
    required this.data,
    this.errorCode,
    this.errorMessage,
    required this.success,
  });

  factory S3UploadUrl.fromJson(Map<String, dynamic> json) {
    return S3UploadUrl(
      data: List<String>.from(json['data'] ?? []),
      errorCode: json['errorCode'],
      errorMessage: json['errorMessage'],
      success: json['success'] ?? false,
    );
  }
}
