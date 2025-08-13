import 'package:flutter/material.dart';

import '../../../common/theme.dart';
import '../../../data/model/respone/notification.dart';

class AlarmTile extends StatelessWidget {
  final NotificationData alarm;

  const AlarmTile({super.key, required this.alarm});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: alarm.isRead ? Palette.bgBackGround : Palette.bgUp04,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                alarm.notificationType,
                style: TextTypes.captionMedium02(color: Palette.primary01),
              ),
              const Text(
                ' · ',
                style: TextStyle(color: Palette.icon03),
              ),
              Text(
                formatTime(alarm.createdAt),
                style: TextTypes.captionMedium02(color: Palette.icon03),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // alarm.notificationType == '댓글'
          //     ? Text(
          //         '${alarm.senderNickname}님이 ',
          //         style: const TextStyle(fontSize: 14),
          //       )
          //     : Container(),// 확인 필요
          Text(
            alarm.content,
            style: TextTypes.bodyMedium03(color: Palette.text01),
          ),
        ],
      ),
    );
  }

  String formatTime(DateTime createdAt) {
    final diff = DateTime.now().difference(createdAt);

    if (diff.inMinutes < 1) {
      return '방금 전';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}분 전';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}시간 전';
    } else {
      return '${diff.inDays}일 전';
    }
  }
}
