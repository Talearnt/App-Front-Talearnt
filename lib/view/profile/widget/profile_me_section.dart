import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../common/theme.dart';
import 'create_setting_menu.dart';

class ProfileMeSection extends StatelessWidget {
  const ProfileMeSection({super.key});

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
          iconPath: 'assets/icons/bookmark_off.svg',
          title: '찜 목록',
          onTap: () {
            context.go('/match_board_like');
          },
        ),
        CreateSettingMenu(
          iconPath: 'assets/icons/post_off.svg',
          title: '작성한 게시물',
          onTap: () {
            // 작성한 게시물 이동
          },
        ),
        CreateSettingMenu(
          iconPath: 'assets/icons/comment.svg',
          title: '작성한 댓글',
          onTap: () {
            // 작성한 댓글 이동
          },
        ),
      ],
    );
  }
}
