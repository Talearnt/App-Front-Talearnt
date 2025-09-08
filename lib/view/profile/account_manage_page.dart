import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/common_navigator.dart';
import '../../common/widget/button.dart';
import '../../common/widget/top_app_bar.dart';
import '../../data/services/secure_storage_service.dart';
import '../../provider/profile/profile_provider.dart';
import '../../view_model/auth_view_model.dart';

class AccountManagePage extends StatelessWidget {
  const AccountManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final commonNavigator = Provider.of<CommonNavigator>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);
    final secureStorageService = Provider.of<SecureStorageService>(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (!didPop) {
          if (context.mounted) {
            context.pop();
          }
        }
      },
      child: Scaffold(
        backgroundColor: Palette.bgBackGround,
        appBar: const TopAppBar(
          content: '계정관리',
          leftIcon: true,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('로그인한 계정',
                              style: TextTypes.bodyMedium01(
                                  color: Palette.text01)),
                          Text(profileProvider.userProfile.nickname,
                              style: TextTypes.bodyMedium03(
                                  color: Palette.text03)),
                        ]),
                    TextBtnXs(
                      content: '로그아웃',
                      onPressed: () {
                        commonNavigator.showDoubleDialog(
                          content: "정말 로그아웃 하시겠어요?",
                          leftText: '취소',
                          rightText: '로그아웃',
                          leftFun: () {
                            commonNavigator.goBack();
                          },
                          rightFun: () async {
                            final result = await authViewModel.logout();
                            result.fold(
                              (failure) {},
                              (value) {
                                profileProvider.clearAllProviders(context);
                                secureStorageService.delete(key: "kakao");
                                secureStorageService.delete(key: "email");
                                secureStorageService.delete(key: "password");
                                commonNavigator.goRoute('/login');
                              },
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
              const Divider(
                color: Palette.bgUp01,
                thickness: 12.0,
              ),
              InkWell(
                onTap: () {
                  context.push('/account-delete');
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('계정 탈퇴',
                          style:
                              TextTypes.captionMedium02(color: Palette.text04)),
                      SvgPicture.asset('assets/icons/chevron_right_before.svg'),
                    ],
                  ),
                ),
              ),
              const Divider(
                color: Palette.bgUp01,
                thickness: 1.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
