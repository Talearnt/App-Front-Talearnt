class RecuruitingParam {
  final String status;

  RecuruitingParam({
    required this.status,
  });

  // JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      "status": status,
    };
  }
}
