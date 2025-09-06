import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common/widget/button.dart';
import '../../common/widget/top_app_bar.dart';
import '../../provider/profile/profile_provider.dart';

class NoticeDetailPage extends StatelessWidget {
  const NoticeDetailPage({super.key});

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
          content: '공지사항',
          leftIcon: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        profileProvider.noticeDetail.noticeType,
                        style: TextTypes.captionMedium02(
                          color: Palette.primary01,
                        ),
                      ),
                      const SizedBox(width: 6),
                      SvgPicture.asset('assets/icons/devider.svg'),
                      const SizedBox(width: 6.5),
                      Text(
                        DateFormat('yy.MM.dd')
                            .format(profileProvider.noticeDetail.createdAt),
                        style: TextTypes.captionMedium02(
                          color: Palette.icon03,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    profileProvider.noticeDetail.title,
                    style: TextTypes.body02(
                      color: Palette.text01,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Palette.line02, height: 1, thickness: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Text(
                profileProvider.noticeDetail.content,
                style: TextTypes.bodyMedium03(
                  color: Palette.text02,
                ),
              ),
            ),
            const SizedBox(height: 64),
            Center(
              child: PrimaryXs(
                type: 'B',
                content: '목록으로',
                onPressed: () {
                  if (context.mounted) {
                    context.pop();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
