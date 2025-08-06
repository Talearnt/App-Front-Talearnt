import 'dart:io';

import 'package:app_front_talearnt/data/model/param/community_board_commnet.dart';
import 'package:app_front_talearnt/data/model/param/community_board_reply.dart';
import 'package:app_front_talearnt/data/model/param/event_notice_param.dart';
import 'package:app_front_talearnt/data/model/param/match_board_param.dart';
import 'package:app_front_talearnt/data/model/param/post_comment.dart';
import 'package:app_front_talearnt/data/model/param/post_reply.dart';
import 'package:app_front_talearnt/data/model/param/put_comment.dart';
import 'package:app_front_talearnt/data/model/param/s3_controller_param.dart';
import 'package:app_front_talearnt/data/model/respone/community_comment.dart';
import 'package:app_front_talearnt/data/model/respone/community_reply.dart';
import 'package:app_front_talearnt/data/model/respone/event.dart';
import 'package:app_front_talearnt/data/model/respone/failure.dart';
import 'package:app_front_talearnt/data/model/respone/pagination.dart';
import 'package:app_front_talearnt/data/model/respone/s3_upload_url.dart';
import 'package:app_front_talearnt/data/model/respone/success.dart';
import 'package:app_front_talearnt/data/services/dio_service.dart';
import 'package:dartz/dartz.dart';

import '../../constants/api_constants.dart';
import '../model/param/community_board_list_search_param.dart';
import '../model/param/community_board_param.dart';
import '../model/param/match_board_list_search_param.dart';
import '../model/respone/community_board.dart';
import '../model/respone/community_detail_board.dart';
import '../model/respone/match_board.dart';
import '../model/respone/matching_detail_post.dart';

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

  Future<Either<Failure, Map<String, dynamic>>> getMatchBoardList(
      MatchBoardListSearchParam body) async {
    final response =
        await dio.get(ApiConstants.getMatchBoardListUrl, null, body.toJson());
    return response.fold(left, (response) {
      final posts = List<MatchBoard>.from(
          response['data']['results'].map((data) => MatchBoard.fromJson(data)));
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

  Future<Either<Failure, Success>> editCommunityBoard(
      CommunityBoardParam body, int postNo) async {
    final result = await dio.put(
        ApiConstants.handleCommunityDetailBoard(postNo), body.toJson());

    return result.fold(left, (response) => right(Success.fromJson(response)));
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

  Future<Either<Failure, Map<String, dynamic>>> getCommunityComments(
    int postNo,
    CommunityCommentParam body,
  ) async {
    final response = await dio.get(
      ApiConstants.getCommunityCommnet(postNo),
      null,
      body.toJson(),
    );

    return response.fold(
      left,
      (result) {
        final data = result['data'] as Map<String, dynamic>;
        final rawList = data['results'] as List<dynamic>;

        final comments = rawList
            .map((e) =>
                CommunityCommentResponse.fromJson(e as Map<String, dynamic>))
            .toList();

        final hasNext = (data['pagination']
                as Map<String, dynamic>?)?['hasNext'] as bool? ??
            false;

        return right(<String, dynamic>{
          'comments': comments,
          'hasNext': hasNext,
        });
      },
    );
  }

  Future<Either<Failure, Map<String, dynamic>>> getCommunityReplies(
    int commentNo,
    CommunityReplyParam body,
  ) async {
    final response = await dio.get(
      ApiConstants.getCommunityReply(commentNo),
      null,
      body.toJson(),
    );

    return response.fold(
      left,
      (result) {
        final data = result['data'] as Map<String, dynamic>;
        final rawList = data['results'] as List<dynamic>;

        final comments = rawList
            .map((e) =>
                CommunityReplyResponse.fromJson(e as Map<String, dynamic>))
            .toList();

        final hasNext = (data['pagination']
                as Map<String, dynamic>?)?['hasNext'] as bool? ??
            false;

        return right(<String, dynamic>{
          'comments': comments,
          'hasNext': hasNext,
        });
      },
    );
  }

  Future<Either<Failure, Map<String, dynamic>>> insertCommunityComment(
      PostComment body) async {
    final response = await dio.post(
        ApiConstants.insertCommunityComment, body.toJson(), null);

    return response.fold(
      left,
      (result) {
        final data = result['data'] as Map<String, dynamic>;
        final rawList = data['results'] as List<dynamic>;

        final comments = rawList
            .map((e) =>
                CommunityCommentResponse.fromJson(e as Map<String, dynamic>))
            .toList();

        final hasNext = (data['pagination']
                as Map<String, dynamic>?)?['hasNext'] as bool? ??
            false;

        return right(<String, dynamic>{
          'comments': comments,
          'hasNext': hasNext,
        });
      },
    );
  }

  Future<Either<Failure, Success>> UpdateCommunityComment(
      PutComment body, int commentNo) async {
    final response = await dio.put(
        ApiConstants.updateCommunityComment(commentNo), body.toJson());

    return response.fold(left, (result) => right(Success.fromJson(result)));
  }

  Future<Either<Failure, Success>> deleteCommunityComment(int commentNo) async {
    final response =
        await dio.delete(ApiConstants.deleteCommnunityComment(commentNo));
    return response.fold(left, (result) => right(Success.fromJson(result)));
  }

  Future<Either<Failure, Map<String, dynamic>>> insertCommunityReply(
    PostReply body,
  ) async {
    final response = await dio.post(
      ApiConstants.insertCommunityReply,
      body.toJson(),
      null,
    );

    return response.fold(
      left,
      (result) {
        final data = result['data'] as Map<String, dynamic>;
        final newReply = CommunityReplyResponse.fromJson(data);

        return right(<String, dynamic>{
          'reply': newReply,
        });
      },
    );
  }

  Future<Either<Failure, Success>> deleteReply(int replyNo) async {
    final response =
        await dio.delete(ApiConstants.deleteCommnunityReply(replyNo));
    return response.fold(left, (result) => right(Success.fromJson(result)));
  }

  Future<Either<Failure, Success>> UpdateCommunityReply(
      PutComment body, int replyNo) async {
    final response = await dio.put(
        ApiConstants.updateCommunityReply(replyNo), body.toJson());

    return response.fold(left, (result) => right(Success.fromJson(result)));
  }

  Future<Either<Failure, Success>> handleMatchBoardLike(int postNo) async {
    final response =
        await dio.post(ApiConstants.handleMatchBoardLike(postNo), null, null);
    return response.fold(left, (result) => right(Success.fromJson(result)));
  }

  Future<Either<Failure, Success>> handleCommunityBoardLike(int postNo) async {
    final response = await dio.post(
        ApiConstants.handleCommunityBoardLike(postNo), null, null);
    return response.fold(left, (result) => right(Success.fromJson(result)));
  }

  Future<Either<Failure, Map<String, dynamic>>> getMatchBoardLikeList(
      MatchBoardListSearchParam body) async {
    final response = await dio.get(
        ApiConstants.getMatchBoardLikeListUrl, null, body.toJson());
    return response.fold(left, (response) {
      final posts = List<MatchBoard>.from(
          response['data']['results'].map((data) => MatchBoard.fromJson(data)));
      final pagination = Pagination.fromJson(response['data']['pagination']);
      return right({'posts': posts, 'pagination': pagination});
    });
  }
}
