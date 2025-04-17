import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/provider/board/community_board_detail_provider.dart';
import 'package:app_front_talearnt/view/board/community_board/community_replies.dart';

class CommunityComment extends StatelessWidget {
  final CommunityBoardDetailProvider communityBoardDetailProvider;

  final Future<void> Function(int postNo, int lastNo) loadComments;

  const CommunityComment({
    Key? key,
    required this.communityBoardDetailProvider,
    required this.loadComments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comments = communityBoardDetailProvider.commentList;
    final hasNext = communityBoardDetailProvider.hasNext;

    return Column(
      children: [
        // 댓글 리스트
        ListView.builder(
          itemCount: comments.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final c = comments[index];
            final createdAt =
                DateFormat('yyyy.MM.dd HH:mm').format(c.createdAt);

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 작성자 + 시간 + 옵션
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 32,
                                      height: 32,
                                      child: SvgPicture.asset(
                                          'assets/img/profile.svg'),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          c.nickname,
                                          style: TextTypes.body02(
                                              color: Palette.text01),
                                        ),
                                        Text(
                                          createdAt,
                                          style: TextTypes.captionMedium02(
                                              color: Palette.text04),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: SvgPicture.asset(
                                      'assets/icons/kebab_menu.svg'),
                                ),
                              ],
                            ),

                            // 댓글 내용
                            Padding(
                              padding: const EdgeInsets.only(top: 8, left: 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    c.content,
                                    style: TextTypes.bodyMedium03(
                                        color: Palette.text02),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: SvgPicture.asset(
                                            'assets/icons/comment.svg'),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '답글 달기',
                                        style: TextTypes.captionMedium02(
                                            color: Palette.text04),
                                      ),
                                    ],
                                  ),

                                  // 답글 토글
                                  if (c.replyCount > 0)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: GestureDetector(
                                        onTap: () {
                                          communityBoardDetailProvider
                                              .toggleRepliesOpen(c.commentNo);
                                        },
                                        child: Container(
                                          width: 88,
                                          height: 36,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color:
                                                  communityBoardDetailProvider
                                                          .isRepliesOpen(
                                                              c.commentNo)
                                                      ? Palette.primary01
                                                      : Palette.icon03,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(999),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 12,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '답글 ${c.replyCount}개',
                                                  style:
                                                      communityBoardDetailProvider
                                                              .isRepliesOpen(
                                                                  c.commentNo)
                                                          ? TextTypes
                                                              .captionMedium02(
                                                                  color: Palette
                                                                      .primary01)
                                                          : TextTypes
                                                              .captionMedium02(
                                                                  color: Palette
                                                                      .text02),
                                                ),
                                                const SizedBox(width: 4),
                                                SizedBox(
                                                  width: 24,
                                                  height: 24,
                                                  child: SvgPicture.asset(
                                                    communityBoardDetailProvider
                                                            .isRepliesOpen(
                                                                c.commentNo)
                                                        ? 'assets/icons/chevron_up_before.svg'
                                                        : 'assets/icons/chevron_down_before.svg',
                                                    color:
                                                        communityBoardDetailProvider
                                                                .isRepliesOpen(
                                                                    c.commentNo)
                                                            ? Palette.icon01
                                                            : Palette.icon03,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (c.replyCount > 0 &&
                    communityBoardDetailProvider.isRepliesOpen(c.commentNo))
                  CommunityReplies(commentNo: c.commentNo),
                const Divider(color: Palette.bgUp02, height: 1, thickness: 1),
              ],
            );
          },
        ),

        if (hasNext)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: TextButton(
              onPressed: () {
                final lastNo =
                    comments.isNotEmpty ? comments.last.commentNo : 0;
                loadComments(
                    communityBoardDetailProvider
                        .communityDetailBoard.communityPostNo,
                    lastNo);
              },
              child: Text(
                '이전 댓글 보기',
                style: TextTypes.body02(color: Palette.primary01),
              ),
            ),
          ),
      ],
    );
  }
}
