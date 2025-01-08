import 'package:app_front_talearnt/data/model/param/send_cert_number_param.dart';
import 'package:app_front_talearnt/data/model/param/send_reset_password_mail_param.dart';
import 'package:app_front_talearnt/data/model/param/sms_validation_param.dart';
import 'package:app_front_talearnt/data/model/respone/failure.dart';
import 'package:app_front_talearnt/data/model/respone/send_mail_info.dart';
import 'package:app_front_talearnt/data/model/respone/success.dart';
import 'package:app_front_talearnt/data/model/respone/token.dart';
import 'package:app_front_talearnt/data/model/respone/user_id_info.dart';
import 'package:app_front_talearnt/data/services/dio_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import '../../constants/api_constants.dart';
import '../model/param/kakao_sign_up_param.dart';
import '../model/param/login_param.dart';
import '../model/param/sign_up_param.dart';
import '../model/respone/kakao_sign_up_user_info.dart';

class AuthRepository {
  final DioService dio;

  AuthRepository(this.dio);

  Future<Either<Failure, Token>> login(LoginParam param) async {
    final result = await dio.post(ApiConstants.loginUrl, param.toJson(), null);
    return result.fold(left, (response) => right(Token.fromJson(response)));
  }

  Future<Either<Failure, String>> createRandomNickName() async {
    final result =
        await dio.get(ApiConstants.createRandomNickNameUrl, null, null);
    return result.fold(left, (response) => right(response["data"]));
  }

  Future<Either<Failure, bool>> checkNickNameDuplication(
      String nickName) async {
    final result = await dio.get(
        ApiConstants.checkNickNameAvailableUrl, null, {"nickname": nickName});
    return result.fold(left, (response) => right(response["data"]));
  }

  Future<Either<Failure, bool>> checkEmailDuplication(String email) async {
    final result = await dio
        .get(ApiConstants.checkUserIdDuplicationUrl, null, {"userId": email});
    return result.fold(left, (response) => right(response["data"]));
  }

  Future<Either<Failure, Success>> sendCertNumber(
      SendCertNumberParam body) async {
    final result =
        await dio.post(ApiConstants.smsVerifyCodeUrl, body.toJson(), null);

    return result.fold(left, (response) => right(Success.fromJson(response)));
  }

  Future<Either<Failure, Success>> signUp(SignUpParam param) async {
    final result = await dio.post(ApiConstants.joinUrl, param.toJson(), null);

    return result.fold(left, (response) => right(Success.fromJson(response)));
  }

  Future<Either<Failure, Success>> kakaoSignUp(KakaoSignUpParam param) async {
    final result =
        await dio.post(ApiConstants.joinKakaoUrl, param.toJson(), null);

    return result.fold(left, (response) => right(Success.fromJson(response)));
  }

  Future<Either<Failure, dynamic>> checkSmsValidation(
      SmsValidationParam param) async {
    final result =
        await dio.post(ApiConstants.smsValidUrl, param.toJson(), null);

    return result.fold(
      (failure) => left(failure), // 실패 처리
      (response) {
        final data = response["data"];
        if (data is Map<String, dynamic>) {
          return right(UserIdInfo.fromJson(response));
        }
        if (data is bool) {
          return right(data); // UserIdInfo에 맞는 데이터 생성
        }
        // 예기치 못한 데이터 처리
        return left(Failure(
          errorCode: 'INVALID_RESPONSE',
          errorMessage: 'Unexpected data type in response',
          success: false,
        ));
      },
    );
  }

  Future<Either<Failure, SendMailInfo>> sendResetPasswordMail(
      SendResetPasswordMailParam body, String email) async {
    final result = await dio.post(
        ApiConstants.getFineUserPwUrl(email), body.toJson(), null);
    return result.fold(
        left, (response) => right(SendMailInfo.fromJson(response)));
  }

  Future<Either<Failure, KakaoSignUpUserInfo>> kakaoLogin() async {
    try {
      // 카카오톡 설치 여부에 따라 로그인 시도
      final OAuthToken token = await attemptKakaoLogin(); //이거 이후에 운만님 회의 후에 사용 예정
      final result = await getKakaoUserInfo();
      return right(result);
    } catch (error) {
      if (error is PlatformException &&
          (error.code == 'CANCELED' || error.code == 'access_denied')) {
        return left(Failure(
          errorCode: '회원가입 취소',
          errorMessage: '사용자에 의해 취소되었습니다.',
          success: false,
        ));
      }
      return left(Failure(
        errorCode: 'error',
        errorMessage: '알 수 없는 오류가 발생했습니다. 관리자에게 문의하세요.',
        success: false,
      ));
    }
  }

// 카카오톡 설치 여부에 따라 로그인 처리 함수
  Future<OAuthToken> attemptKakaoLogin() async {
    if (await isKakaoTalkInstalled()) {
      try {
        return await UserApi.instance.loginWithKakaoTalk();
      } catch (error) {
        return await UserApi.instance.loginWithKakaoAccount();
      }
    } else {
      return await UserApi.instance.loginWithKakaoAccount();
    }
  }

  Future<KakaoSignUpUserInfo> getKakaoUserInfo() async {
    User kakaoUser = await UserApi.instance.me();
    final kakaoAccount = kakaoUser.kakaoAccount!;
    return KakaoSignUpUserInfo(
      userId: kakaoAccount.email ?? '', // 이메일
      name: kakaoAccount.name ?? '', // 닉네임
      gender: kakaoAccount.gender == Gender.female ? 1 : 0, // 성별
      phone: kakaoAccount.phoneNumber ?? '', // 전화번호
    );
  }
}
