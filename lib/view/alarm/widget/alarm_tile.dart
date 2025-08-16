import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/data/model/respone/notification.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class AlarmTile extends StatelessWidget {
  final NotificationData alarm;

  const AlarmTile({super.key, required this.alarm});

  String _getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays < 90) {
      return '${difference.inDays}일 전';
    } else {
      return '90일 전';
    }
  }

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
                alarm.notificationType == '댓글' || alarm.notificationType == '답글'
                    ? "댓글"
                    : "관심 키워드",
                style: TextTypes.captionMedium02(color: Palette.primary01),
              ),
              const SizedBox(width: 6),
              SvgPicture.asset('assets/icons/devider.svg'),
              const SizedBox(width: 6.5),
              Text(
                _getRelativeTime(alarm.createdAt),
                style: TextTypes.captionMedium02(color: Palette.icon03),
              ),
            ],
          ),
          const SizedBox(height: 8),
          alarm.notificationType == '댓글'
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${alarm.senderNickname}님이 내 게시글에 댓글을 달았어요!',
                        style: TextTypes.bodyMedium03(color: Palette.text01)),
                    Text(
                      alarm.content,
                      style: TextTypes.bodyMedium03(color: Palette.text01),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              : alarm.notificationType == '답글'
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${alarm.senderNickname}님이 내 댓글에 답글을 달았어요!',
                            style:
                                TextTypes.bodyMedium03(color: Palette.text01)),
                        Text(
                          alarm.content,
                          style: TextTypes.bodyMedium03(color: Palette.text01),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )
                  : Container(), // 확인 필요
        ],
      ),
    );
  }
}
