class SendCertNumberParam {
  final String phoneNumber, name;

  SendCertNumberParam({
    required this.phoneNumber,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': 'findId',
      'phone': phoneNumber,
      'name': name,
    };
  }
}
