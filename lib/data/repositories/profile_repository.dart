import 'package:app_front_talearnt/data/model/respone/failure.dart';
import 'package:app_front_talearnt/data/services/dio_service.dart';
import 'package:dartz/dartz.dart';

import '../../constants/api_constants.dart';
import '../model/respone/user_profile.dart';

class ProfileRepository {
  final DioService dio;

  ProfileRepository(this.dio);

  Future<Either<Failure, UserProfile>> getUserProfile() async {
    final result = await dio.get(ApiConstants.getUserProfile, null, null);
    return result.fold(
        left, (response) => right(UserProfile.fromJson(response["data"])));
  }
}
