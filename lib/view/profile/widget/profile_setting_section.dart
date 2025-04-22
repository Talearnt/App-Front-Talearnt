import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/theme.dart';
import 'create_setting_menu.dart';

class ProfileSettingSection extends StatelessWidget {
  const ProfileSettingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
          child:
              Text('설정', style: TextTypes.bodyMedium03(color: Palette.text03)),
        ),
        CreateSettingMenu(
          iconPath: 'assets/icons/setting.svg',
          title: '계정 관리',
          onTap: () {
            context.push('/account-manage');
          },
        ),
        CreateSettingMenu(
          iconPath: 'assets/icons/bell.svg',
          title: '알림 설정',
          onTap: () {
            context.push('/alarm-setting');
          },
        ),
        CreateSettingMenu(
          iconPath: 'assets/icons/license.svg',
          title: '라이센스',
          onTap: () {
            // 라이센스 정보 이동
          },
        ),
        CreateSettingMenu(
          iconPath: 'assets/icons/bell.svg',
          title: '업데이트',
          onTap: () {
            // 업데이트 정보 이동
          },
        ),
      ],
    );
  }
}
