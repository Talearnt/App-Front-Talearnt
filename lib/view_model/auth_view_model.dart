import 'package:app_front_talearnt/data/model/param/login_param.dart';
import 'package:app_front_talearnt/data/model/param/send_cert_number_param.dart';
import 'package:app_front_talearnt/data/model/param/send_reset_password_mail_param.dart';
import 'package:app_front_talearnt/provider/auth/find_id_provider.dart';
import 'package:app_front_talearnt/provider/auth/find_password_provider.dart';
import 'package:app_front_talearnt/provider/auth/login_provider.dart';
import 'package:app_front_talearnt/provider/auth/sign_up_provider.dart';
import 'package:app_front_talearnt/utils/token_manager.dart';
import 'package:flutter/material.dart';

import '../common/widget/button.dart';
import '../common/widget/dialog.dart';
import '../data/model/param/agree_req_dto.dart';
import '../data/model/param/sign_up_param.dart';
import '../data/model/param/sms_validation_param.dart';
import '../data/repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final LoginProvider loginProvider;
  final SignUpProvider signUpProvider;
  final FindIdProvider findIdProvider;
  final AuthRepository authRepository;
  final TokenManager tokenManager;
  final FindPasswordProvider findPasswordProvider;

  AuthViewModel(
    this.loginProvider,
    this.signUpProvider,
    this.authRepository,
    this.tokenManager,
    this.findIdProvider,
    this.findPasswordProvider,
  );

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

  Future<void> createRandomNickName() async {
    final result = await authRepository.createRandomNickName();
    result.fold(
      (failure) => {}, //dialog 띄워줘야됨
      (nickName) {
        signUpProvider.setNickName(nickName);
      },
    );
  }

  Future<void> checkNickNameDuplication(String? nickName) async {
    if (signUpProvider.changeNickName) {
      signUpProvider.updateNickNameChange(false);
      final result = await authRepository.checkNickNameDuplication(nickName!);
      result.fold(
        (failure) => {}, //여기도 dialog 띄우기
        (isNickNameDuplication) {
          signUpProvider.checkNickNameDuplication(isNickNameDuplication);
        },
      );
    }
  }

  Future<void> checkEmailDuplication(String? email) async {
    final result = await authRepository.checkEmailDuplication(email!);
    result.fold((failure) => {}, //여기도 dialog 띄우기
        (isUserIdDuplication) {
      signUpProvider.checkEmailDuplication(isUserIdDuplication);
    });
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

  Future<void> sendCertNum(BuildContext context, String type, String? userName,
      String phoneNumber) async {
    SendCertNumberParam body = SendCertNumberParam(
        type: type, phoneNumber: phoneNumber, name: userName);
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
        if (type == 'findId') {
          findIdProvider.sendCertNum();
          findIdProvider.startCountdown();
        } else {
          signUpProvider.startTimer();
          signUpProvider.updateSendCertNum();
        }
      },
    );
  }

  Future<void> reSendCertNum(BuildContext context, String type,
      String? userName, String phoneNumber) async {
    SendCertNumberParam param = SendCertNumberParam(
        type: type, phoneNumber: phoneNumber, name: userName);
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
      (result) {
        if (type == 'findId') {
          findIdProvider.reSendCertNum();
          findIdProvider.resetTimer();
          findIdProvider.startCountdown();
        } else {
          signUpProvider.reSendCertNum();
          signUpProvider.resetTimer(180);
          signUpProvider.startTimer();
        }
      },
    );
  }

  Future<void> signUpCheckSmsValidation(
      BuildContext context, String phoneNumber, String certNum) async {
    SmsValidationParam param = SmsValidationParam(
        type: 'signUp', phoneNumber: phoneNumber, certNum: certNum);
    final result = await authRepository.checkSmsValidation(param);
    result.fold(
      (failure) {
        String msg = "알 수 없는 이유로\n인증번호 재발송에 실패하였습니다.\n다시 시도해 주세요.";
        if (failure.errorCode == "404-USER-01") {
          msg = "일치하는 사용자 정보가 없습니다.\n다시 확인해 주세요.";
        } else if (failure.errorCode == "429-AUTH-09") {
          msg = "5회 연속 인증에 실패하였습니다.\n잠시 후 다시 시도해 주세요.";
        } else if (failure.errorCode == "400-AUTH-05") {
          signUpProvider.failedValidChkCertNum();
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
      (result) {
        signUpProvider.updateSmsValidation(result);
      },
    );
  }

  Future<void> signUp(String email, String password, String name,
      String nickname, int gender, String phone) async {
    String sex = getGender(gender);
    SignUpParam param = SignUpParam(
        userId: email,
        pw: password,
        name: name,
        nickname: nickname,
        gender: sex,
        phone: phone,
        agreeReqDTOS: [AgreeReqDTO(agreeCodeId: 1, agree: true)]);
    final result = await authRepository.signUp(param);
    result.fold(
      (failure) => {}, //dialog 띄워줘야됨
      (result) {},
    );
  }

  Future<void> findUserIdInfo(
      BuildContext context, String phoneNumber, String certNum) async {
    SmsValidationParam param = SmsValidationParam(
        type: 'findId', phoneNumber: phoneNumber, certNum: certNum);
    final result = await authRepository.checkSmsValidation(param);
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

  String getGender(int gender) {
    if (gender == 0) {
      return '남자';
    } else {
      return '여자';
    }
  }
}
