import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/theme.dart';
import '../../../provider/profile/profile_provider.dart';
import '../no_event_notice_page.dart';

class EventTab extends StatelessWidget {
  final ProfileProvider profileProvider;

  const EventTab(this.profileProvider, {super.key});

  @override
  Widget build(BuildContext context) {
    if (profileProvider.eventList.isEmpty && !profileProvider.eventHasNext) {
      return const NoEventNoticePage(type: 'event');
    }

    return ListView.builder(
      controller: profileProvider.eventScrollController,
      itemCount: profileProvider.eventList.length +
          (profileProvider.eventHasNext ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == profileProvider.eventList.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final event = profileProvider.eventList[index];
        return Column(
          children: [
            Image.network(
              event.bannerUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (_, __, ___) => const SizedBox(
                height: 200,
                child: Center(child: Icon(Icons.broken_image)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    event.isActive ? "진행 중" : "종료",
                    style: TextTypes.caption01(
                      color:
                          event.isActive ? Palette.primary01 : Palette.text03,
                    ),
                  ),
                  Text(
                    "${DateFormat('yy.MM.dd').format(event.startDate)}"
                    "-${DateFormat('yy.MM.dd').format(event.endDate)}",
                    style: TextTypes.caption01(color: Palette.text03),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
