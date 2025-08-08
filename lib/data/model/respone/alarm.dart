class Alarm {
  final String type;
  final String time;
  final String text;
  final bool isRead;

  Alarm({
    required this.type,
    required this.time,
    required this.text,
    this.isRead = true,
  });

  factory Alarm.fromJson(Map<String, dynamic> json) {
    return Alarm(
      type: json['type'],
      time: json['time'],
      text: json['text'],
      isRead: json['isRead'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'time': time,
      'text': text,
      'isRead': isRead,
    };
  }
}
