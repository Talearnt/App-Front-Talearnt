import 'package:app_front_talearnt/provider/profile/profile_provider.dart';
import 'package:app_front_talearnt/view/board/widget/modify_comment_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/provider/board/community_board_detail_provider.dart';
import 'package:app_front_talearnt/view/board/community_board/community_replies.dart';

class CommunityComments extends StatelessWidget {
  final CommunityBoardDetailProvider communityBoardDetailProvider;
  final ProfileProvider profileProvider;

  final Future<void> Function(int postNo, int lastNo) loadComments;
  final Future<void> Function(int commentNo, int lastNo) loadReplies;

  final BuildContext detailPageContext;

  const CommunityComments({
    Key? key,
    required this.communityBoardDetailProvider,
    required this.profileProvider,
    required this.loadComments,
    required this.loadReplies,
    required this.detailPageContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comments = communityBoardDetailProvider.commentList;
    final hasNext = communityBoardDetailProvider.hasNext;

    return Column(
      children: [
        if (hasNext)
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Palette.line02,
                  width: 1.0,
                ),
              ),
            ),
            padding: const EdgeInsets.only(top: 16, bottom: 16, left: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  final lastNo =
                      comments.isNotEmpty ? comments.first.commentNo : 0;
                  loadComments(
                    communityBoardDetailProvider
                        .communityDetailBoard.communityPostNo,
                    lastNo,
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  '이전 댓글 보기...',
                  style: TextTypes.captionMedium02(color: Palette.text01),
                ),
              ),
            ),
          ),
        ListView.builder(
          itemCount: comments.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final c = comments[index];

            // 1) isDeleted == true && replyCount == 0 이면 렌더링하지 않음
            if (c.isDeleted && c.replyCount == 0) {
              return const SizedBox.shrink();
            }

            // 2) isDeleted == true && replyCount > 0 일 때
            final isDeletedOnly = c.isDeleted && c.replyCount > 0;

            // 댓글 작성 시간 포맷
            final createdAt =
                DateFormat('yyyy.MM.dd HH:mm').format(c.createdAt);
            final hasImage = (c.profileImg?.isNotEmpty ?? false);

            return Column(
              children: [
                Container(
                  color: profileProvider.userProfile.userNo == c.userNo
                      ? Palette.bgUp01
                      : null,
                  child: Padding(
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
                              // ── 댓글 헤더 (작성자, 시간, 메뉴) ──────────────────────
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      hasImage
                                          ? Image.network(
                                              c.profileImg!,
                                              width: 32,
                                              height: 32,
                                              fit: BoxFit.cover,
                                              errorBuilder: (_, __, ___) {
                                                return SvgPicture.asset(
                                                  'assets/img/profile.svg',
                                                  width: 32,
                                                  height: 32,
                                                );
                                              },
                                            )
                                          : SizedBox(
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
                                          // 작성자가 삭제한 댓글일 때는 닉네임과 시간이 필요 없을 수도 있지만,
                                          // 디자인에 따라 그대로 둡니다.
                                          Text(
                                            isDeletedOnly
                                                ? '삭제된 댓글'
                                                : c.nickname,
                                            style: TextTypes.body02(
                                                color: Palette.text01),
                                          ),
                                          if (!isDeletedOnly)
                                            Text(
                                              createdAt,
                                              style: TextTypes.captionMedium02(
                                                  color: Palette.text04),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(24),
                                          ),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        builder: (BuildContext sheetCtx) {
                                          return ModifyCommentBottomSheet(
                                            type: "comment",
                                            communityBoardDetailProvider:
                                                communityBoardDetailProvider,
                                            isMine: profileProvider
                                                    .userProfile.userNo ==
                                                c.userNo,
                                            isWriter: profileProvider
                                                    .userProfile.userNo ==
                                                communityBoardDetailProvider
                                                    .communityDetailBoard
                                                    .userNo,
                                            commentNo: c.commentNo,
                                            detailPageContext:
                                                detailPageContext,
                                          );
                                        },
                                      );
                                    },
                                    child: SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: SvgPicture.asset(
                                        'assets/icons/kebab_menu.svg',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              // ── 댓글 본문 ──────────────────────
                              if (!isDeletedOnly)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, left: 40),
                                  child: Text(
                                    c.content,
                                    style: TextTypes.bodyMedium03(
                                        color: Palette.text02),
                                  ),
                                ),

                              // ── 삭제된 댓글이지만 답글이 있는 경우 메시지 표시 ──────────────────────
                              if (isDeletedOnly)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, left: 40),
                                  child: Text(
                                    '글쓴이가 삭제한 댓글입니다.',
                                    style: TextTypes.bodyMedium03(
                                        color: Palette.text04),
                                  ),
                                ),

                              // ── 답글 달기 버튼 (삭제된 댓글에서는 보이지 않아도 됩니다) ──────────────────────
                              if (!c.isDeleted)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, left: 40),
                                  child: InkWell(
                                    onTap: () {
                                      communityBoardDetailProvider
                                          .setInsertReplies(c.commentNo);
                                    },
                                    child: Row(
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
                                  ),
                                ),

                              // ── 답글 토글 버튼 ──────────────────────
                              if (c.replyCount > 0)
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: GestureDetector(
                                    onTap: () {
                                      final isOpen =
                                          communityBoardDetailProvider
                                              .isRepliesOpen(c.commentNo);

                                      if (!isOpen) {
                                        loadReplies(c.commentNo, 0);
                                      }

                                      communityBoardDetailProvider
                                          .toggleRepliesOpen(c.commentNo);
                                    },
                                    child: Container(
                                      width: 93,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: communityBoardDetailProvider
                                                  .isRepliesOpen(c.commentNo)
                                              ? Palette.primary01
                                              : Palette.icon03,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(999),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          left: 12,
                                          right: 6,
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
                                            const SizedBox(width: 2),
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
                ),

                // ── Nested Replies ──────────────────────
                if (c.replyCount > 0 &&
                    communityBoardDetailProvider.isRepliesOpen(c.commentNo))
                  CommunityReplies(
                    commentNo: c.commentNo,
                    communityBoardDetailProvider: communityBoardDetailProvider,
                    profileProvider: profileProvider,
                    loadReplies: loadReplies,
                    detailPageContext: detailPageContext,
                  ),

                const Divider(color: Palette.bgUp02, height: 1, thickness: 1),
              ],
            );
          },
        )
      ],
    );
  }
}
