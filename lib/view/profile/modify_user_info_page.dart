import 'dart:io';

import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:app_front_talearnt/view/profile/widget/profile_edit_image_bottom_sheet.dart';
import 'package:app_front_talearnt/view/profile/widget/profile_edit_talent_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/theme.dart';
import '../../common/widget/button.dart';
import '../../common/widget/default_text_field.dart';
import '../../common/widget/toast_message.dart';
import '../../common/widget/top_app_bar.dart';
import '../../constants/global_value_constants.dart';
import '../../provider/profile/profile_provider.dart';
import '../../view_model/profile_view_model.dart';

class ModifyUserInfoPage extends StatelessWidget {
  const ModifyUserInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final profileViewModel = Provider.of<ProfileViewModel>(context);
    final commonProvider = Provider.of<CommonProvider>(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (!didPop) {
          if (context.mounted) {
            profileProvider.resetModifyProfile();
            context.pop();
          }
        }
      },
      child: Scaffold(
        appBar: TopAppBar(
          content: "프로필 수정",
          first: TextBtnM(
              content: '저장',
              btnStyle: TextTypes.body02(color: Palette.primary01),
              onPressed: () async {
                final bool isSuccess;
                commonProvider.changeIsLoading(true);
                await profileProvider.getUploadImagesInfo();

                if (profileProvider.changeImage) {
                  await profileViewModel.getUserImageUploadUrl(
                      profileProvider.uploadUserImageInfo);

                  await profileViewModel.uploadImage(
                    profileProvider.imageUploadS3Url,
                    profileProvider.uploadUserImageInfo["file"],
                    profileProvider.uploadUserImageInfo["fileSize"],
                    profileProvider.uploadUserImageInfo["fileType"],
                  );

                  isSuccess = await profileViewModel.editUserInfo(
                      profileProvider.editImageUploadUrl,
                      profileProvider.editNickNameController.text,
                      profileProvider.giveTalents,
                      profileProvider.receiveTalents);
                } else {
                  isSuccess = await profileViewModel.editUserInfo(
                      profileProvider.imageFile == null
                          ? null
                          : profileProvider.imageFile as String,
                      profileProvider.editNickNameController.text,
                      profileProvider.giveTalents,
                      profileProvider.receiveTalents);
                }
                commonProvider.changeIsLoading(false);

                if (isSuccess) {
                  ToastMessage.show(
                    context: context,
                    message: "프로필이 수정되었습니다.",
                    type: 1,
                    bottom: 50,
                  );
                  context.go('/profile');
                }
              }),
          onPressed: () {
            profileProvider.resetModifyProfile();
            context.pop();
          },
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 52,
                        backgroundImage: profileProvider.imageFile == null ||
                                profileProvider.imageFile == ""
                            ? null
                            : profileProvider.imageFile is String
                                ? NetworkImage(
                                    profileProvider.imageFile as String)
                                : FileImage(profileProvider.imageFile as File)
                                    as ImageProvider,
                        child: profileProvider.imageFile == null ||
                                profileProvider.imageFile == ""
                            ? SvgPicture.asset(
                                'assets/img/default_user_image.svg',
                                width: 104,
                                height: 104,
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                builder: (_) {
                                  return const ProfileImageBottomSheet();
                                });
                          },
                          child: SizedBox(
                              width: 32,
                              height: 32,
                              child: SvgPicture.asset(
                                  'assets/icons/profile_image_edit.svg')),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Text(
                    '닉네임',
                    style: TextTypes.bodyMedium03(color: Palette.text01),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: DefaultTextField(
                    type: 'default',
                    hint: '닉네임을 입력해주세요',
                    textEditingController:
                        profileProvider.editNickNameController,
                    onChanged: (value) {
                      profileProvider.updateController(
                          profileProvider.editNickNameController);
                    },
                    provider: profileProvider,
                    validType: 'nickName',
                    focusNode: profileProvider.editNickNameFocusNode,
                    validFunc: profileProvider.updateEditNickNameInfoValid,
                    validMessage: profileProvider.editNickNameValidMessage,
                    isValid: profileProvider.editNickNameHelper,
                    isInfo: profileProvider.isEditNickNameInfo,
                    isInfoValid: profileProvider.isEditNickNameInfoValid,
                    infoMessage: profileProvider.editNickNameInfoMessage,
                    infoValidMessage:
                        profileProvider.editNickNameInfoValidMessage,
                    infoType: profileProvider.editNickNameInfoType,
                    infoFunc: profileProvider.updateEditNickNameInfo,
                    onServerCheck:
                        profileViewModel.checkEditNickNameDuplication,
                    helperType: profileProvider.editNickNameHelperType,
                  ),
                ),
                const SizedBox(height: 28),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: Palette.line02,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "주고 싶은 나의 재능",
                              style: TextTypes.bodyMedium03(
                                color: Palette.text01,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              children: [
                                ...profileProvider.giveTalents.map((item) {
                                  String labelText = '';
                                  int labelCode = -1;
                                  for (var category in GlobalValueConstants
                                      .keywordCategoris) {
                                    if (category.talentKeywords
                                        .any((talent) => talent.code == item)) {
                                      var data = category.talentKeywords
                                          .firstWhere(
                                              (talent) => talent.code == item);
                                      labelText = data.name;
                                      labelCode = data.code;
                                      break;
                                    }
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Chip(
                                      label: Text(labelText),
                                      deleteIcon: SvgPicture.asset(
                                          'assets/icons/chips_close.svg'),
                                      onDeleted: () {
                                        profileProvider
                                            .removeGiveTalentsList(labelCode);
                                      },
                                      backgroundColor: Palette.bgUp02,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        side: const BorderSide(
                                          color: Palette.bgUp02,
                                          width: 0,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: SvgPicture.asset(
                                    'assets/icons/add_square.svg',
                                    width: 36,
                                    height: 36,
                                  ),
                                  onPressed: () async {
                                    profileProvider.updateEditGiveTalentsList(
                                        profileProvider.giveTalents);
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(24),
                                        ),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      builder: (BuildContext context) {
                                        return const ProfileEditTalentBottomSheet(
                                          editType: 'give',
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "받고 싶은 나의 재능",
                              style: TextTypes.bodyMedium03(
                                color: Palette.text01,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              children: [
                                ...profileProvider.receiveTalents.map((item) {
                                  String labelText = '';
                                  int labelCode = -1;
                                  for (var category in GlobalValueConstants
                                      .keywordCategoris) {
                                    if (category.talentKeywords
                                        .any((talent) => talent.code == item)) {
                                      var data = category.talentKeywords
                                          .firstWhere(
                                              (talent) => talent.code == item);
                                      labelText = data.name;
                                      labelCode = data.code;
                                      break;
                                    }
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Chip(
                                      label: Text(labelText),
                                      deleteIcon: SvgPicture.asset(
                                          'assets/icons/chips_close.svg'),
                                      onDeleted: () {
                                        profileProvider
                                            .removeGiveTalentsList(labelCode);
                                      },
                                      backgroundColor: Palette.bgUp02,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        side: const BorderSide(
                                          color: Palette.bgUp02,
                                          width: 0,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: SvgPicture.asset(
                                    'assets/icons/add_square.svg',
                                    width: 36,
                                    height: 36,
                                  ),
                                  onPressed: () async {
                                    profileProvider
                                        .updateEditReceiveTalentsList(
                                            profileProvider.receiveTalents);
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(24),
                                        ),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      builder: (BuildContext context) {
                                        return const ProfileEditTalentBottomSheet(
                                          editType: 'receive',
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
