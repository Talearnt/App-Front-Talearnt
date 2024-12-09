import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/dialog.dart';
import 'package:app_front_talearnt/common/widget/toast_message.dart';
import 'package:app_front_talearnt/data/model/param/login_param.dart';
import 'package:app_front_talearnt/data/model/param/send_reset_password_mail_param.dart';
import 'package:app_front_talearnt/provider/auth/login_provider.dart';
import 'package:app_front_talearnt/provider/auth/find_password_provider.dart';
import 'package:app_front_talearnt/data/model/param/send_cert_number_param.dart';
import 'package:app_front_talearnt/data/model/param/find_id_param.dart';
import 'package:app_front_talearnt/provider/auth/find_id_provider.dart';
import 'package:app_front_talearnt/utils/token_manager.dart';
import 'package:flutter/material.dart';

import '../data/repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final LoginProvider loginProvider;
  final FindIdProvider findIdProvider;
  final AuthRepository authRepository;
  final TokenManager tokenManager;
  final FindPasswordProvider findPasswordProvider;

  AuthViewModel(this.loginProvider, this.authRepository, this.tokenManager,
      this.findIdProvider, this.findPasswordProvider);

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
          timer: false, // 타이머 여부 설정
        );
        return; // 다이얼로그를 띄운 후 종료
      },
      (sendMailInfo) {
        findPasswordProvider.setFindedUserIdInfo(
            sendMailInfo.userId, sendMailInfo.createdAt);
      },
    );
  }

  Future<void> sendCertNum(
      BuildContext context, String userName, String phoneNumber) async {
    SendCertNumberParam body =
        SendCertNumberParam(phoneNumber: phoneNumber, name: userName);
    final result = await authRepository.sendCertNumber(body);

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
          timer: false, // 타이머 여부 설정
        );
        return; // 다이얼로그를 띄운 후 종료
      },
      (res) {
        findIdProvider.sendCertNum();
        findIdProvider.startCountdown();
      },
    );
  }

  Future<void> reSendCertNum(
      BuildContext context, String userName, String phoneNumber) async {
    SendCertNumberParam param =
        SendCertNumberParam(phoneNumber: phoneNumber, name: userName);
    final result = await authRepository.sendCertNumber(param);
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
          timer: false, // 타이머 여부 설정
        );
        return; // 다이얼로그를 띄운 후 종료
      },
      (token) {
        findIdProvider.reSendCertNum();
        findIdProvider.resetTimer();
        findIdProvider.startCountdown();
        ToastMessage.show(
            context: context, message: '인증번호를 재요청 하였습니다.', type: 2, bottom: 12);
      },
    );
  }

  Future<void> findUserIdInfo(
      BuildContext context, String phoneNumber, String certNum) async {
    FindIdParam param = FindIdParam(phoneNumber: phoneNumber, certNum: certNum);
    final result = await authRepository.findUserIdInfo(param);
    result.fold(
      (failure) {
        String msg = "알 수 없는 이유로\n인증번호 재발송에 실패하였습니다.\n다시 시도해 주세요.";
        if (failure.errorCode == "404-USER-01") {
          msg = "일치하는 사용자 정보가 없습니다.\n다시 확인해 주세요.";
        } else if (failure.errorCode == "429-AUTH-09") {
          msg = "5회 연속 인증에 실패하였습니다.\n잠시 후 다시 시도해 주세요.";
        } else if (failure.errorCode == "400-AUTH-05") {
          findIdProvider.failedValidChkCertNum();
          return;
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
          timer: false, // 타이머 여부 설정
        );
        return; // 다이얼로그를 띄운 후 종료
      },
      (userIdInfo) {
        findIdProvider.setFindedUserIdInfo(
            userIdInfo.userId, userIdInfo.createdAt);
      },
    );
  }
}
