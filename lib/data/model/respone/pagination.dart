class Pagination {
  final bool hasNext;

  Pagination({
    required this.hasNext,
  });

  Pagination.empty() : hasNext = false;

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      hasNext: json['hasNext'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hasNext': hasNext,
    };
  }
}
