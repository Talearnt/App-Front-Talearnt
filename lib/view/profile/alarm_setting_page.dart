import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/widget/custom_toggle.dart';
import '../../common/widget/top_app_bar.dart';
import '../../provider/profile/profile_provider.dart';

class AlarmSettingPage extends StatelessWidget {
  const AlarmSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
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
          content: '알림 설정',
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
                          Text('알림 전체 허용',
                              style: TextTypes.bodyMedium01(
                                  color: Palette.text01)),
                          Text('허용 시 푸시 알림으로 안내해드려요',
                              style: TextTypes.bodyMedium03(
                                  color: Palette.text03)),
                        ]),
                    CustomToggle(
                      value: profileProvider.allAlarm,
                      onChanged: (alarm) {
                        profileProvider.changeAllAlarm(alarm);
                      },
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Palette.bgUp01,
                thickness: 12.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('댓글 알림 허용',
                        style: TextTypes.bodyMedium01(color: Palette.text01)),
                    CustomToggle(
                      value: profileProvider.commentAlarm,
                      onChanged: (alarm) {
                        profileProvider.changeCommentAlarm(alarm);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('관심 키워드 알림 허용',
                        style: TextTypes.bodyMedium01(color: Palette.text01)),
                    CustomToggle(
                      value: profileProvider.keywordAlarm,
                      onChanged: (alarm) {
                        profileProvider.changeKeywordAlarm(alarm);
                      },
                    ),
                  ],
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
