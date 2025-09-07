class ReadnotificationParam {
  final List<int> notificationNos;

  ReadnotificationParam({
    required this.notificationNos,
  });

  // JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      "notificationNos": notificationNos,
    };
  }
}
