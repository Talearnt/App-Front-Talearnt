import 'dart:io';

import 'package:app_front_talearnt/data/model/param/match_board_param.dart';
import 'package:app_front_talearnt/data/model/param/s3_controller_param.dart';
import 'package:app_front_talearnt/data/model/respone/failure.dart';
import 'package:app_front_talearnt/data/model/respone/keyword_category.dart';
import 'package:app_front_talearnt/data/model/respone/keyword_talent.dart';
import 'package:app_front_talearnt/data/model/respone/s3_upload_url.dart';
import 'package:app_front_talearnt/data/model/respone/success.dart';
import 'package:app_front_talearnt/data/services/dio_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../constants/api_constants.dart';
import '../model/param/my_talent_keywords_param.dart';

class TalentBoardRepository {
  final DioService dio;

  TalentBoardRepository(this.dio);

  Future<Either<Failure, List<KeywordCategory>>> getKeywords() async {
    final result = await dio.get(ApiConstants.getTalentCategories, null, null);
    return result.fold((failure) => left(failure), (response) {
      List<KeywordCategory> categories = List<KeywordCategory>.from(
          response['data'].map((data) => KeywordCategory.fromJson(data)));
      return right(categories);
    });
  }

  Future<Either<Failure, Success>> setMyKeywords(
      MyTalentKeywordsParam body) async {
    final result = await dio.post(
        ApiConstants.setMyTalentKeywordsUrl, body.toJson(), null);
    return result.fold(left, (response) => right(Success.fromJson(response)));
  }

  Future<Either<Failure, List<dynamic>>> getOfferedKeywords() async {
    final result = await dio.get(ApiConstants.getOfferedKeywords, null, null);
    return result.fold((failure) => left(failure), (response) {
      List<dynamic> keywords = List<dynamic>.from(
          response['data'].map((data) => KeywordTalent.fromJson(data)));
      return right(keywords);
    });
  }

  Future<Either<Failure, S3UploadUrl>> getImageUploadUrl(
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

  Future<Either<Failure, Success>> insertMatchBoard(
      MatchBoardParam body) async {
    final result =
        await dio.post(ApiConstants.insertMatchBoard, body.toJson(), null);
    return result.fold(left, (response) => right(Success.fromJson(response)));
  }
}
