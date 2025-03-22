import 'dart:io';

import 'package:app_front_talearnt/data/model/param/match_board_param.dart';
import 'package:app_front_talearnt/provider/board/community_write_provider.dart';
import 'package:app_front_talearnt/provider/board/match_edit_provider.dart';
import 'package:app_front_talearnt/provider/home/home_provider.dart';
import 'package:flutter/material.dart';

import '../common/common_navigator.dart';
import '../data/model/param/community_board_list_search_param.dart';
import '../data/model/param/community_board_param.dart';
import '../data/model/param/match_board_list_search_param.dart';
import '../data/model/param/s3_controller_param.dart';
import '../data/repositories/board_repository.dart';
import '../provider/board/community_board_detail_provider.dart';
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
  final CommunityWriteProvider communityWriteProvider;
  final CommunityBoardDetailProvider communityBoardDetailProvider;

  BoardViewModel(
      this.commonNavigator,
      this.boardRepository,
      this.keywordProvider,
      this.matchWriteProvider,
      this.talentBoardProvider,
      this.talentBoardDetailProvider,
      this.matchEditProvider,
      this.communityBoardProvider,
      this.homeProvider,
      this.communityWriteProvider,
      this.communityBoardDetailProvider);

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
      if (type == "MW") {
        matchWriteProvider.setImageUploadUrl(result.data);
      } else if (type == "ME") {
        matchEditProvider.setImageUploadUrl(result.data);
      } else if (type == "CW") {
        communityWriteProvider.setImageUploadUrl(result.data);
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
      if (type == "MW") {
        await matchWriteProvider.exchangeImageUrl(imageUploadUrl, image.path);
      } else if (type == "ME") {
        await matchEditProvider.exchangeImageUrl(imageUploadUrl, image.path);
      } else if (type == "CW") {
        await communityWriteProvider.exchangeImageUrl(
            imageUploadUrl, image.path);
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

  Future<void> getInitMatchBoardList() async {
    MatchBoardListSearchParam param = MatchBoardListSearchParam();
    final result = await boardRepository.getMatchBoardList(param);
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

  Future<void> getMatchBoardList(
      List<String>? giveTalents,
      List<String>? receiveTalents,
      String? order,
      String? duration,
      String? type,
      String? badge,
      String? status,
      String? page,
      String? size,
      String? lastNo,
      String
          searchType) // searchType : reset(새로고침), add(스크롤), new(홈화면), userMatch(유저한테 맞는거 추천)
  async {
    MatchBoardListSearchParam param = MatchBoardListSearchParam(
        giveTalents: giveTalents,
        receiveTalents: receiveTalents,
        order: order,
        duration: duration,
        type: type,
        badge: badge,
        status: status,
        page: page,
        size: size,
        lastNo: lastNo,
        path: "mobile");
    final result = await boardRepository.getMatchBoardList(param);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (result) {
      final posts = result['posts'];
      final pagination = result['pagination'];
      if (searchType == "reset") {
        talentBoardProvider.updateTalentExchangePosts(posts);
        talentBoardProvider.updateTalentExchangePostsPage(pagination);
      } else if (searchType == "add") {
        talentBoardProvider.addTalentExchangePosts(posts);
        talentBoardProvider.updateTalentExchangePostsPage(pagination);
      } else if (searchType == "new") {
        homeProvider.setNewTalentExchangePosts(posts);
      } else {
        homeProvider.setUserMatchingTalentExchangePosts(posts);
      }
    });
  }

  Future<void> getMatchDetailBoard(int postNo) async {
    final result = await boardRepository.getMatchDetailBoard(postNo);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (post) {
      talentBoardDetailProvider.updateTalentDetailPost(post);
      commonNavigator.pushRoute('/match-board-detail-page');
    });
  }

  Future<void> getEditedPostData(int postNo) async {
    final result = await boardRepository.getMatchDetailBoard(postNo);
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

  Future<void> getCommunityDetailBoard(int postNo) async {
    final result = await boardRepository.getCommunityDetailBoard(postNo);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (post) {
      communityBoardDetailProvider.updateCommunityDetailBoard(post);
      commonNavigator.pushRoute('/community-board-detail');
    });
  }

  Future<void> deleteMatchBoard(int postNo) async {
    final result = await boardRepository.deleteMatchBoard(postNo);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)),
        (success) async {
      await getMatchBoardList(
          talentBoardProvider.selectedGiveTalentKeywordCodes
              .map((e) => e.toString())
              .toList(),
          talentBoardProvider.selectedInterestTalentKeywordCodes
              .map((e) => e.toString())
              .toList(),
          talentBoardProvider.selectedOrderType,
          talentBoardProvider.selectedDurationType,
          talentBoardProvider.selectedOperationType,
          null,
          null,
          null,
          null,
          null,
          "mobile");
      commonNavigator.goBack();
      commonNavigator.goBack();
    });
  }

  Future<void> deleteCommunityBoard(int postNo) async {
    final result = await boardRepository.deleteCommunityBoard(postNo);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)),
        (success) async {
      await getCommunityBoardList(communityBoardProvider.selectedPostType,
          communityBoardProvider.selectedOrderType, null, null, null, null);
      commonNavigator.goBack();
      commonNavigator.goBack();
    });
  }
}
