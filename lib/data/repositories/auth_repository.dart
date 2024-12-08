import 'package:app_front_talearnt/data/model/respone/failure.dart';
import 'package:app_front_talearnt/data/model/respone/token.dart';
import 'package:app_front_talearnt/data/services/dio_service.dart';
import 'package:dartz/dartz.dart';

import '../../utils/api_constants.dart';
import '../model/param/login_param.dart';

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
        .get(ApiConstants.nicknameServiceUrl, null, {"nickname": nickName}) ;
    return result.fold(left, (response) => right(response["data"]));
  }
}
