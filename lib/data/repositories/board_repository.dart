import 'dart:io';

import 'package:app_front_talearnt/data/model/param/match_board_param.dart';
import 'package:app_front_talearnt/data/model/param/s3_controller_param.dart';
import 'package:app_front_talearnt/data/model/respone/failure.dart';
import 'package:app_front_talearnt/data/model/respone/pagination.dart';
import 'package:app_front_talearnt/data/model/respone/s3_upload_url.dart';
import 'package:app_front_talearnt/data/model/respone/success.dart';
import 'package:app_front_talearnt/data/services/dio_service.dart';
import 'package:dartz/dartz.dart';

import '../../constants/api_constants.dart';
import '../model/param/community_board_list_search_param.dart';
import '../model/param/community_board_param.dart';
import '../model/param/talent_exchange_posts_filter_param.dart';
import '../model/respone/community_board.dart';
import '../model/respone/community_detail_board.dart';
import '../model/respone/matching_detail_post.dart';
import '../model/respone/matching_post.dart';

class BoardRepository {
  final DioService dio;

  BoardRepository(this.dio);

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

  Future<Either<Failure, Success>> editMatchBoard(
      MatchBoardParam body, int postNo) async {
    final result =
        await dio.put(ApiConstants.editMatchBoard(postNo), body.toJson());

    return result.fold(left, (response) => right(Success.fromJson(response)));
  }

  Future<Either<Failure, Map<String, dynamic>>> getTalentExchangePosts(
      TalentExchangePostsFilterParam body) async {
    final response =
        await dio.get(ApiConstants.getTalentBoardListUrl, null, body.toJson());
    return response.fold(left, (response) {
      final posts = List<MatchingPost>.from(response['data']['results']
          .map((data) => MatchingPost.fromJson(data)));
      final pagination = Pagination.fromJson(response['data']['pagination']);
      return right({'posts': posts, 'pagination': pagination});
    });
  }

  Future<Either<Failure, MatchingDetailPost>> getMatchDetailBoard(
      int postNo) async {
    final response =
        await dio.get(ApiConstants.handleMatchDetailBoard(postNo), null, null);
    return response.fold(
        left, (result) => right(MatchingDetailPost.fromJson(result["data"])));
  }

  Future<Either<Failure, Success>> setCommunityBoard(
      CommunityBoardParam body) async {
    final result = await dio.post(
        ApiConstants.handleCommunityBoardUrl, body.toJson(), null);
    return result.fold(left, (response) => right(Success.fromJson(response)));
  }

  Future<Either<Failure, Map<String, dynamic>>> getCommunityBoardList(
      CommunityBoardListSearchParam body) async {
    final response = await dio.get(
        ApiConstants.handleCommunityBoardUrl, null, body.toJson());
    return response.fold(left, (response) {
      final posts = List<CommunityBoard>.from(response['data']['results']
          .map((data) => CommunityBoard.fromJson(data)));
      final pagination = Pagination.fromJson(response['data']['pagination']);
      return right({'posts': posts, 'pagination': pagination});
    });
  }

  Future<Either<Failure, CommunityDetailBoard>> getCommunityDetailBoard(
      int postNo) async {
    final response = await dio.get(
        ApiConstants.handleCommunityDetailBoard(postNo), null, null);
    return response.fold(
        left, (result) => right(CommunityDetailBoard.fromJson(result["data"])));
  }

  Future<Either<Failure, Success>> deleteMatchBoard(int postNo) async {
    final response =
        await dio.delete(ApiConstants.handleMatchDetailBoard(postNo));
    return response.fold(left, (result) => right(Success.fromJson(result)));
  }

  Future<Either<Failure, Success>> deleteCommunityBoard(int postNo) async {
    final response =
        await dio.delete(ApiConstants.handleCommunityDetailBoard(postNo));
    return response.fold(left, (result) => right(Success.fromJson(result)));
  }
}
