class S3ControllerParam {
  final List<String> fileNames;
  final String fileType;

  S3ControllerParam({
    required this.fileNames,
    required this.fileType,
  });

  // JSON 변환 메서드
  Map<String, dynamic> toJson() {
    return {
      'fileNames': fileNames,
      'fileType': fileType,
    };
  }
}
