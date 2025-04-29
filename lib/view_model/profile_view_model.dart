import 'package:flutter/material.dart';

import '../common/common_navigator.dart';
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
          root == "profile"
              ? commonNavigator.goRoute('/profile')
              : commonNavigator.goRoute('/');
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
}
