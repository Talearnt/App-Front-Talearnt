import 'package:app_front_talearnt/view/profile/widget/profile_me_section.dart';
import 'package:app_front_talearnt/view/profile/widget/profile_other_section.dart';
import 'package:app_front_talearnt/view/profile/widget/profile_setting_section.dart';
import 'package:app_front_talearnt/view/profile/widget/profile_user_Info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/theme.dart';
import '../../common/widget/button.dart';
import '../../common/widget/common_bottom_navigation_bar.dart';
import '../../provider/auth/login_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 1,
                            bottom: 1,
                            left: 8,
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/default_logo.svg',
                            width: 112,
                            height: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  loginProvider.isLoggedIn
                      ? const ProfileUserInfo()
                      : Column(
                          children: [
                            const Divider(
                              thickness: 1,
                              height: 1,
                              color: Palette.line02,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "단 3초! 로그인하고 확인해보세요",
                                      style: TextTypes.captionMedium02(
                                        color: Palette.text02,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          text: '회원',
                                          style: TextTypes.bodySemi01(
                                            color: Palette.primary01,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '님을 위한 맞춤 매칭',
                                              style: TextTypes.bodySemi01(
                                                color: Palette.text01,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      PrimaryS(
                                        content: "로그인",
                                        onPressed: () async {
                                          await loginProvider
                                              .changeRoot('profile');
                                          context.go("/login");
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                  const Divider(
                    color: Palette.bgUp01,
                    thickness: 12.0,
                  ),
                  const ProfileMeSection(),
                  const SizedBox(height: 8),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Palette.line02,
                  ),
                  const SizedBox(height: 4),
                  const ProfileSettingSection(),
                  const SizedBox(height: 8),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Palette.line02,
                  ),
                  const SizedBox(height: 4),
                  const ProfileOtherSection(),
                  const SizedBox(height: 8),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Palette.line02,
                  ),
                ],
              ),
            ),
            const CommonBottomNavigationBar()
          ],
        ),
      ),
    );
  }
}
