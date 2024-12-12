class SendCertNumberParam {
  final String type, phoneNumber;
  final String? name;

  SendCertNumberParam({
    required this.type,
    required this.phoneNumber,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'phone': phoneNumber,
      'name': name,
    };
  }
}
