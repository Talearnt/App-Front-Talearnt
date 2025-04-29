import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/theme.dart';
import '../../../constants/global_value_constants.dart';
import '../../../provider/profile/profile_provider.dart';

class ProfileUserInfo extends StatelessWidget {
  const ProfileUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CircleAvatar(
            radius: 52,
            backgroundImage: profileProvider.userProfile.profileImg == ""
                ? null
                : NetworkImage(profileProvider.userProfile.profileImg)
                    as ImageProvider,
            child: profileProvider.userProfile.profileImg == ""
                ? SvgPicture.asset(
                    'assets/img/default_user_image.svg',
                    width: 104,
                    height: 104,
                  )
                : null,
          ),
          const SizedBox(height: 10),
          Center(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${profileProvider.userProfile.nickname} ',
                    style: TextTypes.heading4(color: Palette.text01),
                  ),
                  TextSpan(
                    text: '님,',
                    style: TextTypes.bodyMedium01(color: Palette.text01),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Text(
              '오늘도 좋은 하루 되세요 ♥',
              style: TextTypes.body02(color: Palette.text02),
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
                  padding: const EdgeInsets.all(16),
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
                        children:
                            profileProvider.userProfile.giveTalents.map((item) {
                          String labelText = '';
                          for (var category
                              in GlobalValueConstants.keywordCategoris) {
                            if (category.talentKeywords
                                .any((talent) => talent.code == item)) {
                              var data = category.talentKeywords
                                  .firstWhere((talent) => talent.code == item);
                              labelText = data.name;
                              break;
                            }
                          }
                          return Padding(
                            padding: const EdgeInsets.only(right: 8, bottom: 8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              decoration: const BoxDecoration(
                                color: Palette.primaryBG01,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                              ),
                              child: Text(labelText,
                                  style: TextTypes.bodyMedium03(
                                      color: Palette.primary01)),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 12),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: Palette.line02,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "받고 싶은 나의 재능",
                        style: TextTypes.bodyMedium03(
                          color: Palette.text01,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        children: profileProvider.userProfile.receiveTalents
                            .map((item) {
                          String labelText = '';
                          for (var category
                              in GlobalValueConstants.keywordCategoris) {
                            if (category.talentKeywords
                                .any((talent) => talent.code == item)) {
                              var data = category.talentKeywords
                                  .firstWhere((talent) => talent.code == item);
                              labelText = data.name;
                              break;
                            }
                          }
                          return Padding(
                            padding: const EdgeInsets.only(right: 8, bottom: 8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              decoration: const BoxDecoration(
                                color: Palette.bgUp02,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                              ),
                              child: Text(labelText,
                                  style: TextTypes.bodyMedium03(
                                      color: Palette.text02)),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.bgUp01,
                      shadowColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                    ),
                    onPressed: () {
                      profileProvider.setUserEditProfile();
                      context.push('/modify-user-info');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/edit_my.svg'),
                        Text(
                          '프로필 수정',
                          style: TextTypes.caption01(color: Palette.text03),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
