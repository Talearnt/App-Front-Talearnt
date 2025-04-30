import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/default_text_field.dart';
import 'package:app_front_talearnt/common/widget/toast_message.dart';
import 'package:app_front_talearnt/provider/board/community_board_detail_provider.dart';
import 'package:flutter/material.dart';

class CommunityDetailBoardCommentInput extends StatelessWidget {
  final CommunityBoardDetailProvider communityBoardDetailProvider;
  final Future<void> Function(int postNo, String content) insertComment;

  const CommunityDetailBoardCommentInput({
    super.key,
    required this.communityBoardDetailProvider,
    required this.insertComment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Palette.line02, width: 1),
          bottom: BorderSide(color: Palette.line02, width: 1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 20,
          right: 18,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: communityBoardDetailProvider.commentController,
                focusNode: communityBoardDetailProvider.commentFocusNode,
                style: TextTypes.body02(
                  color: Palette.text01,
                ),
                decoration: InputDecoration(
                  hintText: '댓글을 남겨보세요!',
                  hintStyle: TextTypes.body02(
                    color: Palette.text04,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            PrimaryXs(
              content: '등록',
              type: "B",
              onPressed: () {
                insertComment(
                  communityBoardDetailProvider
                      .communityDetailBoard.communityPostNo,
                  communityBoardDetailProvider.commentController.text,
                ).then(
                  (value) {
                    ToastMessage.show(
                      context: context,
                      message: "댓글이 등록되었습니다.",
                      type: 1,
                      bottom: 50,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
