import 'package:app_front_talearnt/provider/profile/profile_provider.dart';
import 'package:app_front_talearnt/view/board/widget/modify_comment_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/provider/board/community_board_detail_provider.dart';

class CommunityReplies extends StatelessWidget {
  final int commentNo;
  final CommunityBoardDetailProvider communityBoardDetailProvider;
  final ProfileProvider profileProvider;
  final Future<void> Function(int commentNo, int lastNo) loadReplies;

  final BuildContext detailPageContext;

  const CommunityReplies({
    Key? key,
    required this.commentNo,
    required this.communityBoardDetailProvider,
    required this.profileProvider,
    required this.loadReplies,
    required this.detailPageContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final replies = communityBoardDetailProvider.getReplies(commentNo);
    final hasNext = communityBoardDetailProvider.hasNextReplies(commentNo);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (hasNext)
          Container(
            padding: const EdgeInsets.only(top: 16, bottom: 16, left: 64),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  final lastNo = replies.isNotEmpty ? replies.first.replyNo : 0;
                  loadReplies(commentNo, lastNo);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  '이전 댓글 보기...',
                  style: TextTypes.captionMedium02(color: Palette.text03),
                ),
              ),
            ),
          ),
        ListView.builder(
          itemCount: replies.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, idx) {
            final r = replies[idx];
            final formatted =
                DateFormat('yyyy.MM.dd HH:mm').format(r.createdAt);
            final hasImage = (r.profileImg?.isNotEmpty ?? false);

            return Container(
              color: profileProvider.userProfile.userNo == r.userNo
                  ? Palette.bgUp01
                  : null,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 64,
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
                              child: hasImage
                                  ? Image.network(
                                      r.profileImg!,
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
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(r.nickname,
                                    style: TextTypes.body02(
                                        color: Palette.text01)),
                                Text(formatted,
                                    style: TextTypes.captionMedium02(
                                        color: Palette.text04)),
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
                              builder: (BuildContext context) {
                                return ModifyCommentBottomSheet(
                                  type: "reply",
                                  communityBoardDetailProvider:
                                      communityBoardDetailProvider,
                                  isMine: profileProvider.userProfile.userNo ==
                                      r.userNo,
                                  isWriter:
                                      profileProvider.userProfile.userNo ==
                                          communityBoardDetailProvider
                                              .communityDetailBoard.userNo,
                                  commentNo: r.commentNo,
                                  replyNo: r.replyNo,
                                  detailPageContext: detailPageContext,
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
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(r.content,
                              style: TextTypes.bodyMedium03(
                                  color: Palette.text02)),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: () {
                              communityBoardDetailProvider
                                  .setInsertReplies(r.commentNo);
                            },
                            child: Row(
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
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
