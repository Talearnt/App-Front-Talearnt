import 'package:app_front_talearnt/data/model/param/send_reset_password_mail_param.dart';
import 'package:app_front_talearnt/data/model/respone/failure.dart';
import 'package:app_front_talearnt/data/model/respone/send_mail_info.dart';
import 'package:app_front_talearnt/data/model/respone/success.dart';
import 'package:app_front_talearnt/data/model/respone/token.dart';
import 'package:app_front_talearnt/data/services/dio_service.dart';
import 'package:app_front_talearnt/data/model/param/find_id_param.dart';
import 'package:app_front_talearnt/data/model/param/send_cert_number_param.dart';
import 'package:app_front_talearnt/data/model/respone/user_id_info.dart';
import 'package:dartz/dartz.dart';

import '../../utils/api_constants.dart';
import '../model/param/login_param.dart';

class AuthRepository {
  final DioService dio = DioService();

  Future<Either<Failure, Token>> login(LoginParam param) async {
    final result = await dio.post(ApiConstants.loginUrl, param.toJson(), null);
    return result.fold(left, (response) => right(Token.fromJson(response)));
  }

  Future<Either<Failure, SendMailInfo>> sendResetPasswordMail(
      SendResetPasswordMailParam body, String email) async {
    final result = await dio.post(
        ApiConstants.getFineUserPwUrl(email), body.toJson(), null);
    return result.fold(
        left, (response) => right(SendMailInfo.fromJson(response)));
    
  Future<Either<Failure, Success>> sendCertNumber(
      SendCertNumberParam body) async {
    final result =
        await dio.post(ApiConstants.smsVerifyCodeUrl, body.toJson(), null);

    return result.fold(left, (response) => right(Success.fromJson(response)));
  }

  Future<Either<Failure, UserIdInfo>> findUserIdInfo(FindIdParam body) async {
    final result =
        await dio.post(ApiConstants.smsValidUrl, body.toJson(), null);
    return result.fold(
        left, (response) => right(UserIdInfo.fromJson(response)));
  }
}
