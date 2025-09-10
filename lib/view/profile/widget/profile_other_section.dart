import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:app_front_talearnt/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/common_navigator.dart';
import '../../../common/theme.dart';
import 'create_setting_menu.dart';

class ProfileOtherSection extends StatelessWidget {
  const ProfileOtherSection({super.key});

  @override
  Widget build(BuildContext context) {
    final commonProvider = context.read<CommonProvider>();
    final profileViewModel = Provider.of<ProfileViewModel>(context);
    final commonNavigator = Provider.of<CommonNavigator>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
          child:
          Text('기타', style: TextTypes.bodyMedium03(color: Palette.text03)),
        ),
        CreateSettingMenu(
          iconPath: 'assets/icons/notice.svg',
          title: '이벤트/공지사항',
          onTap: () async {
            commonProvider.changeIsLoading(true);
            await profileViewModel.getEvent();
            await profileViewModel.getNotice();
            commonProvider.changeIsLoading(false);
            context.push('/event-notice');
          },
        ),
        CreateSettingMenu(
          iconPath: 'assets/icons/send.svg',
          title: '문의하기',
          onTap: () async {
            final Email email = Email(
              body: '''
* 아래 양식에 맞춰 내용을 작성해 주시면 더 빠르고 정확한 답변을 드릴 수 있습니다.
-------------------
1) 사용중인 닉네임:
2) 답변 받으실 이메일 주소:
3) 문의 종류 (예: 제휴 문의, 서비스 개선 제안, 기타 의견):
- 문의 내용:
-------------------
''',
              subject: '[Talearnt 문의]',
              recipients: ['woong9421@nate.com'],
              cc: [],
              bcc: [],
              attachmentPaths: [],
              isHTML: false,
            );

            try {
              await FlutterEmailSender.send(email);
            } catch (error) {
              commonNavigator.showSingleDialog(
                  content:
                  "메일 앱을 열 수 없습니다.\n 아래 메일로 문의 부탁드립니다!\nwoong9421@nate.com");
            }
          },
        ),
      ],
    );
  }
}
