import 'dart:io';

import 'package:app_front_talearnt/data/model/param/match_board_param.dart';
import 'package:app_front_talearnt/provider/board/match_edit_provider.dart';
import 'package:app_front_talearnt/provider/home/home_provider.dart';
import 'package:flutter/material.dart';

import '../common/common_navigator.dart';
import '../data/model/param/community_board_list_search_param.dart';
import '../data/model/param/community_board_param.dart';
import '../data/model/param/s3_controller_param.dart';
import '../data/model/param/talent_exchange_posts_filter_param.dart';
import '../data/repositories/board_repository.dart';
import '../provider/board/community_board_provider.dart';
import '../provider/board/match_board_detail_provider.dart';
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
  final MatchBoardDetailProvider talentBoardDetailProvider;
  final MatchEditProvider matchEditProvider;
  final CommunityBoardProvider communityBoardProvider;
  final HomeProvider homeProvider;

  BoardViewModel(
      this.commonNavigator,
      this.boardRepository,
      this.keywordProvider,
      this.matchWriteProvider,
      this.talentBoardProvider,
      this.talentBoardDetailProvider,
      this.matchEditProvider,
      this.communityBoardProvider,
      this.homeProvider);

  Future<void> getImageUploadUrl(
      List<Map<String, dynamic>> uploadImageInfos, String type) async {
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
            content: ErrorMessages.getMessage(failure.errorCode)),
        (result) async {
      if (type == "W") {
        matchWriteProvider.setImageUploadUrl(result.data);
      } else if (type == "E") {
        matchEditProvider.setImageUploadUrl(result.data);
      }
    });
  }

  Future<void> uploadImage(String imageUploadUrl, File image, int fileSize,
      String contentType, String type) async {
    final result = await boardRepository.uploadImage(
        imageUploadUrl, image, fileSize, contentType);

    result.fold((failure) {
      commonNavigator.showSingleDialog(
          content: ErrorMessages.getMessage(failure.errorCode));
      matchWriteProvider.clearInfos();
    }, (result) async {
      if (type == "W") {
        await matchWriteProvider.exchangeImageUrl(imageUploadUrl, image.path);
      } else if (type == "E") {
        await matchEditProvider.exchangeImageUrl(imageUploadUrl, image.path);
      }
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
      List<String>? imageUrls) async {
    final badge = requiredBadge ?? false;
    final urlList = imageUrls ?? [];
    MatchBoardParam param = MatchBoardParam(
      title: title,
      content: content,
      giveTalents: giveTalents,
      receiveTalents: receiveTalents,
      exchangeType: exchangeType,
      requiredBadge: badge,
      duration: duration,
      imageUrls: urlList,
    );

    final result = await boardRepository.insertMatchBoard(param);

    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (result) {
      commonNavigator.goRoute('/write-success');
    });
  }

  Future<void> editMatchBoard(
    String title,
    String content,
    List<int> giveTalents,
    List<int> receiveTalents,
    String exchangeType,
    bool? requiredBadge,
    String duration,
    List<String>? imageUrls,
    int postNo,
  ) async {
    final badge = requiredBadge ?? false;
    final urlList = imageUrls ?? [];
    MatchBoardParam param = MatchBoardParam(
      title: title,
      content: content,
      giveTalents: giveTalents,
      receiveTalents: receiveTalents,
      exchangeType: exchangeType,
      requiredBadge: badge,
      duration: duration,
      imageUrls: urlList,
    );

    final result = await boardRepository.editMatchBoard(param, postNo);

    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)),
        (result) async {
      await getEditedPostData(postNo);
    });
  }

  Future<void> getInitTalentExchangePosts() async {
    TalentExchangePostsFilterParam param = TalentExchangePostsFilterParam();
    final result = await boardRepository.getTalentExchangePosts(param);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (result) {
      final posts = result['posts'];
      final pagination = result['pagination'];
      talentBoardProvider.updateTalentExchangePosts(posts);
      talentBoardProvider.updateTalentExchangePostsPage(pagination);
      commonNavigator.goRoute('/board-list');
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

  Future<void> getTalentDetailPost(int postNo) async {
    final result = await boardRepository.getTalentDetailPost(postNo);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (post) {
      talentBoardDetailProvider.updateTalentDetailPost(post);
      commonNavigator.pushRoute('/match-board-detail-page');
    });
  }

  Future<void> getEditedPostData(int postNo) async {
    final result = await boardRepository.getTalentDetailPost(postNo);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (post) {
      talentBoardDetailProvider.updateTalentDetailPost(post);
      commonNavigator.goRoute('/match-board-detail-page');
    });
  }

  Future<void> setCommunityBoard(String title, String content, String postType,
      List<String>? imageUrls) async {
    final urlList = imageUrls ?? [];
    CommunityBoardParam param = CommunityBoardParam(
      title: title,
      content: content,
      postType: postType,
      imageUrls: urlList,
    );

    final result = await boardRepository.setCommunityBoard(param);

    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (result) {
      commonNavigator.goRoute('/write-success');
    });
  }

  Future<void> getCommunityBoardList(String? postType, String? order,
      String? path, String? page, String? size, String? lastNo) async {
    CommunityBoardListSearchParam param = CommunityBoardListSearchParam(
        postType: postType,
        order: order,
        path: path,
        page: page,
        size: size,
        lastNo: lastNo);
    final result = await boardRepository.getCommunityBoardList(param);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (result) {
      final posts = result['posts'];
      final pagination = result['pagination'];
      communityBoardProvider.updateCommunityBoardList(posts);
      communityBoardProvider.updateCommunityBoardListPage(pagination);
    });
  }

  Future<void> addCommunityBoardList(String? postType, String? order,
      String? path, String? page, String? size, String? lastNo) async {
    CommunityBoardListSearchParam param = CommunityBoardListSearchParam(
        postType: postType,
        order: order,
        path: path,
        page: page,
        size: size,
        lastNo: lastNo);
    final result = await boardRepository.getCommunityBoardList(param);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (result) {
      final posts = result['posts'];
      final pagination = result['pagination'];
      communityBoardProvider.addCommunityBoardList(posts);
      communityBoardProvider.updateCommunityBoardListPage(pagination);
    });
  }

  Future<void> getNewTalentExchangePosts(
    List<String>? giveTalents,
    List<String>? receiveTalents,
    String? order,
    String? duration,
    String? type,
    String? badge,
    String? status,
    String? page,
    String? size,
    String? search,
  ) async {
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
      homeProvider.setNewTalentExchangePosts(posts);
    });
  }

  Future<void> getBestCommunityBoardList(String? postType, String? order,
      String? path, String? page, String? size, String? lastNo) async {
    CommunityBoardListSearchParam param = CommunityBoardListSearchParam(
        postType: postType,
        order: order,
        path: path,
        page: page,
        size: size,
        lastNo: lastNo);
    final result = await boardRepository.getCommunityBoardList(param);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (result) {
      final posts = result['posts'];
      homeProvider.setBestCommunityBoardList(posts);
    });
  }

  Future<void> getUserMatchingTalentExchangePosts(
    List<String>? giveTalents,
    List<String>? receiveTalents,
    String? order,
    String? duration,
    String? type,
    String? badge,
    String? status,
    String? page,
    String? size,
    String? search,
  ) async {
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
      homeProvider.setUserMatchingTalentExchangePosts(posts);
    });
  }
}
