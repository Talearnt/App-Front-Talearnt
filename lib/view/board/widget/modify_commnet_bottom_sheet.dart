import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/provider/board/community_board_detail_provider.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/common_navigator.dart';

class ModifyCommnetBottomSheet extends StatelessWidget {
  final CommunityBoardDetailProvider communityBoardDetailProvider;
  final bool isMine;
  final bool isWriter;
  final int commentNo;

  const ModifyCommnetBottomSheet({
    super.key,
    required this.communityBoardDetailProvider,
    required this.isMine,
    required this.isWriter,
    required this.commentNo,
  });

  @override
  Widget build(BuildContext context) {
    final commonNavigator = Provider.of<CommonNavigator>(context);

    return Wrap(children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 44, top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              width: double.infinity,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {},
                child: Center(
                  child: Text(
                    "답글 달기",
                    style: TextTypes.body02(
                      color: Palette.text01,
                    ),
                  ),
                ),
              ),
            ),
            const Divider(
              color: Palette.line02,
            ),
            if (isMine) ...[
              SizedBox(
                height: 50,
                width: double.infinity,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: () async {
                    context.pop();
                    communityBoardDetailProvider.setEditComment(commentNo);
                  },
                  child: Center(
                    child: Text(
                      "수정하기",
                      style: TextTypes.body02(
                        color: Palette.text01,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Palette.line02,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: () {
                    if (context.mounted) {
                      context.pop();
                    }
                    commonNavigator.showDoubleDialog(
                        content: "정말 게시물을 삭제하시겠어요?\n삭제한 게시물은 되돌릴 수 없어요",
                        leftText: '취소',
                        rightText: '삭제',
                        leftFun: () {
                          commonNavigator.goBack();
                        },
                        rightFun: () async {});
                  },
                  child: Center(
                    child: Text(
                      "삭제하기",
                      style: TextTypes.body02(
                        color: Palette.error01,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Palette.line02,
              ),
            ] else if (isWriter) ...[
              SizedBox(
                height: 50,
                width: double.infinity,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: () {
                    if (context.mounted) {
                      context.pop();
                    }
                    commonNavigator.showDoubleDialog(
                        content: "정말 게시물을 삭제하시겠어요?\n삭제한 게시물은 되돌릴 수 없어요",
                        leftText: '취소',
                        rightText: '삭제',
                        leftFun: () {
                          commonNavigator.goBack();
                        },
                        rightFun: () async {});
                  },
                  child: Center(
                    child: Text(
                      "삭제하기",
                      style: TextTypes.body02(
                        color: Palette.error01,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Palette.line02,
              ),
            ] else
              ...[],
            SizedBox(
              height: 50,
              width: double.infinity,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  context.pop();
                },
                child: Center(
                  child: Text(
                    "취소",
                    style: TextTypes.body02(
                      color: Palette.text04,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
