// event.dart

class Event {
  final int eventNo;
  final String bannerUrl;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;

  Event({
    required this.eventNo,
    required this.bannerUrl,
    required this.startDate,
    required this.endDate,
    required this.isActive,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        eventNo: json['eventNo'] as int,
        bannerUrl: json['bannerUrl'] as String,
        startDate: json['startDate'] != null &&
                (json['startDate'] as String).isNotEmpty
            ? DateTime.parse(json['startDate'] as String)
            : DateTime.now(),
        endDate:
            json['endDate'] != null && (json['endDate'] as String).isNotEmpty
                ? DateTime.parse(json['endDate'] as String)
                : DateTime.now(),
        isActive: json['isActive'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'eventNo': eventNo,
        'bannerUrl': bannerUrl,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'isActive': isActive,
      };
}
