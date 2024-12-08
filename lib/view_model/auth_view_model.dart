import 'package:app_front_talearnt/data/model/param/login_param.dart';
import 'package:app_front_talearnt/provider/auth/login_provider.dart';
import 'package:app_front_talearnt/provider/auth/sign_up_provider.dart';
import 'package:app_front_talearnt/utils/token_manager.dart';
import 'package:flutter/material.dart';

import '../data/repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final LoginProvider loginProvider;
  final SignUpProvider signUpProvider;
  final AuthRepository authRepository;
  final TokenManager tokenManager;

  AuthViewModel(this.signUpProvider, this.loginProvider, this.authRepository,
      this.tokenManager);

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
}
