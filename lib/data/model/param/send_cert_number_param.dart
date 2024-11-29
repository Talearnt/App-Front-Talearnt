class SendCertNumberParam {
  final String phoneNumber;

  SendCertNumberParam({required this.phoneNumber});

  Map<String, dynamic> toJson() {
    return {
      'type': '아이디찾기',
      'phone': phoneNumber,
    };
  }
}
