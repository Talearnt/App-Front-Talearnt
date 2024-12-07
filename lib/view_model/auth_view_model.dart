import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/dialog.dart';
import 'package:app_front_talearnt/data/model/param/login_param.dart';
import 'package:app_front_talearnt/data/model/param/send_reset_password_mail_param.dart';
import 'package:app_front_talearnt/data/model/respone/send_mail_info.dart';
import 'package:app_front_talearnt/provider/auth/login_provider.dart';
import 'package:app_front_talearnt/provider/auth/find_password_provider.dart';
import 'package:app_front_talearnt/utils/token_manager.dart';
import 'package:flutter/material.dart';

import '../data/repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final LoginProvider loginProvider;
  final AuthRepository authRepository;
  final TokenManager tokenManager;
  final FindPasswordProvider findPasswordProvider;

  AuthViewModel(this.loginProvider, this.authRepository, this.tokenManager,
      this.findPasswordProvider);

  // API 데이터 요청을 시뮬레이션하는 메서드
  Future<void> login(String email, String pw) async {
    LoginParam param = LoginParam(userId: email, pw: pw);
    final result = await authRepository.login(param);
    result.fold(
      (failure) => loginProvider.updateLoginFormFail(failure.errorMessage),
      (token) {
        tokenManager.saveToken(token);
        loginProvider.updateLoginFormSuccess();
      },
    );
  }

  Future<void> sendResetPasswordEmail(
      BuildContext context, String email, String phoneNumber) async {
    SendResetPasswordMailParam body =
        SendResetPasswordMailParam(phoneNumber: phoneNumber);
    final result = await authRepository.sendResetPasswordMail(body, email);

    result.fold(
      (failure) {
        String msg = "알 수 없는 이유로\n인증번호 재발송에 실패하였습니다.\n다시 시도해 주세요.";
        if (failure.errorCode == "404-USER-01") {
          msg = "일치하는 사용자 정보가 없습니다.\n다시 확인해 주세요.";
        }

        SingleBtnDialog.show(
          context,
          content: msg,
          button: PrimaryM(
            content: '확인',
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          timer: false,
        );
        return;
      },
      (sendMailInfo) {
        findPasswordProvider.setFindedUserIdInfo(
            sendMailInfo.userId, sendMailInfo.createdAt);
      },
    );
  }
}
