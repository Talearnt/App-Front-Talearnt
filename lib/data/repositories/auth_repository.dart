import 'package:app_front_talearnt/data/model/param/find_id_param.dart';
import 'package:app_front_talearnt/data/model/param/send_cert_number_param.dart';
import 'package:app_front_talearnt/data/model/param/send_cert_number_param.dart';
import 'package:app_front_talearnt/data/model/param/send_cert_number_param.dart';
import 'package:app_front_talearnt/data/model/param/send_reset_password_mail_param.dart';
import 'package:app_front_talearnt/data/model/param/sms_validation_param.dart';
import 'package:app_front_talearnt/data/model/param/sms_validation_param.dart';
import 'package:app_front_talearnt/data/model/respone/failure.dart';
import 'package:app_front_talearnt/data/model/respone/send_mail_info.dart';
import 'package:app_front_talearnt/data/model/respone/success.dart';
import 'package:app_front_talearnt/data/model/respone/token.dart';
import 'package:app_front_talearnt/data/model/respone/user_id_info.dart';
import 'package:app_front_talearnt/data/services/dio_service.dart';
import 'package:dartz/dartz.dart';

import '../../utils/api_constants.dart';
import '../model/param/login_param.dart';
import '../model/param/sign_up_param.dart';
import '../services/dio_service.dart';

class AuthRepository {
  final DioService dio = DioService();

  Future<Either<Failure, Token>> login(LoginParam param) async {
    final result = await dio.post(ApiConstants.loginUrl, param.toJson(), null);
    return result.fold(left, (response) => right(Token.fromJson(response)));
  }

  Future<Either<Failure, String>> createRandomNickName() async {
    final result = await dio.get(ApiConstants.nicknameServiceUrl, null, null);
    return result.fold(left, (response) => right(response["data"]));
  }

  Future<Either<Failure, bool>> checkNickNameDuplication(
      String nickName) async {
    final result = await dio
        .get(ApiConstants.nicknameServiceUrl, null, {"nickname": nickName});
    return result.fold(left, (response) => right(response["data"]));
  }

  Future<Either<Failure, bool>> checkEmailDuplication(String email) async {
    final result = await dio
        .get(ApiConstants.checkUserIdDuplication, null, {"userId": email});
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

  Future<Either<Failure, dynamic>> checkSmsValidation(
      SmsValidationParam param) async {
    final result =
        await dio.post(ApiConstants.smsValidUrl, param.toJson(), null);

    return result.fold(
      (failure) => left(failure), // 실패 처리
      (response) {
        final data = response["data"];
        if (data is Map<String, dynamic>) {
          return right(UserIdInfo.fromJson(data));
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

  Future<Either<Failure, UserIdInfo>> findUserIdInfo(FindIdParam param) async {
    final result = await dio.post(ApiConstants.smsValidUrl, param.toJson());
    return result.fold(
        left, (response) => right(UserIdInfo.fromJson(response)));
  }
}
