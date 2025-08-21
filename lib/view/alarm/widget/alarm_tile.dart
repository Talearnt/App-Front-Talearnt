import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/constants/global_value_constants.dart';
import 'package:app_front_talearnt/data/model/respone/keyword_talent.dart';
import 'package:app_front_talearnt/data/model/respone/notification.dart';
import 'package:app_front_talearnt/provider/common/common_provider.dart';
import 'package:app_front_talearnt/view_model/board_view_model.dart';
import 'package:app_front_talearnt/view_model/notification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_svg/flutter_svg.dart';

class AlarmTile extends StatelessWidget {
  final NotificationData alarm;

  const AlarmTile({
    super.key,
    required this.alarm,
  });

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

  String _getTalentNames(List<int> codes) {
    final names = <String>[];

    for (final code in codes) {
      for (final category in GlobalValueConstants.keywordCategoris) {
        final match = category.talentKeywords.firstWhere((k) => k.code == code,
            orElse: () => KeywordTalent(code: -1, name: ''));
        if (match.code != -1) {
          names.add(match.name);
          break; // 찾으면 다음 코드로 넘어가기
        }
      }
    }

    return names.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final boardViewModel = Provider.of<BoardViewModel>(context);
    final notificationViewModel = Provider.of<NotificationViewModel>(context);
    final commonProvider = Provider.of<CommonProvider>(context);
    return GestureDetector(
      onTap: alarm.notificationType == '댓글' || alarm.notificationType == '답글'
          ? () async {
              commonProvider.changeIsLoading(true);
              if (!alarm.isRead) {
                await notificationViewModel
                    .readNotification([alarm.notificationNo]);
              }
              await boardViewModel.getCommunityDetailBoard(alarm.targetNo);
              await boardViewModel.getComments(alarm.targetNo, 0);
              commonProvider.changeIsLoading(false);
            }
          : alarm.notificationType == '관심 키워드'
              ? () async {
                  commonProvider.changeIsLoading(true);
                  if (!alarm.isRead) {
                    await notificationViewModel
                        .readNotification([alarm.notificationNo]);
                  }
                  await boardViewModel.getMatchDetailBoard(alarm.targetNo);
                  commonProvider.changeIsLoading(false);
                }
              : () {},
      child: Container(
        color: alarm.isRead ? Palette.bgBackGround : Palette.bgUp04,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  alarm.notificationType == '댓글' ||
                          alarm.notificationType == '답글'
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            alarm.content,
                            style:
                                TextTypes.bodyMedium03(color: Palette.text01),
                            overflow: TextOverflow.ellipsis,
                          ),
                          !alarm.isRead
                              ? Container(
                                  constraints: const BoxConstraints(
                                    minWidth: 23,
                                    minHeight: 24,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Palette.primary01,
                                    borderRadius: BorderRadius.circular(99),
                                  ),
                                  child: Text(
                                    '${alarm.unreadCount + 1}',
                                    style: TextTypes.captionMedium02(
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ],
                  )
                : alarm.notificationType == '답글'
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${alarm.senderNickname}님이 내 댓글에 답글을 달았어요!',
                              style: TextTypes.bodyMedium03(
                                  color: Palette.text01)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                alarm.content,
                                style: TextTypes.bodyMedium03(
                                    color: Palette.text01),
                                overflow: TextOverflow.ellipsis,
                              ),
                              !alarm.isRead
                                  ? Container(
                                      constraints: const BoxConstraints(
                                        minWidth: 23,
                                        minHeight: 24,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: Palette.primary01,
                                        borderRadius: BorderRadius.circular(99),
                                      ),
                                      child: Text(
                                        '${alarm.unreadCount + 1}',
                                        style: TextTypes.captionMedium02(
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ],
                      )
                    : alarm.notificationType == '관심 키워드'
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '\'${_getTalentNames(alarm.talentCodes)}\' 관련 매칭이 올라왔어요!',
                                  style: TextTypes.bodyMedium03(
                                      color: Palette.text01)),
                            ],
                          )
                        : Container(), // 확인 필요
          ],
        ),
      ),
    );
  }
}
