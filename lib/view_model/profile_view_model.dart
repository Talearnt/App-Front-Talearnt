import 'dart:io';

import 'package:app_front_talearnt/data/model/param/match_board_list_search_param.dart';
import 'package:flutter/material.dart';

import '../common/common_navigator.dart';
import '../data/model/param/community_board_list_search_param.dart';
import '../data/model/param/s3_controller_param.dart';
import '../data/model/param/user_profile_param.dart';
import '../data/repositories/profile_repository.dart';
import '../provider/profile/profile_provider.dart';
import '../utils/error_message.dart';

class ProfileViewModel extends ChangeNotifier {
  final CommonNavigator commonNavigator;
  final ProfileRepository profileRepository;
  final ProfileProvider profileProvider;

  ProfileViewModel(
    this.commonNavigator,
    this.profileRepository,
    this.profileProvider,
  );

  Future<void> getUserProfile(String root) async {
    final result = await profileRepository.getUserProfile();

    result.fold(
      (failure) => commonNavigator.showSingleDialog(
          content: ErrorMessages.getMessage(
        failure.errorCode,
      )), //dialog 띄워줘야됨
      (userProfile) {
        profileProvider.setUserProfile(userProfile);
        if (userProfile.receiveTalents.isEmpty &&
            userProfile.giveTalents.isEmpty) {
          commonNavigator.goRoute('/set-keyword');
        } else {
          if (root == "profile") {
            commonNavigator.goRoute('/profile');
          } else if (root == "login") {
            commonNavigator.goRoute('/');
          }
        }
      },
    );
  }

  Future<void> checkEditNickNameDuplication(String? nickName) async {
    if (profileProvider.changeEditNickName) {
      profileProvider.updateEditNickNameChange(false);
      final result =
          await profileRepository.checkNickNameDuplication(nickName!);
      result.fold(
        (failure) => commonNavigator.showSingleDialog(
          content: ErrorMessages.getMessage(failure.errorCode),
        ),
        (isNickNameDuplication) {
          profileProvider.checkEditNickNameDuplication(isNickNameDuplication);
        },
      );
    }
  }

  //3s에 올라갈 url 받아오기
  Future<void> getUserImageUploadUrl(Map<String, dynamic> userImageInfo) async {
    List<S3FileParam> fileParam = [
      S3FileParam(
        fileName: userImageInfo["fileName"],
        fileType: userImageInfo["fileType"],
        fileSize: userImageInfo["fileSize"],
      )
    ];
    S3ControllerParam param = S3ControllerParam(files: fileParam);

    final result = await profileRepository.getUserImageUploadUrl(param);

    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)),
        (result) async {
      await profileProvider.setImageUploadUrl(result.data[0]);
    });
  }

  //3s에 올라간 결과 url 받아오기
  Future<void> uploadImage(String imageUploadUrl, File image, int fileSize,
      String contentType) async {
    final result = await profileRepository.uploadImage(
        imageUploadUrl, image, fileSize, contentType);

    result.fold((failure) {
      commonNavigator.showSingleDialog(
          content: ErrorMessages.getMessage(failure.errorCode));
      profileProvider.clearInfo();
    }, (result) async {
      await profileProvider.finishImageUpload(imageUploadUrl);
    });
  }

  Future<bool> editUserInfo(String? profileImg, String nickname,
      List<int> giveTalents, List<int> receiveTalents) async {
    UserProfileParam param = UserProfileParam(
        profileImg: profileImg,
        nickname: nickname,
        giveTalents: giveTalents,
        receiveTalents: receiveTalents);
    final result = await profileRepository.editUserInfo(param);
    bool success = false;

    await result.fold((failure) async {
      profileProvider.finishEditUserInfo();
      commonNavigator.showSingleDialog(
        content: ErrorMessages.getMessage(failure.errorCode),
      );
      success = false;
    }, (profile) async {
      await profileProvider.setUserProfile(profile);
      profileProvider.finishEditUserInfo();
      success = true;
    });

    return success;
  }

  Future<void> getMyWriteMatchBoardList(
      String? page, String? size, String? lastNo, String searchType) async {
    MatchBoardListSearchParam param = MatchBoardListSearchParam(
        giveTalents: null,
        receiveTalents: null,
        order: null,
        duration: null,
        type: null,
        badge: null,
        status: null,
        page: page,
        size: size,
        lastNo: lastNo);
    final result = await profileRepository.getMyWriteMatchBoardList(param);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (result) {
      final posts = result['posts'];
      final pagination = result['pagination'];

      if (searchType == "reset") {
        profileProvider.updateMatchPosts(posts);
        profileProvider.updateMyWriteMatchPage(pagination);
      } else if (searchType == "add") {
        profileProvider.addMatchBoardPosts(posts);
        profileProvider.updateMyWriteMatchPage(pagination);
      }
    });
  }

  Future<void> getMyWriteCommunityBoardList(String? postType, String? order,
      String? page, String? size, String? lastNo, String searchType) async {
    CommunityBoardListSearchParam param = CommunityBoardListSearchParam(
        postType: postType,
        order: order,
        page: page,
        size: size,
        lastNo: lastNo);
    final result = await profileRepository.getMyWriteCommunityBoardList(param);
    result.fold(
        (failure) => commonNavigator.showSingleDialog(
            content: ErrorMessages.getMessage(failure.errorCode)), (result) {
      final posts = result['posts'];
      final pagination = result['pagination'];

      if (searchType == "reset") {
        profileProvider.updateCommunityPosts(posts);
        profileProvider.updateMyWriteCommunityPage(pagination);
      } else if (searchType == "add") {
        profileProvider.addCommunityBoardPosts(posts);
        profileProvider.updateMyWriteCommunityPage(pagination);
      }
    });
  }
}
