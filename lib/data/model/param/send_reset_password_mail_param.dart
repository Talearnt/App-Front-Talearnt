class SendResetPasswordMailParam {
  final String phoneNumber;

  SendResetPasswordMailParam({
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phoneNumber,
    };
  }
}
