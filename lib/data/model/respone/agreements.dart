class Agreements {
  final bool marketing;
  final bool advertising;

  Agreements({
    required this.marketing,
    required this.advertising,
  });

  factory Agreements.fromJson(Map<String, dynamic> json) {
    return Agreements(
      marketing: json['marketing'],
      advertising: json['advertising'],
    );
  }
}
