import 'dart:io';

import 'package:app_front_talearnt/data/model/param/match_board_param.dart';
import 'package:flutter/material.dart';

import '../common/common_navigator.dart';
import '../data/model/param/s3_controller_param.dart';
import '../data/model/param/talent_exchange_posts_filter_param';
import '../data/repositories/board_repository.dart';
import '../provider/board/match_board_provider.dart';
import '../provider/board/match_write_provider.dart';
import '../provider/keyword/keyword_provider.dart';
import '../utils/error_message.dart';

class BoardViewModel extends ChangeNotifier {
  final CommonNavigator commonNavigator;
  final BoardRepository boardRepository;
  final KeywordProvider keywordProvider;
  final MatchWriteProvider matchWriteProvider;
  final MatchBoardProvider talentBoardProvider;

  BoardViewModel(
    this.commonNavigator,
    this.boardRepository,
    this.keywordProvider,
    this.matchWriteProvider,
    this.talentBoardProvider,
  );

  Future<void> getImageUploadUrl(
      List<Map<String, dynamic>> uploadImageInfos) async {
    List<S3FileParam> fileParams = uploadImageInfos.map((imageInfo) {
      return S3FileParam(
        fileName: imageInfo["fileName"],
        fileType: imageInfo["fileType"],
        fileSize: imageInfo["fileSize"],
      );
    }).toList();

    S3ControllerParam param = S3ControllerParam(files: fileParams);

    final result = await boardRepository.getImageUploadUrl(param);

    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (result) {
      matchWriteProvider.setImageUploadUrl(result.data);
    });
  }

  Future<void> uploadImage(String imageUploadUrl, File image, int fileSize,
      String contentType) async {
    final result = await boardRepository.uploadImage(
        imageUploadUrl, image, fileSize, contentType);

    result.fold((failure) {
      commonNavigator.showSingleDialog(
          content: ErrorMessages.getMessage(failure.errorCode));
      matchWriteProvider.clearInfos();
    }, (result) {
      matchWriteProvider.exchangeImageUrl(imageUploadUrl, image.path);
    });
  }

  Future<void> insertMatchBoard(
      String title,
      String content,
      List<int> giveTalents,
      List<int> receiveTalents,
      String exchangeType,
      bool? requiredBadge,
      String duration,
      List<String>? urls) async {
    final badge = requiredBadge ?? false;
    final urlList = urls ?? [];
    MatchBoardParam param = MatchBoardParam(
      title: title,
      content: content,
      giveTalents: giveTalents,
      receiveTalents: receiveTalents,
      exchangeType: exchangeType,
      requiredBadge: badge,
      duration: duration,
      urls: urlList,
    );

    final result = await boardRepository.insertMatchBoard(param);

    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (result) {
      commonNavigator.goRoute('/match_write_success');
    });
  }

  Future<void> getInitTalentExchangePosts() async {
    TalentExchangePostsFilterParam param =
        TalentExchangePostsFilterParam.empty();
    final result = await boardRepository.getTalentExchangePosts(param);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (result) {
      final posts = result['posts'];
      final pagination = result['pagination'];
      talentBoardProvider.updateTalentExchangePosts(posts);
      talentBoardProvider.updateTalentExchangePostsPage(pagination);
      commonNavigator.goRoute('/match-board-list');
    });
  }

  Future<void> getTalentExchangePosts(
      List<String>? giveTalents,
      List<String>? receiveTalents,
      String? order,
      String? duration,
      String? type,
      String? badge,
      String? status,
      String? page,
      String? size,
      String? search) async {
    TalentExchangePostsFilterParam param = TalentExchangePostsFilterParam(
        giveTalents: giveTalents,
        receiveTalents: receiveTalents,
        order: order,
        duration: duration,
        type: type,
        badge: badge,
        status: status,
        page: page,
        size: size,
        search: search);
    final result = await boardRepository.getTalentExchangePosts(param);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (result) {
      final posts = result['posts'];
      final pagination = result['pagination'];
      talentBoardProvider.updateTalentExchangePosts(posts);
      talentBoardProvider.updateTalentExchangePostsPage(pagination);
    });
  }

  Future<void> addTalentExchangePosts(
      List<String>? giveTalents,
      List<String>? receiveTalents,
      String? order,
      String? duration,
      String? type,
      String? badge,
      String? status,
      String? page,
      String? size,
      String? search) async {
    TalentExchangePostsFilterParam param = TalentExchangePostsFilterParam(
        giveTalents: giveTalents,
        receiveTalents: receiveTalents,
        order: order,
        duration: duration,
        type: type,
        badge: badge,
        status: status,
        page: page,
        size: size,
        search: search);
    final result = await boardRepository.getTalentExchangePosts(param);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (result) {
      final posts = result['posts'];
      final pagination = result['pagination'];
      talentBoardProvider.addTalentExchangePosts(posts);
      talentBoardProvider.updateTalentExchangePostsPage(pagination);
    });
  }
}
