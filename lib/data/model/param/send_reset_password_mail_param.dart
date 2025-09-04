class SendResetPasswordMailParam {
  final String phoneNumber;
  final String userId;

  SendResetPasswordMailParam({
    required this.phoneNumber,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phoneNumber,
      'userId': userId,
    };
  }
}
