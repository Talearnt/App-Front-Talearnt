import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/provider/board/community_board_detail_provider.dart';

class CommunityReplies extends StatelessWidget {
  final int commentNo;
  final CommunityBoardDetailProvider provider;
  final Future<void> Function(int commentNo, int lastNo) loadReplies;

  const CommunityReplies({
    Key? key,
    required this.commentNo,
    required this.provider,
    required this.loadReplies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final replies = provider.getReplies(commentNo);
    final hasNext = provider.hasNextReplies(commentNo);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListView.builder(
          itemCount: replies.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, idx) {
            final r = replies[idx];
            final formatted =
                DateFormat('yyyy.MM.dd HH:mm').format(r.createdAt);

            return Padding(
              padding: const EdgeInsets.only(
                left: 56,
                top: 16,
                bottom: 8,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 32,
                            height: 32,
                            child: SvgPicture.asset('assets/img/profile.svg'),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(r.nickname,
                                  style:
                                      TextTypes.body02(color: Palette.text01)),
                              Text(formatted,
                                  style: TextTypes.captionMedium02(
                                      color: Palette.text04)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: SvgPicture.asset('assets/icons/kebab_menu.svg'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(r.content,
                            style:
                                TextTypes.bodyMedium03(color: Palette.text02)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            SizedBox(
                              width: 18,
                              height: 18,
                              child: SvgPicture.asset(
                                'assets/icons/comment.svg',
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text('답글 달기',
                                style: TextTypes.captionMedium02(
                                    color: Palette.text04)),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
        if (hasNext)
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  bottom: 16,
                  left: 96,
                ),
                child: GestureDetector(
                  onTap: () {
                    final lastNo =
                        replies.isNotEmpty ? replies.last.replyNo : 0;
                    loadReplies(commentNo, lastNo);
                  },
                  child: Container(
                    width: 90,
                    height: 36,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Palette.icon03,
                      ),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '답글 더보기',
                            style: TextTypes.captionMedium02(
                                color: Palette.text02),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
