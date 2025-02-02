
class Pagination {
  final bool hasNext;
  final bool hasPrevious;
  final int totalPages;
  final int currentPage;

  Pagination({
    required this.hasNext,
    required this.hasPrevious,
    required this.totalPages,
    required this.currentPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      hasNext: json['hasNext'],
      hasPrevious: json['hasPrevious'],
      totalPages: json['totalPages'],
      currentPage: json['currentPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hasNext': hasNext,
      'hasPrevious': hasPrevious,
      'totalPages': totalPages,
      'currentPage': currentPage,
    };
  }
}
