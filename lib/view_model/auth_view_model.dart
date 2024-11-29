import 'package:app_front_talearnt/data/model/param/login_param.dart';
import 'package:app_front_talearnt/provider/auth/login_provider.dart';
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

  AuthViewModel(
    this.loginProvider,
    this.authRepository,
    this.tokenManager,
    this.findIdProvider,
  );

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

  Future<void> sendCertNum(String userName, String phoneNumber) async {
    SendCertNumberParam param = SendCertNumberParam(phoneNumber: phoneNumber);
    final result = await authRepository.sendCertNumber(userName, param);
    result.fold(
      (failure) {},
      (token) {
        findIdProvider.sendCertNum();
      },
    );
  }

  Future<void> reSendCertNum(String userName, String phoneNumber) async {
    SendCertNumberParam param = SendCertNumberParam(phoneNumber: phoneNumber);
    final result = await authRepository.sendCertNumber(userName, param);
    result.fold(
      (failure) {},
      (token) {
        findIdProvider.reSendCertNum();
      },
    );
  }

  Future<void> findUserIdInfo(String phoneNumber, String certNum) async {
    FindIdParam param = FindIdParam(phoneNumber: phoneNumber, certNum: certNum);
    final result = await authRepository.findUserIdInfo(param);
    result.fold(
      (failure) {},
      (userIdInfo) {
        findIdProvider.setFindedUserIdInfo(
            userIdInfo.userId, userIdInfo.createdAt);
      },
    );
  }
}
