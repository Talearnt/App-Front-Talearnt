import 'agree_req_dto.dart';

class SignUpParam {
  final String userId;
  final String pw;
  final String name;
  final String nickname;
  final String gender;
  final String phone;
  final List<AgreeReqDTO> agreeReqDTOS;

  SignUpParam({
    required this.userId,
    required this.pw,
    required this.name,
    required this.nickname,
    required this.gender,
    required this.phone,
    required this.agreeReqDTOS,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "pw": pw,
      "name": name,
      "nickname": nickname,
      "gender": gender,
      "phone": phone,
      "agreeReqDTOS": agreeReqDTOS.map((e) => e.toJson()).toList(),
    };
  }
}
