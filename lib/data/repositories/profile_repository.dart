import 'dart:io';

import 'package:app_front_talearnt/data/model/param/user_profile_param.dart';
import 'package:app_front_talearnt/data/model/respone/failure.dart';
import 'package:app_front_talearnt/data/services/dio_service.dart';
import 'package:dartz/dartz.dart';

import '../../constants/api_constants.dart';
import '../model/param/s3_controller_param.dart';
import '../model/respone/s3_upload_url.dart';
import '../model/respone/user_profile.dart';

class ProfileRepository {
  final DioService dio;

  ProfileRepository(this.dio);

  Future<Either<Failure, UserProfile>> getUserProfile() async {
    final result = await dio.get(ApiConstants.getUserProfile, null, null);
    return result.fold(
        left, (response) => right(UserProfile.fromJson(response["data"])));
  }

  Future<Either<Failure, bool>> checkNickNameDuplication(
      String nickName) async {
    final result = await dio.get(
        ApiConstants.checkNickNameAvailableUrl, null, {"nickname": nickName});
    return result.fold(left, (response) => right(response["data"]));
  }

  Future<Either<Failure, S3UploadUrl>> getUserImageUploadUrl(
      S3ControllerParam body) async {
    final result =
        await dio.post(ApiConstants.getUploadImagesUrl, body.toJson(), null);
    return result.fold(
        left, (response) => right(S3UploadUrl.fromJson(response)));
  }

  Future<Either<Failure, dynamic>> uploadImage(String imageUploadUrl,
      File image, int fileSize, String contentType) async {
   final result = await dio.put(
      imageUploadUrl,
      image.openRead(),
      size: fileSize,
      contentType: contentType,
    );

    return result.fold(left, (response) => right(response));
  }

  Future<Either<Failure, UserProfile>> editUserInfo(
      UserProfileParam body) async {
    final result = await dio.put(ApiConstants.editUserProfile, body.toJson());
    return result.fold(
        left, (response) => right(UserProfile.fromJson(response["data"])));
  }
}
