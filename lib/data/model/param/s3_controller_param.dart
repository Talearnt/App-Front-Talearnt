class S3FileParam {
  final String fileName;
  final String fileType;
  final int fileSize;

  S3FileParam({
    required this.fileName,
    required this.fileType,
    required this.fileSize,
  });

  // JSON 변환 메서드
  Map<String, dynamic> toJson() {
    return {
      'fileName': fileName,
      'fileType': fileType,
      'fileSize': fileSize,
    };
  }
}

class S3ControllerParam {
  final List<S3FileParam> files;

  S3ControllerParam({
    required this.files,
  });

  // JSON 변환 메서드
  List<Map<String, dynamic>> toJson() {
    return files.map((file) => file.toJson()).toList();
  }
}
