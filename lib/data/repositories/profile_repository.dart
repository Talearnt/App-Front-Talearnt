import 'dart:io';

import 'package:app_front_talearnt/data/model/param/event_notice_param.dart';
import 'package:app_front_talearnt/data/model/param/user_profile_param.dart';
import 'package:app_front_talearnt/data/model/respone/event.dart';
import 'package:app_front_talearnt/data/model/respone/failure.dart';
import 'package:app_front_talearnt/data/model/respone/model.dart';
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

  Future<Either<Failure, Map<String, dynamic>>> getEvent(
      EventNoticeParam body) async {
    final response =
        await dio.get(ApiConstants.getEventUrl, null, body.toJson());

    return response.fold(
      left,
      (resp) {
        final data = resp['data'] as Map<String, dynamic>;

        final events = (data['results'] as List<dynamic>)
            .map((e) => Event.fromJson(e as Map<String, dynamic>))
            .toList();

        final hasNext = data['pagination']['hasNext'] as bool;

        return right({
          'events': events,
          'hasNext': hasNext,
        });
      },
    );
  }

  Future<Either<Failure, Map<String, dynamic>>> getNotice(
      EventNoticeParam body) async {
    final response =
        await dio.get(ApiConstants.getEventUrl, null, body.toJson());

    return response.fold(
      left,
      (resp) {
        final data = resp['data'] as Map<String, dynamic>;

        final notices = (data['results'] as List<dynamic>)
            .map((e) => Notice.fromJson(e as Map<String, dynamic>))
            .toList();

        final hasNext = data['pagination']['hasNext'] as bool;

        return right({
          'notices': notices,
          'hasNext': hasNext,
        });
      },
    );
  }
}
