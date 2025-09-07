import 'package:app_front_talearnt/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../common/theme.dart';
import '../../../provider/common/common_provider.dart';
import '../../../provider/profile/profile_provider.dart';
import '../no_event_notice_page.dart';

class NoticeTab extends StatelessWidget {
  final ProfileProvider profileProvider;

  const NoticeTab(this.profileProvider, {super.key});

  @override
  Widget build(BuildContext context) {
    final commonProvider = Provider.of<CommonProvider>(context);
    final profileViewModel = Provider.of<ProfileViewModel>(context);

    if (profileProvider.noticeList.isEmpty && !profileProvider.noticeHasNext) {
      return const NoEventNoticePage(type: 'notice');
    }

    return ListView.builder(
      controller: profileProvider.noticeScrollController,
      itemCount: profileProvider.noticeList.length +
          (profileProvider.noticeHasNext ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == profileProvider.noticeList.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final notice = profileProvider.noticeList[index];
        return Column(
          children: [
            InkWell(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              onTap: () async {
                commonProvider.changeIsLoading(true);
                await profileViewModel
                    .getNoticeDetail(notice.noticeNo)
                    .whenComplete(() => commonProvider.changeIsLoading(false));
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                decoration: const BoxDecoration(
                  color: Palette.bgBackGround,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          notice.noticeType,
                          style: TextTypes.captionMedium02(
                            color: Palette.primary01,
                          ),
                        ),
                        const SizedBox(width: 6),
                        SvgPicture.asset('assets/icons/devider.svg'),
                        const SizedBox(width: 6.5),
                        Text(
                          DateFormat('yy.MM.dd').format(notice.createdAt),
                          style: TextTypes.captionMedium02(
                            color: Palette.icon03,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      notice.title,
                      style: TextTypes.bodyMedium03(color: Palette.text01),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(color: Palette.line02, height: 1, thickness: 1),
          ],
        );
      },
    );
  }
}
