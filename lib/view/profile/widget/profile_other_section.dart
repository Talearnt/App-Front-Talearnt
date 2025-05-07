import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/theme.dart';
import 'create_setting_menu.dart';

class ProfileOtherSection extends StatelessWidget {
  const ProfileOtherSection({super.key});

  @override
  Widget build(BuildContext context) {
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
          onTap: () {
            context.push('/event-notice');
          },
        ),
        CreateSettingMenu(
          iconPath: 'assets/icons/send.svg',
          title: '문의하기',
          onTap: () {
            // 문의하기 페이지 이동
          },
        ),
      ],
    );
  }
}
